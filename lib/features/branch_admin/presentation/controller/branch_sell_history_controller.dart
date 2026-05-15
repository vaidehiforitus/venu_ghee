import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:venu_ghee/core/constants/storage_constants.dart';
import 'package:venu_ghee/core/utils/exports/common_exports.dart';
import 'package:venu_ghee/features/branch_admin/data/repositories/admin_repo.dart';

class SellHistoryItem {
  final int id;
  final String productName;
  final String dateTime;
  final String customer;
  final String mobile;
  final int item;
  final String amount;
  final String paymentMode;
  final String orderType;
  final String image;

  const SellHistoryItem({
    required this.id,
    required this.productName,
    required this.dateTime,
    required this.customer,
    required this.mobile,
    required this.item,
    required this.amount,
    required this.paymentMode,
    required this.orderType,
    required this.image,
  });
}
class SellHistoryController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxList<SellHistoryItem> items = <SellHistoryItem>[].obs;

  final BranchAdminRepo _repository = BranchAdminRepo();
  final _box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    fetchSellHistory();
  }

  Future<void> fetchSellHistory() async {
    try {
      isLoading.value = true;

      final branchId = _box.read<int>(StorageConstants.branchId) ?? 4;

      // ✅ Sales + Stocks parallel fetch
      final salesResult = await _repository.getSalesByBranch(branchId);
      final stocksResult = await _repository.getStocksByBranch(branchId);

      // ✅ product_id → image + name map (stocks API માંથી)
      final productImageMap = <int, String>{};
      final productNameMap = <int, String>{};
      for (final stock in (stocksResult.stocks ?? [])) {
        if (stock.productId != null) {
          productImageMap[stock.productId!] = stock.image ?? '';
          productNameMap[stock.productId!] = stock.productName ?? '';
        }
      }

      items.value = (salesResult.sales ?? []).map((s) {
        // ✅ product names stocks map માંથી
        final productNames = (s.items ?? [])
            .map((i) => productNameMap[i.productId] ?? 'Product #${i.productId}')
            .join(', ');

        final totalItems = (s.items ?? [])
            .fold(0, (sum, i) => sum + (i.quantity ?? 0));

        // ✅ First item ની image stocks map માંથી
        final firstProductId = (s.items ?? []).isNotEmpty
            ? s.items!.first.productId
            : null;
        final image = (firstProductId != null && firstProductId != 0)
            ? (productImageMap[firstProductId] ?? '')
            : '';

        return SellHistoryItem(
          id: s.id ?? 0,
          productName: productNames.isNotEmpty ? productNames : 'N/A',
          dateTime: s.timestamp ?? '',
          customer: s.customerName ?? '',
          mobile: s.customerMobile ?? '',
          item: totalItems,
          amount: '₹${s.totalAmount?.toStringAsFixed(2) ?? '0.00'}',
          paymentMode: s.paymentMode ?? '',
          orderType: s.orderType ?? '',
          image: image, // ✅ stocks API માંથી
        );
      }).toList();

    } catch (e) {
      ErrorHandler.handleError('$e');
    } finally {
      isLoading.value = false;
    }
  }
}