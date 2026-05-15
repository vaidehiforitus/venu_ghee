import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:venu_ghee/core/config/api_endpoints.dart';
import 'package:venu_ghee/core/constants/storage_constants.dart';
import 'package:venu_ghee/core/network/api_client.dart';
import 'package:venu_ghee/features/auth/data/model/request_model/login_response_model.dart';
import 'package:venu_ghee/features/auth/data/model/response_model/login_response_model.dart';

import '../../../../core/utils/exports/common_exports.dart';

class AuthRepo {
  final ApiClient _apiClient = ApiClient();
  final _box = GetStorage();

  Future<LoginResponseModel> login(LoginRequestModel request) async {
    final response = await _apiClient.post(
      ApiEndpoints.login,
      data: request.toJson(),
    );

    final result = LoginResponseModel.fromJson(response.data);

    await _box.write(StorageConstants.userType, result.userType);
    await _box.write(StorageConstants.accessToken, result.accessToken);
    await _box.write(StorageConstants.refreshToken, result.refreshToken);
    await _box.write(StorageConstants.branchId, result.userId);
    await _box.write(StorageConstants.username, result.userName);
    await _box.write(StorageConstants.ownerName, result.ownerName);
    await _box.write(StorageConstants.branchName, result.branchName);
    await _box.write(StorageConstants.userImage, result.image);
    await _box.write(StorageConstants.mobileNumber, result.firstUser?.mobileNumber ?? '');

    print("Stored userType  ===== ${result.userType}");
    print("accessToken      ===== ${result.accessToken}");
    print("Refresh Token    ===== ${result.refreshToken}");
    print("branch-Id   ===== ${result.userId}");

    return result;
  }
  Future<void> logout() async {
    try {
      final token = _box.read<String?>(StorageConstants.accessToken);
      await _apiClient.post(
        ApiEndpoints.logout,
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );
    } catch (e) {
      debugPrint('Logout API error: $e');
    } finally {
      _box.remove(StorageConstants.accessToken);
      _box.remove(StorageConstants.refreshToken);
      _box.remove(StorageConstants.userType);
      _box.remove(StorageConstants.branchId);
    }
  }
}