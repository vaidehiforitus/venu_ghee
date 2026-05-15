import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:venu_ghee/core/constants/storage_constants.dart';
import 'package:venu_ghee/routes/app_routes.dart';
import 'core/utils/exports/common_exports.dart';

class SplashController extends GetxController {
  final _box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    _navigate();
  }

  Future<void> _navigate() async {
    await Future.delayed(const Duration(milliseconds: 3400));

    final token = _box.read<String?>(StorageConstants.accessToken);
    final userType = _box.read<String?>(StorageConstants.userType) ?? '';

    if (token != null && token.isNotEmpty) {
      if (userType == 'super_admin') {
        Get.offAllNamed(AppRoutes.bottomNavigationBarWidget);
      } else if (userType == 'branch') {
        Get.offAllNamed(AppRoutes.branchAdminBottomNavigationBar);
      } else {
        Get.offAllNamed(AppRoutes.bottomNavigationBarWidget);
      }
    } else {
      Get.offAllNamed(AppRoutes.loginScreen);
    }
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());

    return AppBackground(
      child: Scaffold(
        backgroundColor: ColorConstants.transparentColor,
        body: Center(
          child: Image.asset(
            ImageConstants.appLogo,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}