import 'package:get/get.dart';
import 'package:venu_ghee/core/config/app_config.dart';
import 'package:venu_ghee/core/utils/exports/common_exports.dart';
import 'package:venu_ghee/core/utils/widgets/responsive_helper/responsive_helper.dart';
import 'package:venu_ghee/features/branch_admin/presentation/controller/branch_sell_controller.dart';
import 'package:venu_ghee/features/branch_admin/presentation/widget/branch_adaptive_scaffold.dart';

class BranchSellScreen extends StatelessWidget {
  BranchSellScreen({super.key});

  final SellController controller = Get.put(SellController());

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    if (w < 600) return _MobileSellLayout(controller: controller);

    return BranchAdaptiveScaffold(
      title: 'Point Of Sell',
      mobileBody: _MobileSellLayout(controller: controller),
      tabletBody: _DesktopSellBody(controller: controller),
      webBody: _DesktopSellBody(controller: controller),
    );
  }
}

class _MobileSellLayout extends StatelessWidget {
  final SellController controller;
  const _MobileSellLayout({required this.controller});

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: Scaffold(
        backgroundColor: ColorConstants.transparentColor,
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                child: Row(
                  children: [
                    TextWidget(
                      text: 'Point Of Sell',
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                      color: ColorConstants.redColor,
                    ),
                    const Spacer(),
                    Obx(() => GestureDetector(
                      onTap: () => _showMobileCheckout(context),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Icon(Icons.shopping_cart_outlined,
                              size: 26.sp, color: ColorConstants.redColor),
                          if (controller.cartItems.isNotEmpty)
                            Positioned(
                              top: -4, right: -4,
                              child: Container(
                                width: 16.w, height: 16.h,
                                decoration: BoxDecoration(
                                  color: ColorConstants.redColor,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: TextWidget(
                                    text: '${controller.cartItems.length}',
                                    fontSize: 9.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    )),
                  ],
                ),
              ),

              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
                    itemCount: controller.filteredProducts.length,
                    separatorBuilder: (_, __) => SizedBox(height: 10.h),
                    itemBuilder: (_, i) => _ProductListTile(
                      product: controller.filteredProducts[i],
                      controller: controller,
                      isMobile: true,
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showMobileCheckout(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => DraggableScrollableSheet(
        initialChildSize: 0.85,
        maxChildSize: 0.95,
        minChildSize: 0.5,
        builder: (_, scrollCtrl) => _CheckoutPanel(
          controller: controller,
          scrollController: scrollCtrl,
          isMobile: true,
        ),
      ),
    );
  }
}

class _DesktopSellBody extends StatelessWidget {
  final SellController controller;
  const _DesktopSellBody({required this.controller});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    TextWidget(
                      text: 'Point Of Sell',
                      fontSize: adaptiveFont(context, 18),
                      fontWeight: FontWeight.w700,
                      color: ColorConstants.textColor,
                    ),
                    const Spacer(),
                    SizedBox(
                      width: 180, height: 36,
                      child: TextField(
                        onChanged: (v) => controller.searchQuery.value = v,
                        style: TextStyle(
                          fontSize: adaptiveFont(context, 12),
                          color: ColorConstants.textColor,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Search Product',
                          hintStyle: TextStyle(
                            fontSize: adaptiveFont(context, 12),
                            color: ColorConstants.lightTextColor,
                          ),
                          prefixIcon: Icon(Icons.search, size: 16,
                              color: ColorConstants.lightTextColor),
                          filled: true,
                          fillColor: ColorConstants.primaryColor,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                                color: ColorConstants.borderWhiteColor),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                                color: ColorConstants.borderWhiteColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                            BorderSide(color: ColorConstants.redColor),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Expanded(
                  child: Obx(() {
                    if (controller.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    final products = controller.filteredProducts;
                    if (products.isEmpty) {
                      return Center(
                        child: TextWidget(
                          text: 'No products found',
                          color: ColorConstants.lightTextColor,
                        ),
                      );
                    }
                    return ListView.separated(
                      itemCount: products.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 10),
                      itemBuilder: (_, i) => _ProductListTile(
                        product: products[i],
                        controller: controller,
                        isMobile: false,
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),

          const SizedBox(width: 16),
          SizedBox(
            width: w >= 1024 ? 300 : 260,
            child: _CheckoutPanel(controller: controller, isMobile: false),
          ),
        ],
      ),
    );
  }
}

class _ProductListTile extends StatelessWidget {
  final SellProduct product;
  final SellController controller;
  final bool isMobile;

  const _ProductListTile({
    required this.product,
    required this.controller,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    final raw = product.image;

    Widget imgWidget = ClipRRect(
      borderRadius: BorderRadius.circular(isMobile ? 8.r : 8),
      child: raw.isEmpty
          ? Image.asset(ImageConstants.productIcon,
          height: isMobile ? 56.h : 54,
          width: isMobile ? 56.w : 54,
          fit: BoxFit.cover)
          : Image.network(
        raw.startsWith('http') ? raw : '${AppConfig.apiBaseUrl}$raw',
        height: isMobile ? 56.h : 54,
        width: isMobile ? 56.w : 54,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => Image.asset(
          ImageConstants.productIcon,
          height: isMobile ? 56.h : 54,
          width: isMobile ? 56.w : 54,
          fit: BoxFit.cover,
        ),
      ),
    );

    return GestureDetector(
      onTap: () => controller.addToCart(product),
      child: Container(
        padding: isMobile
            ? EdgeInsets.all(10.r)
            : const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: ColorConstants.primaryColor,
          borderRadius: BorderRadius.circular(isMobile ? 12.r : 10),
          border: Border.all(color: ColorConstants.borderWhiteColor),
        ),
        child: Row(
          children: [
            imgWidget,
            SizedBox(width: isMobile ? 12.w : 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    text: product.name,
                    fontSize: isMobile ? 13.sp : adaptiveFont(context, 13),
                    fontWeight: FontWeight.w600,
                    color: ColorConstants.textColor,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: isMobile ? 2.h : 2),
                  TextWidget(
                    text: product.pack,
                    fontSize: isMobile ? 11.sp : adaptiveFont(context, 11),
                    color: ColorConstants.redColor,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(height: isMobile ? 4.h : 4),
                  TextWidget(
                    text: 'M. R. P.',
                    fontSize: isMobile ? 10.sp : adaptiveFont(context, 10),
                    color: ColorConstants.lightTextColor,
                  ),
                  TextWidget(
                    text: '₹${product.mrp.toStringAsFixed(0)}',
                    fontSize: isMobile ? 13.sp : adaptiveFont(context, 13),
                    fontWeight: FontWeight.w700,
                    color: ColorConstants.textColor,
                  ),
                ],
              ),
            ),
            Obx(() {
              final qty = controller.qtyOf(product.id);
              if (qty == 0) {
                return GestureDetector(
                  onTap: () => controller.addToCart(product),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 10.w : 10,
                      vertical: isMobile ? 6.h : 6,
                    ),
                    decoration: BoxDecoration(
                      color: ColorConstants.redColor,
                      borderRadius:
                      BorderRadius.circular(isMobile ? 8.r : 8),
                    ),
                    child: Icon(Icons.add,
                        size: isMobile ? 16.sp : 16, color: Colors.white),
                  ),
                );
              }
              return _QtyControl(
                qty: qty,
                onAdd: () => controller.addToCart(product),
                onRemove: () => controller.removeFromCart(product.id),
                isMobile: isMobile,
                context: context,
              );
            }),
          ],
        ),
      ),
    );
  }
}
class _QtyControl extends StatelessWidget {
  final int qty;
  final VoidCallback onAdd;
  final VoidCallback onRemove;
  final bool isMobile;
  final BuildContext context;

  const _QtyControl({
    required this.qty,
    required this.onAdd,
    required this.onRemove,
    required this.isMobile,
    required this.context,
  });

  @override
  Widget build(BuildContext ctx) {
    final btnSize = isMobile ? 26.0.w : 26.0;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _btn(Icons.remove, onRemove, btnSize),
        SizedBox(width: isMobile ? 6.w : 6),
        TextWidget(
          text: '$qty',
          fontSize: isMobile ? 13.sp : adaptiveFont(context, 13),
          fontWeight: FontWeight.w700,
          color: ColorConstants.textColor,
        ),
        SizedBox(width: isMobile ? 6.w : 6),
        _btn(Icons.add, onAdd, btnSize),
      ],
    );
  }

  Widget _btn(IconData icon, VoidCallback onTap, double size) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size, height: size,
        decoration: BoxDecoration(
          color: icon == Icons.add
              ? ColorConstants.redColor
              : ColorConstants.darkWhiteColor,
          borderRadius: BorderRadius.circular(isMobile ? 6.r : 6),
          border: icon == Icons.remove
              ? Border.all(color: ColorConstants.borderWhiteColor)
              : null,
        ),
        child: Icon(icon,
            size: isMobile ? 13.sp : 13,
            color: icon == Icons.add
                ? Colors.white
                : ColorConstants.textColor),
      ),
    );
  }
}

class _CheckoutPanel extends StatelessWidget {
  final SellController controller;
  final bool isMobile;
  final ScrollController? scrollController;

  const _CheckoutPanel({
    required this.controller,
    required this.isMobile,
    this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorConstants.primaryColor,
        borderRadius: isMobile
            ? const BorderRadius.vertical(top: Radius.circular(20))
            : BorderRadius.circular(12),
        border: Border.all(color: ColorConstants.borderWhiteColor),
      ),
      child: Column(
        mainAxisSize: isMobile ? MainAxisSize.min : MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isMobile) ...[
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 10.h),
                width: 40.w, height: 4.h,
                decoration: BoxDecoration(
                  color: ColorConstants.borderColor,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 12.h),
          ],

          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 16.w : 14,
              vertical: isMobile ? 0 : 12,
            ),
            child: TextWidget(
              text: 'Check Out',
              fontSize: isMobile ? 18.sp : adaptiveFont(context, 16),
              fontWeight: FontWeight.w700,
              color: ColorConstants.textColor,
            ),
          ),

          if (!isMobile)
            Divider(height: 1, color: ColorConstants.borderWhiteColor),

          Expanded(
            child: Obx(() {
              if (controller.cartItems.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.shopping_bag_outlined,
                          size: isMobile ? 48.sp : 40,
                          color: ColorConstants.lightTextColor),
                      SizedBox(height: isMobile ? 8.h : 8),
                      TextWidget(
                        text: 'Cart Empty',
                        fontSize: isMobile
                            ? 14.sp
                            : adaptiveFont(context, 13),
                        color: ColorConstants.lightTextColor,
                      ),
                    ],
                  ),
                );
              }
              return ListView.separated(
                controller: scrollController,
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 16.w : 12,
                  vertical: isMobile ? 8.h : 8,
                ),
                itemCount: controller.cartItems.length,
                separatorBuilder: (_, __) =>
                    SizedBox(height: isMobile ? 8.h : 8),
                itemBuilder: (_, i) => _CartItemTile(
                  item: controller.cartItems[i],
                  controller: controller,
                  isMobile: isMobile,
                ),
              );
            }),
          ),

          // Summary + Button
          Obx(() => Container(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 16.w : 14,
              vertical: isMobile ? 14.h : 12,
            ),
            decoration: BoxDecoration(
              color: ColorConstants.primaryColor,
              border: Border(
                top: BorderSide(color: ColorConstants.borderWhiteColor),
              ),
            ),
            child: Column(
              children: [
                _SummaryRow(label: 'Sub Total',
                    value: '₹${controller.subTotal.toStringAsFixed(2)}',
                    isMobile: isMobile, context: context),
                SizedBox(height: isMobile ? 4.h : 4),
                _SummaryRow(label: 'Tax',
                    value: '₹${controller.tax.toStringAsFixed(2)}',
                    isMobile: isMobile, context: context),
                SizedBox(height: isMobile ? 4.h : 4),
                _SummaryRow(label: 'Total Amount',
                    value: '₹${controller.totalAmount.toStringAsFixed(2)}',
                    isMobile: isMobile, context: context, isBold: true),
                SizedBox(height: isMobile ? 12.h : 12),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () =>
                        controller.openCustomerDialog(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorConstants.redColor,
                      padding: EdgeInsets.symmetric(
                          vertical: isMobile ? 14.h : 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            isMobile ? 30.r : 8),
                      ),
                      elevation: 0,
                    ),
                    child: TextWidget(
                      text: 'Process To Checkout',
                      fontSize: isMobile
                          ? 14.sp
                          : adaptiveFont(context, 13),
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}

class _CartItemTile extends StatelessWidget {
  final CartItem item;
  final SellController controller;
  final bool isMobile;

  const _CartItemTile({
    required this.item,
    required this.controller,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    final raw = item.product.image;
    final imgSize = isMobile ? 44.0 : 40.0;

    Widget imgWidget = ClipRRect(
      borderRadius: BorderRadius.circular(isMobile ? 6.r : 6),
      child: raw.isEmpty
          ? Image.asset(ImageConstants.productIcon,
          height: imgSize, width: imgSize, fit: BoxFit.cover)
          : Image.network(
        raw.startsWith('http') ? raw : '${AppConfig.apiBaseUrl}$raw',
        height: imgSize,
        width: imgSize,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => Image.asset(
          ImageConstants.productIcon,
          height: imgSize,
          width: imgSize,
          fit: BoxFit.cover,
        ),
      ),
    );

    return Container(
      padding: EdgeInsets.all(isMobile ? 8.r : 8),
      decoration: BoxDecoration(
        color: ColorConstants.darkWhiteColor,
        borderRadius: BorderRadius.circular(isMobile ? 10.r : 8),
        border: Border.all(color: ColorConstants.borderWhiteColor),
      ),
      child: Row(
        children: [
          imgWidget,
          SizedBox(width: isMobile ? 8.w : 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  text: item.product.name,
                  fontSize: isMobile ? 12.sp : adaptiveFont(context, 11),
                  fontWeight: FontWeight.w600,
                  color: ColorConstants.textColor,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                TextWidget(
                  text: '₹${item.product.mrp.toStringAsFixed(0)}',
                  fontSize: isMobile ? 11.sp : adaptiveFont(context, 11),
                  color: ColorConstants.redColor,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
          ),
          _QtyControl(
            qty: item.qty,
            onAdd: () => controller.addToCart(item.product),
            onRemove: () => controller.removeFromCart(item.product.id),
            isMobile: isMobile,
            context: context,
          ),
          SizedBox(width: isMobile ? 8.w : 6),
          GestureDetector(
            onTap: () => controller.deleteFromCart(item.product.id),
            child: Icon(Icons.close,
                size: isMobile ? 16.sp : 15,
                color: ColorConstants.lightTextColor),
          ),
        ],
      ),
    );
  }
}
class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isMobile;
  final BuildContext context;
  final bool isBold;

  const _SummaryRow({
    required this.label,
    required this.value,
    required this.isMobile,
    required this.context,
    this.isBold = false,
  });

  @override
  Widget build(BuildContext ctx) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextWidget(
          text: label,
          fontSize: isMobile ? 13.sp : adaptiveFont(context, 12),
          color: ColorConstants.lightTextColor,
          fontWeight: isBold ? FontWeight.w600 : FontWeight.w400,
        ),
        TextWidget(
          text: value,
          fontSize: isMobile ? 13.sp : adaptiveFont(context, 12),
          color: isBold ? ColorConstants.textColor : ColorConstants
              .lightTextColor,
          fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
        ),
      ],
    );
  }
}

class CustomerDetailsDialog extends StatelessWidget {
  final SellController controller;
  const CustomerDetailsDialog({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Dialog(
      backgroundColor: ColorConstants.primaryColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(isMobile ? 16.r : 16)),
      child: SizedBox(
        width: isMobile ? double.infinity : 380,
        child: Padding(
          padding: EdgeInsets.all(isMobile ? 20.r : 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget(
                    text: 'Customer Details',
                    fontSize: isMobile ? 16.sp : adaptiveFont(context, 16),
                    fontWeight: FontWeight.w700,
                    color: ColorConstants.textColor,
                  ),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: ColorConstants.darkWhiteColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.close, size: 16,
                          color: ColorConstants.lightTextColor),
                    ),
                  ),
                ],
              ),
              SizedBox(height: isMobile ? 20.h : 20),

              // Customer Name
              _dialogLabel(context, 'Customer Name', isMobile),
              SizedBox(height: isMobile ? 6.h : 6),
              TextFormFieldWidget(
                controller: controller.customerNameCtrl,
                hintText: 'Enter customer name',
                fillColor: ColorConstants.darkWhiteColor,
                borderColor: ColorConstants.borderColor,
                focusedBorderColor: ColorConstants.textColor,
                borderRadius: 8,
              ),
              SizedBox(height: isMobile ? 14.h : 14),

              // Mobile Number
              _dialogLabel(context, 'Mobile Number', isMobile),
              SizedBox(height: isMobile ? 6.h : 6),
              TextFormFieldWidget(
                controller: controller.customerMobileCtrl,
                hintText: 'Enter mobile number',
                keyboardType: TextInputType.phone,
                fillColor: ColorConstants.darkWhiteColor,
                borderColor: ColorConstants.borderColor,
                focusedBorderColor: ColorConstants.textColor,
                borderRadius: 8,
              ),
              SizedBox(height: isMobile ? 14.h : 14),
              // Address
              _dialogLabel(context, 'Address', isMobile),
              SizedBox(height: isMobile ? 6.h : 6),
              TextFormFieldWidget(
                controller: controller.addressCtrl,
                hintText: 'Enter Address',
                keyboardType: TextInputType.text,
                fillColor: ColorConstants.darkWhiteColor,
                borderColor: ColorConstants.borderColor,
                focusedBorderColor: ColorConstants.textColor,
                borderRadius: 8,
              ),
              SizedBox(height: isMobile ? 24.h : 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Get.back(),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            vertical: isMobile ? 12.h : 12),
                        side: BorderSide(color: ColorConstants.borderColor),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      child: TextWidget(
                        text: 'Cancel',
                        fontSize: isMobile
                            ? 13.sp
                            : adaptiveFont(context, 13),
                        color: ColorConstants.textColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(width: isMobile ? 12.w : 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () =>
                          controller.openBankDetailsDialog(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorConstants.redColor,
                        padding: EdgeInsets.symmetric(
                            vertical: isMobile ? 12.h : 12),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      child: TextWidget(
                        text: 'Next',
                        fontSize: isMobile
                            ? 13.sp
                            : adaptiveFont(context, 13),
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _dialogLabel(BuildContext context, String text, bool isMobile) {
    return TextWidget(
      text: text,
      fontSize: isMobile ? 12.sp : adaptiveFont(context, 12),
      fontWeight: FontWeight.w500,
      color: ColorConstants.textColor,
    );
  }
}

class BankDetailsDialog extends StatelessWidget {
  final SellController controller;
  const BankDetailsDialog({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Dialog(
      backgroundColor: ColorConstants.primaryColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(isMobile ? 16.r : 16)),
      child: SizedBox(
        width: isMobile ? double.infinity : 420,
        child: Padding(
          padding: EdgeInsets.all(isMobile ? 20.r : 24),
          child: Obx(() {
            final mode = controller.selectedPaymentMode.value;
            final showBank = mode == PaymentMode.bank || mode == PaymentMode.both;
            final showCash = mode == PaymentMode.cash || mode == PaymentMode.both;
            final showAmountFields = mode == PaymentMode.both;

            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidget(
                      text: 'Bank Details',
                      fontSize: isMobile ? 16.sp : adaptiveFont(context, 16),
                      fontWeight: FontWeight.w700,
                      color: ColorConstants.textColor,
                    ),
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: ColorConstants.darkWhiteColor,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.close, size: 16,
                            color: ColorConstants.lightTextColor),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: isMobile ? 16.h : 18),

                TextWidget(
                  text: 'Select Payment Mode',
                  fontSize: isMobile ? 12.sp : adaptiveFont(context, 12),
                  fontWeight: FontWeight.w500,
                  color: ColorConstants.textColor,
                ),
                SizedBox(height: isMobile ? 10.h : 12),

                Row(
                  children: [
                    Expanded(child: _PaymentModeCard(
                      icon: Icons.currency_rupee_rounded,
                      label: 'Cash',
                      mode: PaymentMode.cash,
                      selectedMode: mode,
                      isMobile: isMobile,
                      onTap: () => controller.selectedPaymentMode.value =
                          PaymentMode.cash,
                    )),
                    SizedBox(width: isMobile ? 8.w : 10),
                    Expanded(child: _PaymentModeCard(
                      icon: Icons.account_balance_outlined,
                      label: 'Bank',
                      mode: PaymentMode.bank,
                      selectedMode: mode,
                      isMobile: isMobile,
                      onTap: () => controller.selectedPaymentMode.value =
                          PaymentMode.bank,
                    )),
                    SizedBox(width: isMobile ? 8.w : 10),
                    Expanded(child: _PaymentModeCard(
                      icon: Icons.grid_view_rounded,
                      label: 'Both',
                      mode: PaymentMode.both,
                      selectedMode: mode,
                      isMobile: isMobile,
                      onTap: () => controller.selectedPaymentMode.value =
                          PaymentMode.both,
                    )),
                  ],
                ),

                if (showBank) ...[
                  SizedBox(height: isMobile ? 14.h : 16),
                  TextWidget(
                    text: 'Your Register Bank Details',
                    fontSize: isMobile ? 12.sp : adaptiveFont(context, 12),
                    fontWeight: FontWeight.w500,
                    color: ColorConstants.textColor,
                  ),
                  SizedBox(height: isMobile ? 8.h : 10),
                  Row(
                    children: [
                      Expanded(child: _BankInfoChip(
                          label: 'Bank Name',
                          value: controller.regBankName.value,
                          isMobile: isMobile)),
                      SizedBox(width: isMobile ? 6.w : 8),
                      Expanded(child: _BankInfoChip(
                          label: 'IFSC Code',
                          value: controller.regIfscCode.value,
                          isMobile: isMobile)),
                      SizedBox(width: isMobile ? 6.w : 8),
                      Expanded(child: _BankInfoChip(
                          label: 'A/C Number',
                          value: controller.regAccNumber.value,
                          isMobile: isMobile)),
                    ],
                  ),
                ],

                if (showAmountFields) ...[
                  SizedBox(height: isMobile ? 14.h : 16),
                  Row(
                    children: [
                      Expanded(child: _AmountField(
                        label: 'Cash Amount',
                        ctrl: controller.cashAmountCtrl,
                        isMobile: isMobile,
                        context: context,
                      )),
                      SizedBox(width: isMobile ? 10.w : 12),
                      Expanded(child: _AmountField(
                        label: 'Bank Amount',
                        ctrl: controller.bankAmountCtrl,
                        isMobile: isMobile,
                        context: context,
                      )),
                    ],
                  ),
                ],

                SizedBox(height: isMobile ? 20.h : 22),

                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Get.back(),
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              vertical: isMobile ? 12.h : 12),
                          side: BorderSide(color: ColorConstants.borderColor),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        child: TextWidget(
                          text: 'Back',
                          fontSize: isMobile
                              ? 13.sp
                              : adaptiveFont(context, 13),
                          color: ColorConstants.textColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(width: isMobile ? 12.w : 12),
                    Expanded(
                      child: Obx(() => ElevatedButton(
                        onPressed: controller.isCheckingOut.value
                            ? null
                            : () => controller.processCheckout(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorConstants.redColor,
                          padding: EdgeInsets.symmetric(
                              vertical: isMobile ? 12.h : 12),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        child: controller.isCheckingOut.value
                            ? SizedBox(
                            height: 16, width: 16,
                            child: CircularProgressIndicator(
                                color: Colors.white, strokeWidth: 2))
                            : TextWidget(
                          text: 'Next',
                          fontSize: isMobile
                              ? 13.sp
                              : adaptiveFont(context, 13),
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      )),
                    ),
                  ],
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}

class _PaymentModeCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final PaymentMode mode;
  final PaymentMode selectedMode;
  final bool isMobile;
  final VoidCallback onTap;

  const _PaymentModeCard({
    required this.icon,
    required this.label,
    required this.mode,
    required this.selectedMode,
    required this.isMobile,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = mode == selectedMode;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: isMobile ? 12.h : 14,
          horizontal: isMobile ? 6.w : 8,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? ColorConstants.redColor.withOpacity(0.08)
              : ColorConstants.darkWhiteColor,
          border: Border.all(
            color: isSelected
                ? ColorConstants.redColor
                : ColorConstants.borderWhiteColor,
            width: isSelected ? 1.5 : 1,
          ),
          borderRadius: BorderRadius.circular(isMobile ? 10.r : 10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: isMobile ? 22.sp : 22,
              color: isSelected
                  ? ColorConstants.redColor
                  : ColorConstants.silverGrayColor,
            ),
            SizedBox(height: isMobile ? 4.h : 4),
            TextWidget(
              text: label,
              fontSize: isMobile ? 11.sp : adaptiveFont(context, 11),
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              color: isSelected
                  ? ColorConstants.redColor
                  : ColorConstants.silverGrayColor,
            ),
          ],
        ),
      ),
    );
  }
}

class _BankInfoChip extends StatelessWidget {
  final String label;
  final String value;
  final bool isMobile;

  const _BankInfoChip({
    required this.label,
    required this.value,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 8.w : 10,
        vertical: isMobile ? 8.h : 10,
      ),
      decoration: BoxDecoration(
        color: ColorConstants.darkWhiteColor,
        border: Border.all(color: ColorConstants.redColor.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(isMobile ? 8.r : 8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(
            text: label,
            fontSize: isMobile ? 9.sp : adaptiveFont(context, 9),
            color: ColorConstants.redColor,
            fontWeight: FontWeight.w600,
          ),
          SizedBox(height: isMobile ? 2.h : 2),
          TextWidget(
            text: value,
            fontSize: isMobile ? 10.sp : adaptiveFont(context, 10),
            color: ColorConstants.textColor,
            fontWeight: FontWeight.w500,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _AmountField extends StatelessWidget {
  final String label;
  final TextEditingController ctrl;
  final bool isMobile;
  final BuildContext context;

  const _AmountField({
    required this.label,
    required this.ctrl,
    required this.isMobile,
    required this.context,
  });

  @override
  Widget build(BuildContext ctx) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(
          text: label,
          fontSize: isMobile ? 12.sp : adaptiveFont(context, 12),
          fontWeight: FontWeight.w500,
          color: ColorConstants.textColor,
        ),
        SizedBox(height: isMobile ? 6.h : 6),
        TextFormFieldWidget(
          controller: ctrl,
          hintText: '00.00',
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          fillColor: ColorConstants.darkWhiteColor,
          borderColor: ColorConstants.borderColor,
          focusedBorderColor: ColorConstants.textColor,
          borderRadius: 8,
        ),
      ],
    );
  }
}


