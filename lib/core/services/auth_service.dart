import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:venu_ghee/core/error/error_mapper.dart';
import 'package:venu_ghee/core/error/failures.dart';
import 'package:venu_ghee/core/network/api_client.dart';



class AuthService {
  final ApiClient _apiClient;
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  AuthService(this._apiClient);

  // Store access and refresh tokens
  Future<void> saveTokens(String accessToken, String refreshToken) async {
    await _storage.write(key: 'access_token', value: accessToken);
    await _storage.write(key: 'refresh_token', value: refreshToken);
  }

  // Retrieve access token
  Future<String?> getAccessToken() {
    return _storage.read(key: 'access_token').asStream().first;
  }

  // Retrieve refresh token
  Future<String?> _getRefreshToken() async {
    return await _storage.read(key: 'refresh_token');
  }

  // Refresh token by calling the API
  Future<String?> refreshToken() async {
    try {
      final refreshToken = await _getRefreshToken();
      if (refreshToken == null) {
        throw ServerFailure('No refresh token available', code: 401);
      }

      // Call your refresh token endpoint
      final response = await _apiClient.post(
        '/refresh-token', // Replace with your actual endpoint
        data: {'refresh_token': refreshToken},
      );

      final newAccessToken = response.data['access_token'] as String?;
      final newRefreshToken = response.data['refresh_token'] as String?;

      if (newAccessToken != null) {
        // Save new tokens
        await saveTokens(newAccessToken, newRefreshToken ?? refreshToken);
        return newAccessToken;
      }
      throw ServerFailure('Failed to refresh token', code: 401);
    } on DioException catch (e) {
      throw ErrorMapper.mapDioException(e);
    }
  }

  // Clear tokens on logout
  Future<void> clearTokens() async {
    await _storage.delete(key: 'access_token');
    await _storage.delete(key: 'refresh_token');
  }
}