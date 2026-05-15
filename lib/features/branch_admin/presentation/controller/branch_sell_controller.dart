import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:venu_ghee/core/constants/storage_constants.dart';
import 'package:venu_ghee/core/utils/exports/common_exports.dart';
import 'package:venu_ghee/features/branch_admin/data/model/request_model/point_of_sale_request_model.dart';
import 'package:venu_ghee/features/branch_admin/data/repositories/admin_repo.dart';
import 'package:venu_ghee/features/branch_admin/presentation/screen/branch_sell_screen.dart';
import 'package:venu_ghee/features/super_admin/data/repositories/super_admin_repo.dart';

class SellProduct {
  final String id;
  final String name;
  final String pack;
  final double mrp;
  final String image;

  SellProduct({
    required this.id,
    required this.name,
    required this.pack,
    required this.mrp,
    required this.image,
  });
}

class CartItem {
  final SellProduct product;
  int qty;

  CartItem({required this.product, this.qty = 1});
}

enum PaymentMode { cash, bank, both }

class SellController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxBool isCheckingOut = false.obs;

  final RxList<SellProduct> productList = <SellProduct>[].obs;
  final RxList<CartItem> cartItems = <CartItem>[].obs;
  final RxString searchQuery = ''.obs;

  final customerNameCtrl = TextEditingController();
  final customerMobileCtrl = TextEditingController();
  final addressCtrl = TextEditingController();

  final Rx<PaymentMode> selectedPaymentMode = PaymentMode.cash.obs;
  final cashAmountCtrl = TextEditingController();
  final bankAmountCtrl = TextEditingController();

  final RxString regBankName = 'HDFC'.obs;
  final RxString regIfscCode = '124567898'.obs;
  final RxString regAccNumber = '123456985236974'.obs;

  final SuperAdminRepo _repository = SuperAdminRepo();
  final BranchAdminRepo _repo = BranchAdminRepo();

  double get subTotal => cartItems.fold(0, (s, i) => s + i.product.mrp * i.qty);

  double get tax => subTotal * 0.0;

  double get totalAmount => subTotal + tax;

  List<SellProduct> get filteredProducts {
    if (searchQuery.value.isEmpty) return productList;
    return productList
        .where(
          (p) => p.name.toLowerCase().contains(searchQuery.value.toLowerCase()),
        )
        .toList();
  }

  final _box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  @override
  void onClose() {
    customerNameCtrl.dispose();
    customerMobileCtrl.dispose();
    addressCtrl.dispose();
    cashAmountCtrl.dispose();
    bankAmountCtrl.dispose();
    super.onClose();
  }

  Future<void> fetchProducts() async {
    try {
      isLoading.value = true;

      final result = await _repository.getProductBranchList();

      productList.value = (result.products ?? [])
          .map(
            (p) => SellProduct(
              id: p.id?.toString() ?? '',
              name: p.name ?? '',
              pack: '${p.weightVolume ?? ''} ${p.unitType ?? ''}',
              mrp: (p.price ?? 0).toDouble(),
              image: p.image ?? '',
            ),
          )
          .toList();
    } catch (e) {
      print("sjfbhdsbfh$e");
      ErrorHandler.handleError('$e');
    } finally {
      isLoading.value = false;
    }
  }

  void addToCart(SellProduct product) {
    final idx = cartItems.indexWhere((c) => c.product.id == product.id);
    if (idx >= 0) {
      cartItems[idx].qty++;
      cartItems.refresh();
    } else {
      cartItems.add(CartItem(product: product));
    }
  }

  void removeFromCart(String productId) {
    final idx = cartItems.indexWhere((c) => c.product.id == productId);
    if (idx < 0) return;
    if (cartItems[idx].qty > 1) {
      cartItems[idx].qty--;
      cartItems.refresh();
    } else {
      cartItems.removeAt(idx);
    }
  }

  void deleteFromCart(String productId) =>
      cartItems.removeWhere((c) => c.product.id == productId);

  int qtyOf(String productId) =>
      cartItems.firstWhereOrNull((c) => c.product.id == productId)?.qty ?? 0;

  void openCustomerDialog(BuildContext context) {
    if (cartItems.isEmpty) {
      CommonSnackBar.error('Cart is empty!');
      return;
    }
    customerNameCtrl.clear();
    customerMobileCtrl.clear();
    addressCtrl.clear();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => CustomerDetailsDialog(controller: this),
    );
  }

  void openBankDetailsDialog(BuildContext context) {
    selectedPaymentMode.value = PaymentMode.cash;
    cashAmountCtrl.clear();
    bankAmountCtrl.clear();
    Get.back();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => BankDetailsDialog(controller: this),
    );
  }

  Future<void> processCheckout(BuildContext context) async {
    try {
      isCheckingOut.value = true;

      // Payment mode string
      String paymentModeStr = '';
      double cashAmt = 0;
      double bankAmt = 0;

      switch (selectedPaymentMode.value) {
        case PaymentMode.cash:
          paymentModeStr = 'cash';
          cashAmt = totalAmount;
          break;
        case PaymentMode.bank:
          paymentModeStr = 'bank';
          bankAmt = totalAmount;
          break;
        case PaymentMode.both:
          paymentModeStr = 'both';
          cashAmt = double.tryParse(cashAmountCtrl.text.trim()) ?? 0;
          bankAmt = double.tryParse(bankAmountCtrl.text.trim()) ?? 0;
          break;
      }

      // Cart items → SaleItem list
      final items = cartItems
          .map(
            (c) => SaleItem(
              productId: int.tryParse(c.product.id) ?? 0,
              quantity: c.qty,
              pricePerUnit: c.product.mrp,
            ),
          )
          .toList();

      final request = SaleRequestModel(
        // branchId: 4,
        branchId: _box.read<int>(StorageConstants.branchId) ?? 4,
        customerName: customerNameCtrl.text.trim(),
        customerMobile: customerMobileCtrl.text.trim(),
        totalAmount: totalAmount,
        paymentMode: paymentModeStr,
        cashAmount: cashAmt,
        bankAmount: bankAmt,
        orderType: 'Take Away',
        items: items,
      );

      final result = await _repo.createSale(request);

      if (result['id'] != null) {
        cartItems.clear();
        Get.back();
        Get.back();
        CommonSnackBar.success('Order placed successfully!');
      } else {
        ErrorHandler.handleError('Something went wrong');
      }
    } catch (e) {
      print("sjfbhdsbffjbvjsfsbvxfsh$e");
      ErrorHandler.handleError('$e');
    } finally {
      isCheckingOut.value = false;
    }
  }
}
