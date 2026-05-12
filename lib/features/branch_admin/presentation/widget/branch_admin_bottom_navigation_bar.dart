import 'package:get/get.dart';
import 'package:venu_ghee/core/utils/exports/common_exports.dart';
import 'package:venu_ghee/features/branch_admin/presentation/screen/branch_dashboard_screen.dart';
import 'package:venu_ghee/features/branch_admin/presentation/screen/branch_inventory_screen.dart';
import 'package:venu_ghee/features/branch_admin/presentation/screen/branch_sell_history_screen.dart';
import 'package:venu_ghee/features/branch_admin/presentation/screen/branch_sell_screen.dart';
import 'package:venu_ghee/features/super_admin/presentation/screens/profile_screen.dart';

class BranchAdminBottomNavigationBar extends StatelessWidget {
  BranchAdminBottomNavigationBar({super.key});

  final BranchAdminController controller = Get.put(BranchAdminController());

  final List<Widget> _screens = [
    BranchDashboardScreen(),
    InventoryScreen(),
    BranchSellScreen(),
    SellHistoryScreen(),
  ];

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
  final BranchAdminController controller;
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
  final String icon;        // ← IconData થી String
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
class BranchAdminController extends GetxController {
  final RxInt currentIndex = 0.obs;

  void changeIndex(int index) {
    currentIndex.value = index;
  }
  final List<Widget> pages = [
    BranchDashboardScreen(),
    InventoryScreen(),
    BranchSellScreen(),
    SellHistoryScreen(),
    ProfileScreen(),
    ProfileScreen(),
  ];
}