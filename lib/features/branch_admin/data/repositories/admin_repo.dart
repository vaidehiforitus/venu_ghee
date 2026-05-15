import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:venu_ghee/core/config/api_endpoints.dart';
import 'package:venu_ghee/core/constants/storage_constants.dart';
import 'package:venu_ghee/core/network/api_client.dart';
import 'package:venu_ghee/features/branch_admin/data/model/request_model/point_of_sale_request_model.dart';
import 'package:venu_ghee/features/branch_admin/data/model/response_model/inventory_stock_response_model.dart';
import 'package:venu_ghee/features/branch_admin/data/model/response_model/sell_history_response_model.dart';

class BranchAdminRepo {
  final ApiClient _apiClient = ApiClient();
  final _box = GetStorage();

  String get token => _box.read(StorageConstants.accessToken) ?? '';

  Future<Map<String, dynamic>> createSale(SaleRequestModel request) async {
    final response = await _apiClient.post(
      ApiEndpoints.createSale,
      data: request.toJson(),
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );
    return response.data as Map<String, dynamic>;
  }
  Future<SellHistoryResponseModel> getSalesByBranch(int branchId) async {
    final response = await _apiClient.get(
      '${ApiEndpoints.getSales}$branchId',
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );
    return SellHistoryResponseModel.fromJson(
      response.data as Map<String, dynamic>,
    );
  }
  Future<StockResponseModel> getStocksByBranch(int branchId) async {
    final response = await _apiClient.get(
      '${ApiEndpoints.getStocks}$branchId',
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );
    return StockResponseModel.fromJson(
      response.data as Map<String, dynamic>,
    );
  }
}