import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:venu_ghee/core/config/api_endpoints.dart';
import 'package:venu_ghee/core/constants/storage_constants.dart';
import 'package:venu_ghee/core/network/api_client.dart';
import 'package:venu_ghee/features/super_admin/data/model/request_model/add_new_branch_request_model.dart';
import 'package:venu_ghee/features/super_admin/data/model/request_model/add_product_request_model.dart';
import 'package:venu_ghee/features/super_admin/data/model/response_model/add_new_branch_response_model.dart';
import 'package:venu_ghee/features/super_admin/data/model/response_model/all_sell_history_model.dart';
import 'package:venu_ghee/features/super_admin/data/model/response_model/get_branch_details_response_model.dart';
import 'package:venu_ghee/features/super_admin/data/model/response_model/get_product_branch_list_response_model.dart';
import 'dart:typed_data';

class SuperAdminRepo {
  final ApiClient _apiClient = ApiClient();
  final _box = GetStorage();

  String get token => _box.read(StorageConstants.accessToken) ?? '';

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
    Uint8List? imageBytes,
  }) async {
    final response = await _apiClient.postMultipart(
      ApiEndpoints.getBranchDetails,
      data: await request.toFormData(imageBytes: imageBytes), // ✅
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );

    return AddNewBranchResponseModel.fromJson(response.data);
  }

  Future<AddNewBranchResponseModel> editBranch({
    required String id,
    required AddNewBranchRequestModel request,
    Uint8List? imageBytes,
  }) async {
    final response = await _apiClient.putMultipart(
      '${ApiEndpoints.getBranchDetails}/$id',
      data: await request.toFormData(imageBytes: imageBytes), // ✅
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );
    return AddNewBranchResponseModel.fromJson(response.data);
  }
  Future<AddNewBranchResponseModel> deleteBranch({required String id}) async {
    final response = await _apiClient.delete(
      '${ApiEndpoints.getBranchDetails}/$id',
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );
    final result = AddNewBranchResponseModel.fromJson(response.data);
    return result;
  }


  //product

  Future<GetProductBranchListResponseModel> getProductBranchList() async {
    final response = await _apiClient.get(
      ApiEndpoints.getProducts,
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );
    final result = GetProductBranchListResponseModel.fromJson(
      response.data as Map<String, dynamic>,
    );
    return result;
  }

  Future<AddNewBranchResponseModel> addProduct({
    required AddProductRequestModel request,
    Uint8List? imageBytes,
  }) async {
    final response = await _apiClient.postMultipart(
      ApiEndpoints.getProducts,
      data: await request.toFormData(imageBytes: imageBytes),
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );
    return AddNewBranchResponseModel.fromJson(response.data);
  }

  Future<AddNewBranchResponseModel> updateProduct({
    required String id,
    required AddProductRequestModel request,
    Uint8List? imageBytes,
  }) async {
    final response = await _apiClient.putMultipart(
      '${ApiEndpoints.getProducts}/$id',
      data: await request.toFormData(imageBytes: imageBytes),
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );
    return AddNewBranchResponseModel.fromJson(response.data);
  }

  Future<AddNewBranchResponseModel> deleteProduct({required String id}) async {
    final response = await _apiClient.delete(
      '${ApiEndpoints.getProducts}/$id',
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );
    return AddNewBranchResponseModel.fromJson(response.data);
  }


  //sell history all
  Future<List<AllSaleItem>> getAllSales() async {
    final response = await _apiClient.get(
      ApiEndpoints.getAllSales,
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );
    final List salesJson = response.data['sales'] ?? [];
    return salesJson.map((e) => AllSaleItem.fromJson(e)).toList();
  }
}
