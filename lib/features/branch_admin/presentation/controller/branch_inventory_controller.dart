import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:venu_ghee/core/constants/storage_constants.dart';
import 'package:venu_ghee/core/utils/exports/common_exports.dart';
import 'package:venu_ghee/features/branch_admin/data/repositories/admin_repo.dart';

class InventoryItem {
  final String id;
  final String name;
  final String pack;
  final int inStock;
  final String value;
  final String mrp;
  final String image;

  InventoryItem({
    required this.id,
    required this.name,
    required this.pack,
    required this.inStock,
    required this.value,
    required this.mrp,
    required this.image,
  });
}

class InventoryController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxList<InventoryItem> items = <InventoryItem>[].obs;
  final RxString sortBy = 'Due Date'.obs;
  final RxString filterBy = 'Filter'.obs;

  final BranchAdminRepo _repository = BranchAdminRepo();
  final _box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    fetchInventory();
  }

  Future<void> fetchInventory() async {
    try {
      isLoading.value = true;

      final branchId = _box.read<int>(StorageConstants.branchId) ?? 4;
      final result = await _repository.getStocksByBranch(branchId);

      final baseUrl = 'http://192.168.1.4:8000'; // apna base URL

      items.value = (result.stocks ?? []).map((s) {
        final totalValue = (s.price ?? 0) * (s.quantity ?? 0);

        return InventoryItem(
          id: s.productId?.toString() ?? '',
          name: s.productName ?? '',
          pack: '',
          inStock: s.quantity ?? 0,
          value: '₹${totalValue.toStringAsFixed(0)}',
          mrp: '₹${s.price?.toStringAsFixed(0) ?? '0'}',
          image: (s.image != null && s.image!.isNotEmpty)
              ? '$baseUrl${s.image}'
              : ImageConstants.productIcon,
        );
      }).toList();

    } catch (e) {
      ErrorHandler.handleError('$e');
    } finally {
      isLoading.value = false;
    }
  }
}