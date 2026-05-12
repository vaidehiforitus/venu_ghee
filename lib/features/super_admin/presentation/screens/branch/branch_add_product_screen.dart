import 'package:get/get.dart';
import 'package:venu_ghee/core/utils/exports/common_exports.dart';
import 'package:venu_ghee/core/utils/widgets/responsive_helper/responsive_helper.dart';
import 'package:venu_ghee/features/super_admin/data/model/response_model/get_product_branch_list_response_model.dart';
import 'package:venu_ghee/features/super_admin/presentation/controller/branch_controller.dart';
import 'package:venu_ghee/features/super_admin/presentation/widget/adaptive_scaffold.dart';

class BranchAddProductScreen extends StatelessWidget {
  BranchAddProductScreen({super.key});

  final BranchController controller = Get.find<BranchController>();

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    if (w < 600) return _MobileBranchAddProductLayout(controller: controller);

    return AdaptiveScaffold(
      title: 'Add Product',
      showBreadcrumbIcon: true,
      mobileBody: _MobileBranchAddProductLayout(controller: controller),
      tabletBody: _DesktopBranchAddProductBody(controller: controller),
    );
  }
}

class _MobileBranchAddProductLayout extends StatelessWidget {
  final BranchController controller;
  const _MobileBranchAddProductLayout({required this.controller});

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
                  text: 'Add Product',
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  color: ColorConstants.redColor,
                ),
              ),

              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(20.r),
                  child: Container(
                    decoration: BoxDecoration(
                      color: ColorConstants.darkWhiteColor,
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(
                        color: ColorConstants.borderWhiteColor,
                      ),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: Obx(() {
                            if (controller.isLoading.value) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            return GridView.builder(
                              padding: EdgeInsets.all(12.r),
                              physics: const BouncingScrollPhysics(),
                              gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 12.w,
                                mainAxisSpacing: 12.h,
                                childAspectRatio: 0.75,
                              ),
                              itemCount: controller.productList.length,
                              itemBuilder: (context, index) {
                                final product = controller.productList[index];
                                return _ProductCard(
                                  product: product,
                                  index: index,
                                  controller: controller,
                                );
                              },
                            );
                          }),
                        ),

                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 16.h,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              PrimaryButton(
                                title: 'Cancel',
                                height: 44.h,
                                width: 100.w,
                                buttonColor: Colors.transparent,
                                titleColor: ColorConstants.textColor,
                                customRadius: 30.r,
                                border: BorderSide(
                                  color: ColorConstants.borderColor,
                                ),
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
                                    controller.saveBranchWithProducts();
                                  },
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
            ],
          ),
        ),
      ),
    );
  }
}

class _DesktopBranchAddProductBody extends StatelessWidget {
  final BranchController controller;
  const _DesktopBranchAddProductBody({required this.controller});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    final crossAxisCount = w < 900 ? 2 : w < 1280 ? 3 : 4;

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 80),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  TextWidget(
                    text: 'Add Product',
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
                    onTap: () => controller.saveBranchWithProducts(),
                  )),
                ],
              ),
              const SizedBox(height: 20),

              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return GridView.builder(
                    padding: const EdgeInsets.all(16),
                    physics: const BouncingScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 14,
                      mainAxisSpacing: 14,
                      childAspectRatio: 0.78,
                    ),
                    itemCount: controller.productList.length,
                    itemBuilder: (context, index) {
                      final product = controller.productList[index];
                      return _DesktopProductCard(
                        product: product,
                        index: index,
                        controller: controller,
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),

        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: const _StepIndicator(currentStep: 2),
          ),
        ),
      ],
    );
  }
}

class _ProductCard extends StatelessWidget {
  final ProductModel product;
  final int index;
  final BranchController controller;

  const _ProductCard({
    required this.product,
    required this.index,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorConstants.primaryColor,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: ColorConstants.borderWhiteColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
            child:Image.network(
              product.image ?? '',
              height: 114.h,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Image.asset(
                ImageConstants.dashboardIcon,
                height: 114.h,
                fit: BoxFit.cover,
              ),
            ),
          ),
          10.0.height,

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: TextWidget(
              text: product.name ??'',
              fontWeight: FontWeight.w600,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          4.0.height,

          TextWidget(
            text: '${product.weightVolume ?? ''} ${product.unitType ?? ''}',
            color: ColorConstants.lightTextColor,
          ),
          8.0.height,

          Obx(
                () => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => controller.decrementQty(index),
                  child: Container(
                    height: 30.h,
                    width: 26.w,
                    decoration: BoxDecoration(
                      color: ColorConstants.lightBlueColor,
                      borderRadius: BorderRadius.circular(6.r),
                      border: Border.all(color: ColorConstants.borderColor),
                    ),
                    child: Icon(Icons.remove,
                        size: 14.sp, color: ColorConstants.lightTextColor),
                  ),
                ),
                10.0.width,
                Container(
                  height: 30.h,
                  width: 40.w,
                  decoration: BoxDecoration(
                    color: ColorConstants.primaryColor,
                    borderRadius: BorderRadius.circular(6.r),
                    border: Border.all(color: ColorConstants.borderColor),
                  ),
                  child: TextWidget(
                    text: '${controller.quantities[index]}',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    textAlign: TextAlign.center,
                  ),
                ),
                10.0.width,
                GestureDetector(
                  onTap: () => controller.incrementQty(index),
                  child: Container(
                    height: 30.h,
                    width: 26.w,
                    decoration: BoxDecoration(
                      color: ColorConstants.lightBlueColor,
                      borderRadius: BorderRadius.circular(6.r),
                      border: Border.all(color: ColorConstants.borderColor),
                    ),
                    child: Icon(Icons.add,
                        size: 14.sp, color: ColorConstants.lightTextColor),
                  ),
                ),
              ],
            ),
          ),
          8.0.height,
        ],
      ),
    );
  }
}

class _DesktopProductCard extends StatelessWidget {
  final ProductModel product;
  final int index;
  final BranchController controller;

  const _DesktopProductCard({
    required this.product,
    required this.index,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorConstants.primaryColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ColorConstants.borderWhiteColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius:
              const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.network(
                product.image ?? '',
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Image.asset(
                  ImageConstants.dashboardIcon,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextWidget(
              text: product.name ?? '',
              fontSize: adaptiveFont(context, 13),
              fontWeight: FontWeight.w600,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 4),

          TextWidget(
            text: '${product.weightVolume ?? ''} ${product.unitType ?? ''}',
            fontSize: adaptiveFont(context, 12),
            color: ColorConstants.lightTextColor,
          ),
          const SizedBox(height: 10),

          Obx(
                () => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => controller.decrementQty(index),
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: ColorConstants.lightBlueColor,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: ColorConstants.borderColor),
                    ),
                    child: Icon(
                      Icons.remove,
                      size: adaptiveFont(context, 14),
                      color: ColorConstants.lightTextColor,
                    ),
                  ),
                ),
                const SizedBox(width: 10),

                Container(
                  height: 30,
                  width: 44,
                  decoration: BoxDecoration(
                    color: ColorConstants.primaryColor,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: ColorConstants.borderColor),
                  ),
                  child: Center(
                    child: TextWidget(
                      text: '${controller.quantities[index]}',
                      fontSize: adaptiveFont(context, 13),
                      fontWeight: FontWeight.w600,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(width: 10),

                GestureDetector(
                  onTap: () => controller.incrementQty(index),
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: ColorConstants.lightBlueColor,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: ColorConstants.borderColor),
                    ),
                    child: Icon(
                      Icons.add,
                      size: adaptiveFont(context, 14),
                      color: ColorConstants.lightTextColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}

class _StepIndicator extends StatelessWidget {
  final int currentStep;
  const _StepIndicator({required this.currentStep});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (i) {
        final isActive = i == currentStep;
        final isDone = i < currentStep;
        return Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              width: isActive ? 36 : 30,
              height: isActive ? 36 : 30,
              decoration: BoxDecoration(
                color: isActive || isDone
                    ? ColorConstants.redColor
                    : ColorConstants.primaryColor,
                shape: BoxShape.circle,
                border: Border.all(
                  color: isActive || isDone
                      ? ColorConstants.redColor
                      : ColorConstants.borderColor,
                  width: 1.5,
                ),
              ),
              child: Center(
                child: isDone
                    ? Icon(Icons.check,
                    size: 14, color: ColorConstants.primaryColor)
                    : Text(
                  '${i + 1}',
                  style: TextStyle(
                    fontSize: adaptiveFont(context, 13),
                    fontWeight: FontWeight.w600,
                    color: isActive
                        ? ColorConstants.primaryColor
                        : ColorConstants.lightTextColor,
                  ),
                ),
              ),
            ),
            if (i < 2)
              Row(
                children: List.generate(
                  5,
                      (d) => Container(
                    width: 7,
                    height: 1.5,
                    margin: const EdgeInsets.symmetric(horizontal: 1.5),
                    color: i < currentStep
                        ? ColorConstants.redColor
                        : ColorConstants.borderColor,
                  ),
                ),
              ),
          ],
        );
      }),
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
              strokeWidth: 2, color: ColorConstants.primaryColor),
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