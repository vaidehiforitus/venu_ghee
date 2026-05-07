import 'package:dio/dio.dart';
import 'package:venu_ghee/core/config/app_config.dart';
import 'package:venu_ghee/core/error/error_mapper.dart';
import 'package:venu_ghee/core/network/pretty_dio_logger.dart';
import 'package:venu_ghee/core/services/auth_service.dart';
import 'api_interceptors.dart';

class ApiClient {
  late final Dio _dio;
  AuthService? _authService; // ← hold it late

  ApiClient({AuthService? authService}) {
    _dio = Dio(
      BaseOptions(
        baseUrl: AppConfig.apiBaseUrl,
        connectTimeout: AppConfig.connectTimeout,
        receiveTimeout: AppConfig.receiveTimeout,
      ),
    );
    _authService = authService;
    _setupInterceptors();
  }

  // Attach later to break the cycle
  void attachAuthService(AuthService service) {
    _authService = service;
    _setupInterceptors();
  }

  void _setupInterceptors() {
    _dio.interceptors.clear();
    if (_authService != null) {
      _dio.interceptors.add(ApiInterceptors(_authService!));
    }
    _dio.interceptors.add(getLogger());
  }

  Future<Response> get(String path, {Map<String, dynamic>? queryParameters, Options? options}) async {
    try {
      return await _dio.get(path, queryParameters: queryParameters, options: options);
    } on DioException catch (e) {
      print('Dio error: ${e.message}');
      print('Status code: ${e.response?.statusCode}');
      print('Response data: ${e.response?.data}');
      throw ErrorMapper.mapDioException(e);

    }
  }

  Future<Response> post(String path, {Map<String, dynamic>? data, Options? options}) async {
    try {
      return await _dio.post(path, data: data, options: options);
    } on DioException catch (e) {
      print('Dio error: ${e.message}');
      print('Status code: ${e.response?.statusCode}');
      print('Response data: ${e.response?.data}');
      throw ErrorMapper.mapDioException(e);
    }
  }

  Future<Response> put(String path, {dynamic  data, Options? options}) async {
    try {
      return await _dio.put(path, data: data, options: options);
    } on DioException catch (e) {
      print('Dio error: ${e.message}');
      print('Status code: ${e.response?.statusCode}');
      print('Response data: ${e.response?.data}');
      throw ErrorMapper.mapDioException(e);
    }
  }

  Future<Response> delete(String path, {Map<String, dynamic>? data, Options? options}) async {
    try {
      return await _dio.delete(path, data: data, options: options);
    } on DioException catch (e) {
      print('Dio error: ${e.message}');
      print('Status code: ${e.response?.statusCode}');
      print('Response data: ${e.response?.data}');
      throw ErrorMapper.mapDioException(e);
    }
  }
  Future<Response> postMultipart(String path, {required FormData data, Options? options}) async {
    try {
      return await _dio.post(path, data: data, options: options);
    } on DioException catch (e) {
      print('Dio error: ${e.message}');
      print('Status code: ${e.response?.statusCode}');
      print('Response data: ${e.response?.data}');
      throw ErrorMapper.mapDioException(e);
    }
  }
  Future<Response> putMultipart(String path, {required FormData data, Options? options}) async {
    try {
      return await _dio.put(path, data: data, options: options);
    } on DioException catch (e) {
      print('Dio error: ${e.message}');
      print('Status code: ${e.response?.statusCode}');
      print('Response data: ${e.response?.data}');
      throw ErrorMapper.mapDioException(e);
    }
  }
}