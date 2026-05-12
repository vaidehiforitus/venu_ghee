// lib/features/auth/data/repositories/auth_repo.dart

import 'package:get_storage/get_storage.dart';
import 'package:venu_ghee/core/config/api_endpoints.dart';
import 'package:venu_ghee/core/constants/storage_constants.dart';
import 'package:venu_ghee/core/network/api_client.dart';
import 'package:venu_ghee/features/auth/data/model/request_model/login_response_model.dart';
import 'package:venu_ghee/features/auth/data/model/response_model/login_response_model.dart';

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

    print("Stored userType  ===== ${result.userType}");
    print("accessToken      ===== ${result.accessToken}");
    print("Refresh Token    ===== ${result.refreshToken}");

    return result;
  }
}