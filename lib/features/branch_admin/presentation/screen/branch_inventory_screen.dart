import 'package:get/get.dart';
import 'package:venu_ghee/core/utils/exports/common_exports.dart';
import 'package:venu_ghee/core/utils/widgets/responsive_helper/responsive_helper.dart';
import 'package:venu_ghee/features/branch_admin/presentation/controller/branch_inventory_controller.dart';
import 'package:venu_ghee/features/branch_admin/presentation/widget/branch_adaptive_scaffold.dart';

class InventoryScreen extends StatelessWidget {
  InventoryScreen({super.key});

  final InventoryController controller = Get.put(InventoryController());

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    if (w < 600) return _MobileInventoryLayout(controller: controller);

    return BranchAdaptiveScaffold(
      title: 'Inventory',
      mobileBody: _MobileInventoryLayout(controller: controller),
      tabletBody: _DesktopInventoryBody(controller: controller),
      webBody: _DesktopInventoryBody(controller: controller),
    );
  }
}

class _MobileInventoryLayout extends StatelessWidget {
  final InventoryController controller;
  const _MobileInventoryLayout({required this.controller});

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget(
                    text: 'Inventory Status',
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: ColorConstants.redColor,
                  ),
                  // Row(
                  //   children: [
                  //     _SortFilterChip(
                  //       label: 'Sort by: Due Date',
                  //       onTap: () {},
                  //       isMobile: true,
                  //     ),
                  //     SizedBox(width: 8.w),
                  //     _SortFilterChip(
                  //       label: 'Filter',
                  //       onTap: () {},
                  //       isMobile: true,
                  //       isFilter: true,
                  //     ),
                  //   ],
                  // ),
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
                  itemCount: controller.items.length,
                  separatorBuilder: (_, __) => SizedBox(height: 10.h),
                  itemBuilder: (_, i) =>
                      _InventoryCard(item: controller.items[i], isMobile: true),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class _DesktopInventoryBody extends StatelessWidget {
  final InventoryController controller;
  const _DesktopInventoryBody({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              TextWidget(
                text: 'Inventory Status',
                fontSize: adaptiveFont(context, 22),
                fontWeight: FontWeight.w700,
                color: ColorConstants.textColor,
              ),
              const Spacer(),
              _SortFilterChip(
                label: 'Sort by: Due Date',
                onTap: () {},
                isMobile: false,
              ),
              const SizedBox(width: 10),
              _SortFilterChip(
                label: 'Filter',
                onTap: () {},
                isMobile: false,
                isFilter: true,
              ),
            ],
          ),
          const SizedBox(height: 20),

          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              return ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemCount: controller.items.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (_, i) =>
                    _InventoryCard(item: controller.items[i], isMobile: false),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class _InventoryCard extends StatelessWidget {
  final InventoryItem item;
  final bool isMobile;
  const _InventoryCard({required this.item, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: isMobile ? EdgeInsets.all(12.r) : const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: ColorConstants.primaryColor,
        borderRadius: BorderRadius.circular(isMobile ? 12.r : 12),
        border: Border.all(color: ColorConstants.borderWhiteColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 6,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(isMobile ? 8.r : 8),
            // child: Image.asset(
            //   item.image,
            //   height: isMobile ? 52.h : 60,
            //   width: isMobile ? 52.w : 60,
            //   fit: BoxFit.cover,
            // ),
            // ClipRRect child replace karo
            child: item.image.startsWith('http')
                ? Image.network(
              item.image,
              height: isMobile ? 52.h : 60,
              width: isMobile ? 52.w : 60,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Image.asset(
                ImageConstants.productIcon,
                height: isMobile ? 52.h : 60,
                width: isMobile ? 52.w : 60,
                fit: BoxFit.cover,
              ),
            )
                : Image.asset(
              item.image,
              height: isMobile ? 52.h : 60,
              width: isMobile ? 52.w : 60,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: isMobile ? 12.w : 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  text: item.name,
                  fontSize: isMobile ? 13.sp : adaptiveFont(context, 14),
                  fontWeight: FontWeight.w600,
                  color: ColorConstants.textColor,
                ),
                SizedBox(height: isMobile ? 2.h : 3),
                TextWidget(
                  text: item.pack,
                  fontSize: isMobile ? 11.sp : adaptiveFont(context, 12),
                  color: ColorConstants.redColor,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(height: isMobile ? 6.h : 6),
                Row(
                  children: [
                    _StockValueChip(
                      label: 'IN A STOCK',
                      value: '${item.inStock}',
                      isMobile: isMobile,
                    ),
                    SizedBox(width: isMobile ? 16.w : 20),
                    _StockValueChip(
                      label: 'VALUE',
                      value: item.value,
                      isMobile: isMobile,
                    ),
                  ],
                ),
              ],
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextWidget(
                text: 'M. R. P.',
                fontSize: isMobile ? 10.sp : adaptiveFont(context, 11),
                color: ColorConstants.lightTextColor,
              ),
              SizedBox(height: isMobile ? 2.h : 2),
              TextWidget(
                text: item.mrp,
                fontSize: isMobile ? 13.sp : adaptiveFont(context, 14),
                fontWeight: FontWeight.w700,
                color: ColorConstants.textColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StockValueChip extends StatelessWidget {
  final String label;
  final String value;
  final bool isMobile;
  const _StockValueChip({
    required this.label,
    required this.value,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(
          text: label,
          fontSize: isMobile ? 9.sp : adaptiveFont(context, 10),
          color: ColorConstants.lightTextColor,
          fontWeight: FontWeight.w500,
        ),
        TextWidget(
          text: value,
          fontSize: isMobile ? 12.sp : adaptiveFont(context, 13),
          fontWeight: FontWeight.w700,
          color: ColorConstants.textColor,
        ),
      ],
    );
  }
}

class _SortFilterChip extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool isMobile;
  final bool isFilter;
  const _SortFilterChip({
    required this.label,
    required this.onTap,
    required this.isMobile,
    this.isFilter = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: isMobile
            ? EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h)
            : const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        decoration: BoxDecoration(
          color: ColorConstants.primaryColor,
          borderRadius: BorderRadius.circular(isMobile ? 8.r : 8),
          border: Border.all(color: ColorConstants.borderColor),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextWidget(
              text: label,
              fontSize: isMobile ? 10.sp : adaptiveFont(context, 12),
              color: ColorConstants.textColor,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(width: isMobile ? 4.w : 4),
            Icon(
              isFilter
                  ? Icons.tune
                  : Icons.keyboard_arrow_down_rounded,
              size: isMobile ? 12.sp : 14,
              color: ColorConstants.lightTextColor,
            ),
          ],
        ),
      ),
    );
  }
}