import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:venu_ghee/core/config/api_endpoints.dart';
import 'package:venu_ghee/core/constants/storage_constants.dart';
import 'package:venu_ghee/core/network/api_client.dart';
import 'package:venu_ghee/features/super_admin/data/model/request_model/add_new_branch_request_model.dart';
import 'package:venu_ghee/features/super_admin/data/model/response_model/add_new_branch_response_model.dart';
import 'package:venu_ghee/features/super_admin/data/model/response_model/get_branch_details_response_model.dart';
import 'package:venu_ghee/features/super_admin/data/model/response_model/get_product_branch_list_response_model.dart';

class SuperAdminRepo {
  final ApiClient _apiClient = ApiClient();
  final _box = GetStorage();

  String get token => _box.read(StorageConstants.accessToken) ?? '';

  Future<GetProductBranchListResponseModel> getProductBranchList() async {
    final response = await _apiClient.get(
      ApiEndpoints.getProducts,
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );

    // response.data = { "status": 200, "message": "...", "products": [...] }
    final result = GetProductBranchListResponseModel.fromJson(
      response.data as Map<String, dynamic>,  // ← Map pass karo, List nahi
    );
    return result;
  }
  // Future<GetBranchDetailsResponseModel> getBranchDetails() async {
  //   final response = await _apiClient.get(
  //     options: Options(headers: {"Authorization": "Bearer $token"}),
  //     ApiEndpoints.getBranchDetails,
  //   );
  //   final result = GetBranchDetailsResponseModel.fromJson(response.data);
  //   return result;
  // }
  Future<List<Branches>> getBranchDetails() async {
    final response = await _apiClient.get(
      options: Options(headers: {"Authorization": "Bearer $token"}),
      ApiEndpoints.getBranchDetails,
    );
    final parsed = GetBranchDetailsResponseModel.fromJson(response.data);
    return parsed.branches ?? [];
  }
  Future<AddNewBranchResponseModel> addNewBranch({
    required AddNewBranchRequestModel request,
  }) async {
    final response = await _apiClient.post(
      ApiEndpoints.getBranchDetails,
      data: request.toJson(),
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );
    final result = AddNewBranchResponseModel.fromJson(response.data);
    return result;
  }

  Future<AddNewBranchResponseModel> editBranch({
    required String id
  }) async {
    final response = await _apiClient.put(
      '${ApiEndpoints.getBranchDetails}/$id',
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );
    final result = AddNewBranchResponseModel.fromJson(response.data);
    return result;
  }

  Future<AddNewBranchResponseModel> deleteBranch({
    required String id
  }) async {
    final response = await _apiClient.delete(
      '${ApiEndpoints.getBranchDetails}/$id',
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );
    final result = AddNewBranchResponseModel.fromJson(response.data);
    return result;
  }
}
