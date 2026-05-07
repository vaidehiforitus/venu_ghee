import 'package:get/get.dart';
import 'package:venu_ghee/core/utils/exports/common_exports.dart';
import 'package:venu_ghee/features/home/presentation/controller/branch_controller.dart';

class BranchAddProductScreen extends StatelessWidget {
  BranchAddProductScreen({super.key});

  final BranchController controller = Get.find<BranchController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.primaryColor,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(ImageConstants.bgImage, fit: BoxFit.cover),
          ),

          SafeArea(
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
                                  final product =
                                  controller.productList[index];
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
        ],
      ),
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
        border: Border.all(
          color: ColorConstants.borderWhiteColor,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
            child: Image.asset(
              product.image,
              height: 114.h,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          10.0.height,

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: TextWidget(
              text: product.name,
              fontWeight: FontWeight.w600,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          4.0.height,

          TextWidget(
            text: product.weight,
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
                    child: Icon(
                      Icons.remove,
                      size: 14.sp,
                      color: ColorConstants.lightTextColor,
                    ),
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
                  child:  TextWidget(
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
                    child: Icon(
                      Icons.add,
                      size: 14.sp,
                      color: ColorConstants.lightTextColor,
                    ),
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

class ProductModel {
  final String id;
  final String name;
  final String weight;
  final String image;

  ProductModel({
    required this.id,
    required this.name,
    required this.weight,
    required this.image,
  });
}