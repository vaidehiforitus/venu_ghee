import 'package:dio/dio.dart';
import 'package:venu_ghee/core/constants/app_constants.dart';
import 'package:venu_ghee/core/error/error_mapper.dart';
import 'package:venu_ghee/core/services/auth_service.dart';

class ApiInterceptors extends Interceptor {
  final AuthService authService;
  bool _isRefreshing = false;
  final List<RequestOptions> _pendingRequests = [];

  ApiInterceptors(this.authService);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await authService.getAccessToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == AppConstants.statusUnauthorized) {
      if (_isRefreshing) {
        // Queue the request if a refresh is already in progress
        _pendingRequests.add(err.requestOptions);
        return;
      }

      _isRefreshing = true;
      try {
        final newToken = await authService.refreshToken();
        if (newToken != null) {
          // Update the original request with the new token
          err.requestOptions.headers['Authorization'] = 'Bearer $newToken';

          // Retry all pending requests
          for (var request in _pendingRequests) {
            request.headers['Authorization'] = 'Bearer $newToken';
            final response = await Dio().fetch(request);
            handler.resolve(response);
          }
          _pendingRequests.clear();

          // Retry the original request
          return handler.resolve(await Dio().fetch(err.requestOptions));
        } else {
          // No new token, reject all pending requests
          for (var request in _pendingRequests) {
            handler.reject(DioException(
              requestOptions: request,
              error: 'Token refresh failed',
              type: DioExceptionType.badResponse,
            ));
          }
          _pendingRequests.clear();
        }
      } catch (e) {
        // Token refresh failed, reject all pending requests
        for (var request in _pendingRequests) {
          handler.reject(DioException(
            requestOptions: request,
            error: 'Token refresh failed: $e',
            type: DioExceptionType.badResponse,
          ));
        }
        _pendingRequests.clear();
      } finally {
        _isRefreshing = false;
      }
    }

    // Map error using ErrorMapper for non-401 errors
    final failure = ErrorMapper.mapDioException(err);
    final dioError = DioException(
      requestOptions: err.requestOptions,
      response: err.response,
      type: err.type,
      error: err.error,
      message: failure.message,
    );
    return handler.reject(dioError);
  }
}