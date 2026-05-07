import 'package:dio/dio.dart';
import 'package:venu_ghee/core/constants/app_constants.dart';
import 'package:venu_ghee/core/error/api_error_model.dart';
import 'failures.dart';

class ErrorMapper {
  static Failure mapDioException(DioException dioException) {
    int? statusCode = dioException.response?.statusCode;

    String message = 'Unknown error';

    try {
      final data = dioException.response?.data;

      if (data is Map<String, dynamic>) {
        // Use your common error model
        final errorModel = ErrorModelResponseModel.fromJson(data);
        if (errorModel.detail != null && errorModel.detail!.isNotEmpty) {
          message = errorModel.detail!;
        }
      } else if (data is String) {
        message = data;
      } else {
        message = dioException.message ?? 'Unknown error';
      }
    } catch (_) {
      message = dioException.message ?? 'Unknown error';
    }

    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return NetworkFailure(
          'Connection Timeout. Please Check Your Network.',
        );

      case DioExceptionType.badResponse:
        if (statusCode == AppConstants.statusBadRequest ||
            statusCode == AppConstants.statusUnauthorized ||
            statusCode == AppConstants.statusNotFound ||
            (statusCode != null &&
                statusCode >= AppConstants.statusServerError)) {
          return ServerFailure(message, code: statusCode);
        }
        return ServerFailure(message, code: statusCode);

      case DioExceptionType.cancel:
        return NetworkFailure('Request Cancelled.');

      default:
        return NetworkFailure('Network Error: Unable To Reach Server.');
    }
  }
}