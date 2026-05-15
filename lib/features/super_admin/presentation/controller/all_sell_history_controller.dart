import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:venu_ghee/core/utils/exports/common_exports.dart';
import 'package:venu_ghee/features/super_admin/data/model/response_model/all_sell_history_model.dart';
import 'package:venu_ghee/features/super_admin/data/repositories/super_admin_repo.dart';

class AllSellHistoryController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxList<AllSaleItem> items = <AllSaleItem>[].obs;
  final RxList<AllSaleItem> filteredItems = <AllSaleItem>[].obs;
  final RxString searchQuery = ''.obs;

  // Summary
  final RxDouble totalSales = 0.0.obs;
  final RxInt totalOrders = 0.obs;
  final RxDouble cashSales = 0.0.obs;
  final RxDouble bankSales = 0.0.obs;

  final _box = GetStorage();
  final SuperAdminRepo _repo = SuperAdminRepo();
  @override
  void onInit() {
    super.onInit();
    fetchAllSales();
    debounce(
      searchQuery,
          (_) => _applyFilter(),
      time: const Duration(milliseconds: 300),
    );
  }

  Future<void> fetchAllSales() async {
    try {
      isLoading.value = true;
      final result = await _repo.getAllSales();
      items.value = result;
      _calculateSummary();
      _applyFilter();
    } catch (e) {
      ErrorHandler.handleError('$e');
    } finally {
      isLoading.value = false;
    }
  }
  void _applyFilter() {
    var list = items.toList();
    final q = searchQuery.value.toLowerCase().trim();
    if (q.isNotEmpty) {
      list = list.where((e) =>
      e.customerName.toLowerCase().contains(q) ||
          e.customerMobile.contains(q) ||
          e.paymentMode.toLowerCase().contains(q) ||
          (e.branchId?.toString() ?? '').contains(q)).toList();
    }
    filteredItems.value = list;
  }

  void _calculateSummary() {
    double total = 0, cash = 0, bank = 0;
    for (final item in items) {
      total += item.totalAmount;
      if (item.paymentMode.toLowerCase() == 'cash') {
        cash += item.cashAmount;
      } else if (item.paymentMode.toLowerCase() == 'bank') {
        bank += item.bankAmount;
      } else if (item.paymentMode.toLowerCase() == 'both') {
        cash += item.cashAmount;
        bank += item.bankAmount;
      }
    }
    totalSales.value = total;
    totalOrders.value = items.length;
    cashSales.value = cash;
    bankSales.value = bank;
  }

  String formatAmount(double amount) {
    return '₹${amount.toStringAsFixed(0).replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (m) => '${m[1]},',
    )}';
  }
}