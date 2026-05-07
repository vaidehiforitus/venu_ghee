import 'package:get/get.dart';
import 'package:venu_ghee/core/utils/exports/common_exports.dart';
import 'package:venu_ghee/routes/app_routes.dart';

class AuthController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final RxBool isLoading = false.obs;

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  Future<void> login() async {
    try {
      isLoading.value = true;

      final String email = emailController.text.trim();
      final String password = passwordController.text.trim();

      // TODO: API call here
      await Future.delayed(const Duration(seconds: 2));

      CommonSnackBar.success('Login Successful!!');
      Get.offAllNamed(AppRoutes.loginScreen);

    } catch (e) {
      ErrorHandler.handleError('$e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> googleLogin() async {
    try {
      isLoading.value = true;

      // TODO: Google Sign In
      await Future.delayed(const Duration(seconds: 1));

      CommonSnackBar.success('Google Login Successful!!');
      Get.offAllNamed(AppRoutes.loginScreen);

    } catch (e) {
      ErrorHandler.handleError('$e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> facebookLogin() async {
    try {
      isLoading.value = true;

      // TODO: Facebook Sign In
      await Future.delayed(const Duration(seconds: 1));

      CommonSnackBar.success('Facebook Login Successful!!');
      Get.offAllNamed(AppRoutes.loginScreen);

    } catch (e) {
      ErrorHandler.handleError('$e');
    } finally {
      isLoading.value = false;
    }
  }
}