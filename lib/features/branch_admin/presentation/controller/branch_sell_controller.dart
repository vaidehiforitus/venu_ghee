import 'package:get/get.dart';
import 'package:venu_ghee/core/utils/exports/common_exports.dart';
import 'package:venu_ghee/features/branch_admin/presentation/screen/branch_sell_screen.dart';

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
  final RxBool isLoading       = false.obs;
  final RxBool isCheckingOut   = false.obs;

  final RxList<SellProduct> productList = <SellProduct>[].obs;
  final RxList<CartItem>    cartItems   = <CartItem>[].obs;
  final RxString            searchQuery = ''.obs;

  final customerNameCtrl   = TextEditingController();
  final customerMobileCtrl = TextEditingController();

  final Rx<PaymentMode> selectedPaymentMode = PaymentMode.cash.obs;
  final cashAmountCtrl = TextEditingController();
  final bankAmountCtrl = TextEditingController();

  final RxString regBankName   = 'HDFC'.obs;
  final RxString regIfscCode   = '124567898'.obs;
  final RxString regAccNumber  = '123456985236974'.obs;

  double get subTotal    => cartItems.fold(0, (s, i) => s + i.product.mrp * i.qty);
  double get tax         => subTotal * 0.0;
  double get totalAmount => subTotal + tax;

  List<SellProduct> get filteredProducts {
    if (searchQuery.value.isEmpty) return productList;
    return productList
        .where((p) => p.name.toLowerCase().contains(searchQuery.value.toLowerCase()))
        .toList();
  }

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  @override
  void onClose() {
    customerNameCtrl.dispose();
    customerMobileCtrl.dispose();
    cashAmountCtrl.dispose();
    bankAmountCtrl.dispose();
    super.onClose();
  }

  Future<void> fetchProducts() async {
    try {
      isLoading.value = true;
      await Future.delayed(const Duration(milliseconds: 800));
      final names = ['Cow Pure Desi Ghee', 'Buffalo Pure Desi Ghee'];
      productList.value = List.generate(
        8,
            (i) => SellProduct(
          id: '$i',
          name: names[i % 2],
          pack: '1 L Premium Pack',
          mrp: 1200,
          image: ImageConstants.productIcon,
        ),
      );
    } catch (e) {
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
    Get.back(); // close customer dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => BankDetailsDialog(controller: this),
    );
  }

  Future<void> processCheckout(BuildContext context) async {
    try {
      isCheckingOut.value = true;
      await Future.delayed(const Duration(seconds: 1));
      cartItems.clear();
      Get.back(); // close bank dialog
      CommonSnackBar.success('Order placed successfully!');
    } catch (e) {
      ErrorHandler.handleError('$e');
    } finally {
      isCheckingOut.value = false;
    }
  }
}


// // lib/features/branch/presentation/controller/sell_controller.dart
//
// import 'package:get/get.dart';
// import 'package:venu_ghee/core/utils/exports/common_exports.dart';
//
// class SellProduct {
//   final String id;
//   final String name;
//   final String pack;
//   final double mrp;
//   final String image;
//
//   SellProduct({
//     required this.id,
//     required this.name,
//     required this.pack,
//     required this.mrp,
//     required this.image,
//   });
// }
//
// class CartItem {
//   final SellProduct product;
//   int qty;
//
//   CartItem({required this.product, this.qty = 1});
// }
//
// class SellController extends GetxController {
//   final RxBool isLoading = false.obs;
//   final RxBool isCheckingOut = false.obs;
//   final RxList<SellProduct> productList = <SellProduct>[].obs;
//   final RxList<CartItem> cartItems = <CartItem>[].obs;
//   final RxString searchQuery = ''.obs;
//
//   // Computed
//   double get subTotal =>
//       cartItems.fold(0, (sum, item) => sum + item.product.mrp * item.qty);
//   double get tax => subTotal * 0.0; // set tax rate if needed
//   double get totalAmount => subTotal + tax;
//
//   List<SellProduct> get filteredProducts {
//     if (searchQuery.value.isEmpty) return productList;
//     return productList
//         .where((p) =>
//         p.name.toLowerCase().contains(searchQuery.value.toLowerCase()))
//         .toList();
//   }
//
//   @override
//   void onInit() {
//     super.onInit();
//     fetchProducts();
//   }
//
//   Future<void> fetchProducts() async {
//     try {
//       isLoading.value = true;
//       await Future.delayed(const Duration(milliseconds: 800));
//
//       final names = ['Cow Pure Desi Ghee', 'Buffalo Pure Desi Ghee'];
//       productList.value = List.generate(
//         8,
//             (i) => SellProduct(
//           id: '$i',
//           name: names[i % 2],
//           pack: '1 L Premium Pack',
//           mrp: 1200,
//           image: ImageConstants.productIcon,
//         ),
//       );
//     } catch (e) {
//       ErrorHandler.handleError('$e');
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   void addToCart(SellProduct product) {
//     final idx = cartItems.indexWhere((c) => c.product.id == product.id);
//     if (idx >= 0) {
//       cartItems[idx].qty++;
//       cartItems.refresh();
//     } else {
//       cartItems.add(CartItem(product: product));
//     }
//   }
//
//   void removeFromCart(String productId) {
//     final idx = cartItems.indexWhere((c) => c.product.id == productId);
//     if (idx < 0) return;
//     if (cartItems[idx].qty > 1) {
//       cartItems[idx].qty--;
//       cartItems.refresh();
//     } else {
//       cartItems.removeAt(idx);
//     }
//   }
//
//   void deleteFromCart(String productId) {
//     cartItems.removeWhere((c) => c.product.id == productId);
//   }
//
//   int qtyOf(String productId) {
//     final item =
//     cartItems.firstWhereOrNull((c) => c.product.id == productId);
//     return item?.qty ?? 0;
//   }
//
//   Future<void> processCheckout() async {
//     if (cartItems.isEmpty) {
//       CommonSnackBar.error('Cart is empty!');
//       return;
//     }
//     try {
//       isCheckingOut.value = true;
//       await Future.delayed(const Duration(seconds: 1));
//       cartItems.clear();
//       CommonSnackBar.success('Order placed successfully!');
//     } catch (e) {
//       ErrorHandler.handleError('$e');
//     } finally {
//       isCheckingOut.value = false;
//     }
//   }
// }


