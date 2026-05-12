import 'package:get/get.dart';
import 'package:venu_ghee/core/utils/exports/common_exports.dart';
import 'package:venu_ghee/core/utils/widgets/responsive_helper/responsive_helper.dart';
import 'package:venu_ghee/features/branch_admin/presentation/widget/branch_admin_bottom_navigation_bar.dart';

class BranchAdminResponsiveLayout extends StatefulWidget {
  const BranchAdminResponsiveLayout({super.key});

  @override
  State<BranchAdminResponsiveLayout> createState() =>
      _BranchAdminResponsiveLayoutState();
}

class _BranchAdminResponsiveLayoutState
    extends State<BranchAdminResponsiveLayout> {
  late BranchAdminController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.find<BranchAdminController>();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isWeb = screenWidth >= 1024;
    final isTablet = screenWidth >= 600 && screenWidth < 1024;
    final isMobile = screenWidth < 600;

    return Obx(() {
      final currentIndex = controller.currentIndex.value;
      final pages = controller.pages;

      if (isMobile) {
        return Scaffold(
          backgroundColor: ColorConstants.primaryColor,
          body: pages[currentIndex],
          bottomNavigationBar: _BottomNavBar(controller: controller),
        );
      }

      return Scaffold(
        backgroundColor: ColorConstants.primaryColor,
        body: Row(
          children: [
            if (isWeb) BranchFullSidebar(),
            if (isTablet) BranchCollapsedSidebar(),
            Expanded(child: pages[currentIndex]),
          ],
        ),
      );
    });
  }
}

class BranchFullSidebar extends StatelessWidget {
  BranchFullSidebar({super.key});

  final BranchAdminController controller = Get.find<BranchAdminController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: double.infinity,
      decoration: BoxDecoration(
        color: ColorConstants.bgColor,
        border: Border(
          right: BorderSide(color: ColorConstants.borderWhiteColor, width: 2),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 0, left: 0, right: 0,
            child: Opacity(
              opacity: 0.10,
              child: SizedBox(
                height: 220,
                child: Image.asset(ImageConstants.cowBg, fit: BoxFit.cover),
              ),
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
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
                  crossAxisAlignment: CrossAxisAlignment.stretch,
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
                      label: 'Inventory',
                      index: 1,
                      currentIndex: controller.currentIndex.value,
                      onTap: () => controller.changeIndex(1),
                    ),
                    SidebarLabelItem(
                      icon: ImageConstants.productIcon,
                      label: 'Point Of Sell',
                      index: 2,
                      currentIndex: controller.currentIndex.value,
                      onTap: () => controller.changeIndex(2),
                    ),
                    SidebarLabelItem(
                      icon: ImageConstants.productIcon,
                      label: 'Sell History',
                      index: 3,
                      currentIndex: controller.currentIndex.value,
                      onTap: () => controller.changeIndex(3),
                    ),
                    SidebarLabelItem(
                      icon: ImageConstants.productIcon,
                      label: 'Customer',
                      index: 4,
                      currentIndex: controller.currentIndex.value,
                      onTap: () => controller.changeIndex(4),
                    ),
                    SidebarLabelItem(
                      icon: ImageConstants.productIcon,
                      label: 'Inquiry',
                      index: 5,
                      currentIndex: controller.currentIndex.value,
                      onTap: () => controller.changeIndex(5),
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

class BranchCollapsedSidebar extends StatelessWidget {
  BranchCollapsedSidebar({super.key});

  final BranchAdminController controller = Get.find<BranchAdminController>();

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
          Container(color: ColorConstants.bgColor),

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
                    SidebarIconItem(
                      icon: ImageConstants.customerIcon,
                      index: 4,
                      currentIndex: controller.currentIndex.value,
                      onTap: () => controller.changeIndex(4),
                    ),
                    SidebarIconItem(
                      icon: ImageConstants.inquiryIcon,
                      index: 5,
                      currentIndex: controller.currentIndex.value,
                      onTap: () => controller.changeIndex(5),
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
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? ColorConstants.redColor : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
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
            Expanded(
              child: TextWidget(
                text: label,
                fontSize: adaptiveFont(context, 13),
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: isSelected
                    ? ColorConstants.primaryColor
                    : ColorConstants.silverGrayColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class _BottomNavBar extends StatelessWidget {
  final BranchAdminController controller;
  const _BottomNavBar({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
      decoration: BoxDecoration(
        color: ColorConstants.primaryColor,
        border: Border(
          top: BorderSide(color: ColorConstants.borderWhiteColor, width: 1),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavItem(
                icon: ImageConstants.dashboardIcon,
                label: 'Dashboard',
                index: 0,
                controller: controller,
              ),
              _NavItem(
                icon: ImageConstants.branchIcon,
                label: 'Inventory',
                index: 1,
                controller: controller,
              ),
              _NavItem(
                icon: ImageConstants.productIcon,
                label: 'Sell',
                index: 2,
                controller: controller,
              ),
              _NavItem(
                icon: ImageConstants.profileIcon,
                label: 'Profile',
                index: 3,
                controller: controller,
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

class _NavItem extends StatelessWidget {
  final String icon;
  final String label;
  final int index;
  final BranchAdminController controller;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.index,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = index == controller.currentIndex.value;
    return GestureDetector(
      onTap: () => controller.changeIndex(index),
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              color: isSelected ? ColorConstants.redColor : Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: Image.asset(
              icon,
              height: 20.h,
              width: 20.w,
              color: isSelected
                  ? ColorConstants.primaryColor
                  : ColorConstants.silverGrayColor,
            ),
          ),
          2.0.height,
          TextWidget(
            text: label,
            color: isSelected
                ? ColorConstants.redColor
                : ColorConstants.silverGrayColor,
          ),
        ],
      ),
    );
  }
}