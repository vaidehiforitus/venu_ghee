import 'package:get/get.dart';
import 'package:venu_ghee/core/utils/exports/common_exports.dart';
import 'package:venu_ghee/core/utils/validation/validation.dart';
import 'package:venu_ghee/core/utils/widgets/text_widget/text_field_widget/text_form_field_widget.dart';
import 'package:venu_ghee/core/utils/widgets/text_widget/text_widget/text_widget.dart';
import 'package:venu_ghee/features/auth/presentation/controller/auth_controller.dart';
import 'package:venu_ghee/routes/app_routes.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final loginFormKey = GlobalKey<FormState>();
  final AuthController controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: loginFormKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                30.0.height,

                Center(
                  child: Image.asset(
                    ThemeHelper.logoImage(),
                    height: 100.h,
                    width: 200.w,
                    fit: BoxFit.contain,
                  ),
                ),
                40.0.height,

                Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 16.w),
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 20.h,
                  ),
                  decoration: BoxDecoration(
                    color: ColorConstants.darkWhiteColor,
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(color: ColorConstants.borderWhiteColor),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        text: 'Sign in to your Account',
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w700,
                      ),
                      4.0.height,
                      TextWidget(
                        text: 'Enter your email and password to log in',
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w400,
                        color: ColorConstants.lightTextColor,
                      ),
                      20.0.height,

                      TextWidget(
                        text: 'Email',
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      6.0.height,
                      TextFormFieldWidget(
                        labelColor: ColorConstants.lightTextColor,
                        hintText: 'Loisbecket@gmail.com',
                        keyboardType: TextInputType.emailAddress,
                        controller: controller.emailController,
                        fillColor: ColorConstants.primaryColor,
                        borderColor: ColorConstants.borderColor,
                        focusedBorderColor: ColorConstants.textColor,
                        borderRadius: 8.r,
                      ),
                      16.0.height,
                      TextWidget(
                        text: 'Password',
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      6.0.height,
                      TextFormFieldWidget(
                        hintText: '*******',
                        labelColor: ColorConstants.lightTextColor,
                        enablePasswordToggle: true,
                        validator: AppValidation.validPassword,
                        controller: controller.passwordController,
                        fillColor: ColorConstants.primaryColor,
                        borderColor: ColorConstants.borderColor,
                        focusedBorderColor: ColorConstants.textColor,
                        borderRadius: 8.r,
                      ),
                      16.0.height,

                      Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () => Get.toNamed(AppRoutes.loginScreen),
                          child: TextWidget(
                            text: 'Forgot Password ?',
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: ColorConstants.redColor,
                          ),
                        ),
                      ),
                      24.0.height,

                      Obx(
                        () => PrimaryButton(
                          isLoading: controller.isLoading.value,
                          title: 'Log In',
                          buttonColor: ColorConstants.redColor,
                          titleColor: ColorConstants.primaryColor,
                          onPressed: () {
                            if (loginFormKey.currentState!.validate()) {
                              controller.login();
                            }
                          },
                          customRadius: 8.r,
                          height: 52.h,
                        ),
                      ),
                      24.0.height,

                      Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: ColorConstants.borderWhiteColor,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            child: TextWidget(
                              text: 'Or',
                              fontSize: 12.sp,
                              color: ColorConstants.lightTextColor,
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              color: ColorConstants.borderWhiteColor,
                            ),
                          ),
                        ],
                      ),
                      16.0.height,

                      _SocialButton(
                        iconPath: ImageConstants.googleIcon,
                        label: 'Continue with Google',
                        onTap: () {
                          // controller.googleLogin();
                        },
                      ),
                      20.0.height,

                      Center(
                        child: RichText(
                          text: TextSpan(
                            text: "Don't have an account?  ",
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: ColorConstants.lightTextColor,
                            ),
                            children: [
                              TextSpan(
                                text: 'Sign Up',
                                style: TextStyle(
                                  color: ColorConstants.redColor,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Get.toNamed(AppRoutes.signUpScreen);
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                40.0.height,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  final String iconPath;
  final String label;
  final VoidCallback onTap;

  const _SocialButton({
    required this.iconPath,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        height: 50.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: ColorConstants.primaryColor,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: ColorConstants.borderColor),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(iconPath, height: 22.h, width: 22.w),
            12.0.width,
            TextWidget(
              text: label,
            ),
          ],
        ),
      ),
    );
  }
}
