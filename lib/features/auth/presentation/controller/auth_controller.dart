import 'package:get/get.dart';
import 'package:venu_ghee/core/utils/exports/common_exports.dart';
import 'package:venu_ghee/features/auth/data/model/request_model/login_response_model.dart';
import 'package:venu_ghee/features/auth/data/repositories/auth_repo.dart';
import 'package:venu_ghee/routes/app_routes.dart';

class AuthController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final RxBool isLoading = false.obs;

  final AuthRepo _authRepo = AuthRepo();

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  Future<void> login() async {
    try {
      isLoading.value = true;

      final request = LoginRequestModel(
        identifier: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      final response = await _authRepo.login(request);

      if (response.accessToken != null) {
        CommonSnackBar.success('Login Successful!!');
        Get.offAllNamed(AppRoutes.bottomNavigationBarWidget);
      } else {
        ErrorHandler.handleError('Login failed. Please try again.');
      }
    } catch (e) {
      ErrorHandler.handleError('$e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> googleLogin() async {
    try {
      isLoading.value = true;
      await Future.delayed(const Duration(seconds: 1));
      CommonSnackBar.success('Google Login Successful!!');
      Get.offAllNamed(AppRoutes.bottomNavigationBarWidget);
    } catch (e) {
      ErrorHandler.handleError('$e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> facebookLogin() async {
    try {
      isLoading.value = true;
      await Future.delayed(const Duration(seconds: 1));
      CommonSnackBar.success('Facebook Login Successful!!');
      Get.offAllNamed(AppRoutes.bottomNavigationBarWidget);
    } catch (e) {
      ErrorHandler.handleError('$e');
    } finally {
      isLoading.value = false;
    }
  }
}