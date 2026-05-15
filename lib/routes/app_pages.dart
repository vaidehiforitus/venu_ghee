import 'package:venu_ghee/features/auth/presentation/screen/login_screen.dart';
import 'package:venu_ghee/features/branch_admin/presentation/widget/branch_admin_bottom_navigation_bar.dart';
import 'package:venu_ghee/features/super_admin/presentation/widget/bottom_navigation_bar_widget.dart';
import 'package:venu_ghee/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:venu_ghee/splash_screen.dart';

class AppPages {
  static final routes = [
    GetPage(name: AppRoutes.loginScreen, page: () => LoginScreen()),

    GetPage(name: AppRoutes.signUpScreen, page: () => LoginScreen()),
    GetPage(
      name: AppRoutes.bottomNavigationBarWidget,
      page: () => BottomNavigationBarWidget(),
    ),
    GetPage(
      name: AppRoutes.branchAdminBottomNavigationBar,
      page: () => BranchAdminBottomNavigationBar(),
    ),
    GetPage(name: AppRoutes.splashScreen, page: () => SplashScreen()),
  ];
}
