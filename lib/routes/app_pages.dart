import 'package:venu_ghee/features/auth/presentation/screen/login_screen.dart';
import 'package:venu_ghee/features/home/presentation/widget/bottom_navigation_bar_widget.dart';
import 'package:venu_ghee/routes/app_routes.dart';
import 'package:get/get.dart';

class AppPages {
  static final routes = [
    GetPage(name: AppRoutes.loginScreen, page: () => LoginScreen()),

    GetPage(name: AppRoutes.signUpScreen, page: () => LoginScreen()),
    GetPage(name: AppRoutes.bottomNavigationBarWidget, page: () => BottomNavigationBarWidget()),

  ];
}
