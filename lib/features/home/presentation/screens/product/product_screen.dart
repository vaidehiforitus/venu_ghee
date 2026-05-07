import 'package:get/get.dart';
import 'package:venu_ghee/core/utils/exports/common_exports.dart';
import 'package:venu_ghee/features/home/presentation/controller/product_controller.dart';
import 'package:venu_ghee/features/home/presentation/screens/product/add_product_screen.dart';

class ProductScreen extends StatelessWidget {
  ProductScreen({super.key});

  final ProductController controller = Get.put(ProductController());

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
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 16.h,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextWidget(
                        text: 'Product',
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                        color: ColorConstants.redColor,
                      ),
                      PrimaryButton(
                        title: 'Add Product  +',
                        height: 38.h,
                        width: 130.w,
                        buttonColor: ColorConstants.redColor,
                        titleColor: ColorConstants.primaryColor,
                        fontSize: 14.sp,
                        customRadius: 20.r,
                        onPressed: () => Get.to(() => AddProductScreen()),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Obx(() {
                    if (controller.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (controller.productList.isEmpty) {
                      return Center(
                        child: TextWidget(
                          text: 'No products found',
                          fontSize: 14.sp,
                          color: ColorConstants.lightTextColor,
                        ),
                      );
                    }
                    return GridView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12.w,
                        mainAxisSpacing: 12.h,
                        childAspectRatio: 0.8,
                      ),
                      itemCount: controller.productList.length,
                      itemBuilder: (context, index) {
                        final product = controller.productList[index];
                        return _ProductCard(
                          product: product,
                          onMenu: () => _showMenuOptions(context, product),
                        );
                      },
                    );
                  }),
                ),
                10.0.height,
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showMenuOptions(BuildContext context, AddProductModel product) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        padding: EdgeInsets.all(20.r),
        decoration: BoxDecoration(
          color: ColorConstants.darkWhiteColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(
                Icons.edit_outlined,
                color: ColorConstants.textColor,
              ),
              title: TextWidget(text: 'Edit', fontSize: 14.sp),
              onTap: () {
                Get.back();
                Get.to(() => AddProductScreen(product: product));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.delete_outline,
                color: ColorConstants.redColor,
              ),
              title: TextWidget(
                text: 'Delete',
                fontSize: 14.sp,
                color: ColorConstants.redColor,
              ),
              onTap: () {
                Get.back();
                controller.deleteProduct(product.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  final AddProductModel product;
  final VoidCallback onMenu;

  const _ProductCard({required this.product, required this.onMenu});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorConstants.primaryColor,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: ColorConstants.borderWhiteColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
            child: Image.asset(
              product.image,
              height: 135.h,
              // width: double.infinity,
              width: 135.w,
              fit: BoxFit.cover,
            ),
          ),
          10.0.height,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: TextWidget(
                  text: product.name,
                  fontWeight: FontWeight.w600,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              GestureDetector(
                onTap: onMenu,
                child: Container(
                  padding: EdgeInsets.all(4.r),
                  decoration: BoxDecoration(
                    color: ColorConstants.lightBlueColor,
                    borderRadius: BorderRadius.circular(6.r),
                    border: Border.all(color: ColorConstants.lightTextColor),
                  ),
                  child: Icon(
                    Icons.more_vert,
                    size: 16.sp,
                    color: ColorConstants.lightTextColor,
                  ),
                ),
              ),
            ],
          ),
          6.0.height,

          TextWidget(
            text: product.weight,
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: ColorConstants.lightTextColor,
          ),
        ],
      ).paddingAll(16.r),
    );
  }
}
