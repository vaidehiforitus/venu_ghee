import 'package:get/get.dart';
import 'package:venu_ghee/core/utils/exports/common_exports.dart';
import 'package:venu_ghee/core/utils/widgets/responsive_helper/responsive_helper.dart';
import 'package:venu_ghee/features/super_admin/data/model/response_model/get_product_branch_list_response_model.dart';
import 'package:venu_ghee/features/super_admin/presentation/controller/product_controller.dart';
import 'package:venu_ghee/features/super_admin/presentation/widget/adaptive_scaffold.dart';

class AddProductScreen extends StatelessWidget {
  final ProductModel? product;

  AddProductScreen({super.key, this.product});

  final ProductController controller = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
    if (product != null) controller.setEditData(product!);

    final w = MediaQuery.of(context).size.width;

    if (w < 600) return _MobileAddProductLayout(controller: controller, product: product);

    return AdaptiveScaffold(
      title: product != null ? 'Edit Product' : 'Add Product',
      showBreadcrumbIcon: true,
      mobileBody: _MobileAddProductLayout(controller: controller, product: product),
      tabletBody: _DesktopAddProductBody(controller: controller, product: product),
    );
  }
}

class _MobileAddProductLayout extends StatelessWidget {
  final ProductController controller;
  final ProductModel? product;
  const _MobileAddProductLayout({required this.controller, this.product});

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: Scaffold(
        backgroundColor: ColorConstants.transparentColor,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 16.h,
                ),
                child: TextWidget(
                  text: product != null ? 'Edit Product' : 'Add Product',
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  color: ColorConstants.redColor,
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: _ProductFormCard(
                    controller: controller,
                    product: product,
                    isMobile: true,
                  ),
                ),
              ),
              16.0.height,
            ],
          ),
        ),
      ),
    );
  }
}

class _DesktopAddProductBody extends StatelessWidget {
  final ProductController controller;
  final ProductModel? product;
  const _DesktopAddProductBody({required this.controller, this.product});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              TextWidget(
                text: product != null ? 'Edit Product' : 'Add Product',
                fontSize: adaptiveFont(context, 22),
                fontWeight: FontWeight.w700,
                color: ColorConstants.textColor,
              ),
              const Spacer(),
              _OutlineBtn(label: 'Cancel', onTap: () => Get.back()),
              const SizedBox(width: 12),
              Obx(() => _FilledBtn(
                label: 'Save',
                isLoading: controller.isSubmitting.value,
                onTap: () {
                  if (product != null) {
                    controller.updateProduct(product!.id.toString());
                  } else {
                    controller.addProduct();
                  }
                },
              )),
            ],
          ),
          const SizedBox(height: 24),

          _ProductFormCard(
            controller: controller,
            product: product,
            isMobile: false,
          ),
        ],
      ),
    );
  }
}

class _ProductFormCard extends StatelessWidget {
  final ProductController controller;
  final ProductModel? product;
  final bool isMobile;

  const _ProductFormCard({
    required this.controller,
    required this.isMobile,
    this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: isMobile ? EdgeInsets.all(16.r) : const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: ColorConstants.darkWhiteColor,
        borderRadius: BorderRadius.circular(isMobile ? 16.r : 16),
        border: Border.all(color: ColorConstants.borderWhiteColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: controller.pickImage,
            child: Obx(
                  () => Container(
                height: isMobile ? 140.h : 160,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: ColorConstants.transparentColor,
                  borderRadius:
                  BorderRadius.circular(isMobile ? 10.r : 10),
                  border: Border.all(
                    color: ColorConstants.redColor.withOpacity(0.4),
                    style: BorderStyle.solid,
                    width: 1.5,
                  ),
                ),
                    child: controller.selectedImagePath.value.isNotEmpty
                        ? ClipRRect(
                      borderRadius: BorderRadius.circular(isMobile ? 10.r : 10),
                      child: kIsWeb && controller.selectedImageBytes.value != null
                          ? Image.memory(
                        controller.selectedImageBytes.value!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      )
                          : controller.selectedImage.value != null
                          ? Image.file(
                        controller.selectedImage.value!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      )
                          : const SizedBox(),
                    )
                    : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.image_outlined,
                      size: isMobile ? 36.sp : adaptiveFont(context, 36),
                      color: ColorConstants.redColor,
                    ),
                    SizedBox(height: isMobile ? 10.h : 10),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Click to upload',
                            style: TextStyle(
                              color: ColorConstants.redColor,
                              fontSize: isMobile
                                  ? 13.sp
                                  : adaptiveFont(context, 13),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextSpan(
                            text: ' or drag and drop',
                            style: TextStyle(
                              color: ColorConstants.lightTextColor,
                              fontSize: isMobile
                                  ? 13.sp
                                  : adaptiveFont(context, 13),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: isMobile ? 20.h : 20),

          _rowOrColumn(
            isMobile: isMobile,
            left: _field(
              context,
              label: 'Product Name',
              isMobile: isMobile,
              child: TextFormFieldWidget(
                controller: controller.nameController,
                hintText: 'Product Name',
                fillColor: ColorConstants.primaryColor,
                borderColor: ColorConstants.borderColor,
                focusedBorderColor: ColorConstants.textColor,
              ),
            ),
            right: _field(
              context,
              label: 'Price',
              isMobile: isMobile,
              child: TextFormFieldWidget(
                controller: controller.priceController,
                hintText: '00.00',
                keyboardType: TextInputType.number,
                prefixIcon: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 12.w : 12,
                    vertical: isMobile ? 13.h : 13,
                  ),
                  child: TextWidget(
                    text: '₹',
                    fontSize: isMobile ? 14.sp : adaptiveFont(context, 14),
                    fontWeight: FontWeight.w500,
                    color: ColorConstants.textColor,
                  ),
                ),
                fillColor: ColorConstants.primaryColor,
                borderColor: ColorConstants.borderColor,
                focusedBorderColor: ColorConstants.textColor,
              ),
            ),
          ),
          SizedBox(height: isMobile ? 16.h : 16),

          _fieldLabel(context, 'Unit', isMobile),
          SizedBox(height: isMobile ? 6.h : 6),

          Obx(
                () => Container(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 12.w : 12,
                vertical: isMobile ? 4.h : 4,
              ),
              decoration: BoxDecoration(
                color: ColorConstants.primaryColor,
                borderRadius: BorderRadius.circular(isMobile ? 8.r : 8),
                border: Border.all(color: ColorConstants.borderColor),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: controller.selectedUnit.value.isEmpty
                      ? null
                      : controller.selectedUnit.value,
                  hint: TextWidget(
                    text: 'Select Unit',
                    fontSize: isMobile ? 13.sp : adaptiveFont(context, 13),
                    color: ColorConstants.lightTextColor,
                  ),
                  isExpanded: true,
                  icon: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: ColorConstants.lightTextColor,
                  ),
                  items: ['KG', 'G', 'L', 'ML', 'PCS']
                      .map(
                        (unit) => DropdownMenuItem(
                      value: unit,
                      child: TextWidget(
                        text: unit,
                        fontSize: isMobile
                            ? 13.sp
                            : adaptiveFont(context, 13),
                      ),
                    ),
                  )
                      .toList(),
                  onChanged: (val) {
                    if (val != null) controller.selectedUnit.value = val;
                  },
                ),
              ),
            ),
          ),
          SizedBox(height: isMobile ? 10.h : 10),

          TextFormFieldWidget(
            controller: controller.unitValueController,
            hintText: '500',
            keyboardType: TextInputType.number,
            suffixIcon: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 12.w : 12,
                vertical: isMobile ? 13.h : 13,
              ),
              child: Obx(
                    () => TextWidget(
                  text: controller.selectedUnit.value.isEmpty
                      ? 'KG'
                      : controller.selectedUnit.value,
                  fontSize: isMobile ? 13.sp : adaptiveFont(context, 13),
                  fontWeight: FontWeight.w500,
                  color: ColorConstants.lightTextColor,
                ),
              ),
            ),
            fillColor: ColorConstants.primaryColor,
            borderColor: ColorConstants.borderColor,
            focusedBorderColor: ColorConstants.textColor,
          ),
          SizedBox(height: isMobile ? 24.h : 24),

          if (isMobile)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                PrimaryButton(
                  title: 'Cancel',
                  height: 44.h,
                  width: 100.w,
                  buttonColor: Colors.transparent,
                  titleColor: ColorConstants.textColor,
                  customRadius: 30.r,
                  border: BorderSide(color: ColorConstants.borderColor),
                  onPressed: () => Get.back(),
                ),
                16.0.width,
                Obx(
                      () => PrimaryButton(
                    isLoading: controller.isSubmitting.value,
                    title: 'Save',
                    height: 44.h,
                    width: 100.w,
                    buttonColor: ColorConstants.redColor,
                    titleColor: ColorConstants.primaryColor,
                    customRadius: 30.r,
                    onPressed: () {
                      if (product != null) {
                        controller.updateProduct(product!.id.toString());
                      } else {
                        controller.addProduct();
                      }
                    },
                  ),
                ),
              ],
            ),

          if (isMobile) 10.0.height,
        ],
      ),
    );
  }

  Widget _rowOrColumn({
    required bool isMobile,
    required Widget left,
    required Widget right,
  }) {
    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [left, SizedBox(height: 16.h), right],
      );
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: left),
        const SizedBox(width: 16),
        Expanded(child: right),
      ],
    );
  }

  Widget _field(
      BuildContext context, {
        required String label,
        required Widget child,
        required bool isMobile,
      }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _fieldLabel(context, label, isMobile),
        SizedBox(height: isMobile ? 6.h : 6),
        child,
      ],
    );
  }

  Widget _fieldLabel(BuildContext context, String text, bool isMobile) {
    return TextWidget(
      text: text,
      fontSize: isMobile ? 12.sp : adaptiveFont(context, 14),
      fontWeight: FontWeight.w500,
      color: ColorConstants.textColor,
    );
  }
}

class _OutlineBtn extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _OutlineBtn({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 9),
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(color: ColorConstants.borderColor),
          borderRadius: BorderRadius.circular(30),
        ),
        child: TextWidget(
          text: label,
          fontSize: adaptiveFont(context, 13),
          fontWeight: FontWeight.w500,
          color: ColorConstants.textColor,
        ),
      ),
    );
  }
}

class _FilledBtn extends StatelessWidget {
  final String label;
  final bool isLoading;
  final VoidCallback onTap;
  const _FilledBtn(
      {required this.label, required this.onTap, this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 9),
        decoration: BoxDecoration(
          color: ColorConstants.redColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: isLoading
            ? SizedBox(
          width: 16,
          height: 16,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: ColorConstants.primaryColor,
          ),
        )
            : TextWidget(
          text: label,
          fontSize: adaptiveFont(context, 13),
          fontWeight: FontWeight.w600,
          color: ColorConstants.primaryColor,
        ),
      ),
    );
  }
}
