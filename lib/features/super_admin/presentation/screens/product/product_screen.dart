import 'package:get/get.dart';
import 'package:venu_ghee/core/config/app_config.dart';
import 'package:venu_ghee/core/utils/exports/common_exports.dart';
import 'package:venu_ghee/core/utils/widgets/responsive_helper/responsive_helper.dart';
import 'package:venu_ghee/features/super_admin/data/model/response_model/get_product_branch_list_response_model.dart';
import 'package:venu_ghee/features/super_admin/presentation/controller/product_controller.dart';
import 'package:venu_ghee/features/super_admin/presentation/screens/product/add_product_screen.dart';
import 'package:venu_ghee/features/super_admin/presentation/widget/adaptive_scaffold.dart';

class ProductScreen extends StatelessWidget {
  ProductScreen({super.key});

  final ProductController controller = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    if (w < 600) return _MobileProductLayout(controller: controller);
    return AdaptiveScaffold(
      title: 'Product',
      showBreadcrumbIcon: true,
      mobileBody: _MobileProductLayout(controller: controller),
      tabletBody: _DesktopProductBody(controller: controller),
    );
  }
}

class _MobileProductLayout extends StatelessWidget {
  final ProductController controller;
  const _MobileProductLayout({required this.controller});

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: Scaffold(
        backgroundColor: ColorConstants.transparentColor,
        body: SafeArea(
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
                      width: 135.w,
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
                        onMenu: () =>
                            _showMenuOptions(context, product, controller),
                      );
                    },
                  );
                }),
              ),
              10.0.height,
            ],
          ),
        ),
      ),
    );
  }
}

class _DesktopProductBody extends StatelessWidget {
  final ProductController controller;
  const _DesktopProductBody({required this.controller});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final crossAxisCount = w < 900 ? 3 : w < 1280 ? 4 : 5;

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              TextWidget(
                text: 'Product',
                fontSize: adaptiveFont(context, 22),
                fontWeight: FontWeight.w700,
                color: ColorConstants.textColor,
              ),
              const Spacer(),
              GestureDetector(
                onTap: () => Get.to(() => AddProductScreen()),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 18, vertical: 9),
                  decoration: BoxDecoration(
                    color: ColorConstants.redColor,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextWidget(
                        text: 'Add Product',
                        fontSize: adaptiveFont(context, 13),
                        fontWeight: FontWeight.w600,
                        color: ColorConstants.primaryColor,
                      ),
                      const SizedBox(width: 6),
                      Icon(
                        Icons.add,
                        size: adaptiveFont(context, 16),
                        color: ColorConstants.primaryColor,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              if (controller.productList.isEmpty) {
                return Center(
                  child: TextWidget(
                    text: 'No products found',
                    fontSize: adaptiveFont(context, 14),
                    color: ColorConstants.lightTextColor,
                  ),
                );
              }
              return GridView.builder(
                physics: const BouncingScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                  childAspectRatio: 0.80,
                ),
                itemCount: controller.productList.length,
                itemBuilder: (context, index) {
                  final product = controller.productList[index];
                  return _DesktopProductCard(
                    product: product,
                    onEdit: () =>
                        Get.to(() => AddProductScreen(product: product)),
                    onDelete: () => controller.deleteProduct(product.id.toString()),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  final ProductModel product;
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
            child: Image.network(
              "${AppConfig.apiBaseUrl}${product.image}",
              height: 110.h,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          10.0.height,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: TextWidget(
                  text: product.name ?? '',
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
            text: product.weightVolume.toString(),
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: ColorConstants.lightTextColor,
          ),
        ],
      ).paddingAll(10.r),
    );
  }
}

class _DesktopProductCard extends StatelessWidget {
  final ProductModel product;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _DesktopProductCard({
    required this.product,
    required this.onEdit,
    required this.onDelete,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius:
              const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.network(
                "${AppConfig.apiBaseUrl}${product.image}",
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 8, 2, 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: TextWidget(
                    text: product.name ?? '',
                    fontSize: adaptiveFont(context, 13),
                    fontWeight: FontWeight.w600,
                    color: ColorConstants.textColor,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                PopupMenuButton<String>(
                  padding: EdgeInsets.zero,
                  icon: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: ColorConstants.lightBlueColor,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: ColorConstants.lightTextColor),
                    ),
                    child: Icon(
                      Icons.more_vert,
                      size: adaptiveFont(context, 15),
                      color: ColorConstants.lightTextColor,
                    ),
                  ),
                  onSelected: (val) {
                    if (val == 'edit') onEdit();
                    if (val == 'delete') onDelete();
                  },
                  itemBuilder: (_) => [
                    PopupMenuItem(
                      value: 'edit',
                      child: Row(
                        children: [
                          Icon(Icons.edit_outlined,
                              size: 16, color: ColorConstants.textColor),
                          const SizedBox(width: 8),
                          const Text('Edit'),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 'delete',
                      child: Row(
                        children: [
                          Icon(Icons.delete_outline,
                              size: 16, color: ColorConstants.redColor),
                          const SizedBox(width: 8),
                          Text('Delete',
                              style: TextStyle(color: ColorConstants.redColor)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 10, bottom: 10, top: 4),
            child: TextWidget(
              text: product.weightVolume.toString(),
              fontSize: adaptiveFont(context, 12),
              fontWeight: FontWeight.w600,
              color: ColorConstants.lightTextColor,
            ),
          ),
        ],
      ),
    );
  }
}

void _showMenuOptions(
    BuildContext context,
    ProductModel product,
    ProductController controller,
    ) {
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
            leading:
            Icon(Icons.edit_outlined, color: ColorConstants.textColor),
            title: TextWidget(text: 'Edit', fontSize: 14.sp),
            onTap: () {
              Get.back();
              Get.to(() => AddProductScreen(product: product));
            },
          ),
          ListTile(
            leading:
            Icon(Icons.delete_outline, color: ColorConstants.redColor),
            title: TextWidget(
              text: 'Delete',
              fontSize: 14.sp,
              color: ColorConstants.redColor,
            ),
            onTap: () {
              Get.back();
              controller.deleteProduct(product.id.toString());
            },
          ),
        ],
      ),
    ),
  );
}
