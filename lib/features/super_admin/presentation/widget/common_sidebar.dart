import 'package:get/get.dart';
import 'package:venu_ghee/core/utils/exports/common_exports.dart';
import 'package:venu_ghee/core/utils/widgets/responsive_helper/responsive_helper.dart';
import 'package:venu_ghee/features/super_admin/presentation/widget/bottom_navigation_bar_widget.dart';

class CollapsedSidebar extends StatelessWidget {
  final MainController controller = Get.find<MainController>();

  CollapsedSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: double.infinity,
      decoration: BoxDecoration(
        color: ColorConstants.bgColor,
        border: Border(
          right: BorderSide(width: 2, color: ColorConstants.borderWhiteColor),
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            color: ColorConstants.bgColor,
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Opacity(
              opacity: 0.10,
              child: SizedBox(
                height: 180,
                child: Image.asset(ImageConstants.cowBg, fit: BoxFit.cover),
              ),
            ),
          ),

          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Image.asset(
                  ThemeHelper.logoImage(),
                  height: 50,
                  width: 50,
                  fit: BoxFit.contain,
                ),
              ),

              8.0.height,

              Obx(
                () => Column(
                  children: [
                    SidebarIconItem(
                      icon: ImageConstants.dashboardIcon,
                      index: 0,
                      currentIndex: controller.currentIndex.value,
                      onTap: () => controller.changeIndex(0),
                    ),

                    SidebarIconItem(
                      icon: ImageConstants.branchIcon,
                      index: 1,
                      currentIndex: controller.currentIndex.value,
                      onTap: () => controller.changeIndex(1),
                    ),

                    SidebarIconItem(
                      icon: ImageConstants.productIcon,
                      index: 2,
                      currentIndex: controller.currentIndex.value,
                      onTap: () => controller.changeIndex(2),
                    ),
                    SidebarIconItem(
                      icon: ImageConstants.historyIcon,
                      index: 3,
                      currentIndex: controller.currentIndex.value,
                      onTap: () => controller.changeIndex(3),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

///  FULL SIDEBAR (Web)
class FullSidebar extends StatelessWidget {
  final MainController controller = Get.find<MainController>();

  FullSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: double.infinity,
      decoration: BoxDecoration(
        color: ColorConstants.bgColor,
        border: Border(
          right: BorderSide(color: ColorConstants.borderWhiteColor,width: 2),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Opacity(
              opacity: 0.10,
              child: SizedBox(
                height: 220,
                child: Image.asset(ImageConstants.cowBg, fit: BoxFit.cover),
              ),
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Image.asset(
                  ThemeHelper.logoImage(),
                  height: 55,
                  fit: BoxFit.contain,
                ),
              ),

              8.0.height,

              Obx(
                () => Column(
                  children: [
                    SidebarLabelItem(
                      icon: ImageConstants.dashboardIcon,
                      label: 'Dashboard',
                      index: 0,
                      currentIndex: controller.currentIndex.value,
                      onTap: () => controller.changeIndex(0),
                    ),

                    SidebarLabelItem(
                      icon: ImageConstants.branchIcon,
                      label: 'Branch',
                      index: 1,
                      currentIndex: controller.currentIndex.value,
                      onTap: () => controller.changeIndex(1),
                    ),

                    SidebarLabelItem(
                      icon: ImageConstants.productIcon,
                      label: 'Product',
                      index: 2,
                      currentIndex: controller.currentIndex.value,
                      onTap: () => controller.changeIndex(2),
                    ),
                    SidebarLabelItem(
                      icon: ImageConstants.historyIcon,
                      label: 'Sell History',
                      index: 3,
                      currentIndex: controller.currentIndex.value,
                      onTap: () => controller.changeIndex(3),
                    ),
                    SidebarLabelItem(
                      icon: ImageConstants.profileIcon,  // ઉમેરો
                      label: 'Profile',
                      index: 4,
                      currentIndex: controller.currentIndex.value,
                      onTap: () => controller.changeIndex(4),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

///  SIDEBAR ICON ITEM
class SidebarIconItem extends StatelessWidget {
  final String icon;
  final int index;
  final int currentIndex;
  final VoidCallback onTap;

  const SidebarIconItem({
    super.key,
    required this.icon,
    required this.index,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = index == currentIndex;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isSelected ? ColorConstants.redColor : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Image.asset(
          icon,
          height: 22,
          width: 22,
          color: isSelected
              ? ColorConstants.primaryColor
              : ColorConstants.silverGrayColor,
        ),
      ),
    );
  }
}

///  SIDEBAR LABEL ITEM
class SidebarLabelItem extends StatelessWidget {
  final String icon;
  final String label;
  final int index;
  final int currentIndex;
  final VoidCallback onTap;

  const SidebarLabelItem({
    super.key,
    required this.icon,
    required this.label,
    required this.index,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = index == currentIndex;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? ColorConstants.redColor : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Image.asset(
              icon,
              height: 18,
              width: 18,
              color: isSelected
                  ? ColorConstants.primaryColor
                  : ColorConstants.silverGrayColor,
            ),

            8.0.width,

            TextWidget(
              text: label,
              fontSize: adaptiveFont(context, 13),
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              color: isSelected
                  ? ColorConstants.primaryColor
                  : ColorConstants.silverGrayColor,
            ),
          ],
        ),
      ),
    );
  }
}
