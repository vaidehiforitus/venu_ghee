import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:venu_ghee/core/utils/exports/common_exports.dart';
import 'package:venu_ghee/features/auth/data/model/request_model/login_response_model.dart';
import 'package:venu_ghee/features/auth/data/repositories/auth_repo.dart';
import 'package:venu_ghee/routes/app_routes.dart';

class AuthController extends GetxController {
  late TextEditingController emailController;
  late TextEditingController passwordController;

  final RxBool isLoading = false.obs;

  final AuthRepo _authRepo = AuthRepo();
  final _box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

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
        emailController.clear();
        passwordController.clear();
        CommonSnackBar.success('Login Successful!!');
        if (response.userType == 'super_admin') {
          Get.offAllNamed(AppRoutes.bottomNavigationBarWidget);
        } else if (response.userType == 'branch') {
          Get.offAllNamed(AppRoutes.branchAdminBottomNavigationBar);
        } else {
          Get.offAllNamed(AppRoutes.bottomNavigationBarWidget);
        }
      } else {
        ErrorHandler.handleError('Login failed. Please try again.');
      }
    } catch (e) {
      ErrorHandler.handleError('$e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    try {
      isLoading.value = true;
      await _authRepo.logout();
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