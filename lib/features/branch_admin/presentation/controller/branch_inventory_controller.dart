import 'package:get/get.dart';
import 'package:venu_ghee/core/utils/exports/common_exports.dart';

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

  @override
  void onInit() {
    super.onInit();
    fetchInventory();
  }

  Future<void> fetchInventory() async {
    try {
      isLoading.value = true;
      await Future.delayed(const Duration(milliseconds: 800));
      items.value = List.generate(
        6,
            (i) => InventoryItem(
          id: '$i',
          name: 'A2 Cow Pure Desi Ghee',
          pack: 'L Premium Pack',
          inStock: 96,
          value: '₹1,24,000',
          mrp: '₹1200',
          image: ImageConstants.productIcon,
        ),
      );
    } catch (e) {
      ErrorHandler.handleError('$e');
    } finally {
      isLoading.value = false;
    }
  }
}