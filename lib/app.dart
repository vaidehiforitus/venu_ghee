import 'package:get/get.dart';
import 'package:venu_ghee/routes/app_pages.dart';
import 'package:venu_ghee/core/theme/theme_controller.dart';
import 'package:venu_ghee/routes/app_routes.dart';
import 'core/theme/app_theme.dart';
import 'core/utils/exports/common_exports.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      builder: (context, child) {
        return GetBuilder<ThemeController>(
          init: ThemeController(),
          builder: (controller) {
            return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              // super_admin: GroupChatScreen(),
              getPages: AppPages.routes,
              initialRoute: AppRoutes.loginScreen,
              theme: AppThemes.lightTheme,
              darkTheme: AppThemes.darkTheme,
              themeMode: controller.themeMode,
            );
          },
        );
      },
    );
  }
}
