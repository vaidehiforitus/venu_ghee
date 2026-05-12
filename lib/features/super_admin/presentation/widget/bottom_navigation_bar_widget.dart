import 'package:get/get.dart';
import 'package:venu_ghee/core/utils/exports/common_exports.dart';
import 'package:venu_ghee/features/super_admin/presentation/screens/branch/branch_screen.dart';
import 'package:venu_ghee/features/super_admin/presentation/screens/dashboard/dashboard_screen.dart';
import 'package:venu_ghee/features/super_admin/presentation/screens/product/product_screen.dart';
import 'package:venu_ghee/features/super_admin/presentation/screens/profile_screen.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  BottomNavigationBarWidget({super.key});

  final MainController controller = Get.put(MainController());

  final List<Widget> _screens = [
    DashboardScreen(),
    BranchScreen(),
    ProductScreen(),
    ProfileScreen(),
  ];

  // @override
  // Widget build(BuildContext context) {
  //   return Obx(
  //         () => Scaffold(
  //       backgroundColor: ColorConstants.primaryColor,
  //       body: _screens[controller.currentIndex.value],
  //       bottomNavigationBar: _BottomNavBar(controller: controller),
  //     ),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isWeb = screenWidth > 600;

    return Obx(
          () => Scaffold(
        backgroundColor: ColorConstants.primaryColor,
        body: _screens[controller.currentIndex.value],
        bottomNavigationBar: isWeb ? null : _BottomNavBar(controller: controller),
      ),
    );
  }
}

class _BottomNavBar extends StatelessWidget {
  final MainController controller;
  const _BottomNavBar({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r),
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
                  currentIndex: controller.currentIndex.value,
                  onTap: () => controller.changeIndex(0),
                ),
                _NavItem(
                  icon: ImageConstants.branchIcon,
                  label: 'Branch',
                  index: 1,
                  currentIndex: controller.currentIndex.value,
                  onTap: () => controller.changeIndex(1),
                ),
                _NavItem(
                  icon: ImageConstants.productIcon,
                  label: 'Product',
                  index: 2,
                  currentIndex: controller.currentIndex.value,
                  onTap: () => controller.changeIndex(2),
                ),
                _NavItem(
                  icon: ImageConstants.profileIcon,
                  label: 'Profile',
                  index: 3,
                  currentIndex: controller.currentIndex.value,
                  onTap: () => controller.changeIndex(3),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final String icon;
  final String label;
  final int index;
  final int currentIndex;
  final VoidCallback onTap;

  const _NavItem({
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
class MainController extends GetxController {
  final RxInt currentIndex = 0.obs;

  void changeIndex(int index) {
    currentIndex.value = index;
  }
}