import 'package:get/get.dart';
import 'package:venu_ghee/core/utils/exports/common_exports.dart';
import 'package:venu_ghee/core/utils/validation/validation.dart';
import 'package:venu_ghee/features/auth/presentation/controller/auth_controller.dart';
import 'package:venu_ghee/routes/app_routes.dart';

double adaptiveFont(BuildContext context, double size) {
  final w = MediaQuery.of(context).size.width;
  if (w < 600) return size;
  if (w < 1024) return size * 0.90;
  return size * 0.80;
}

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final loginFormKey = GlobalKey<FormState>();
  final AuthController controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    if (w < 600) return _MobileLoginLayout(loginFormKey: loginFormKey, controller: controller);
    if (w < 1024) return _TabletLoginLayout(loginFormKey: loginFormKey, controller: controller);
    return _WebLoginLayout(loginFormKey: loginFormKey, controller: controller);
  }
}

class _MobileLoginLayout extends StatelessWidget {
  final GlobalKey<FormState> loginFormKey;
  final AuthController controller;
  const _MobileLoginLayout({required this.loginFormKey, required this.controller});

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
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                  decoration: BoxDecoration(
                    color: ColorConstants.darkWhiteColor,
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(color: ColorConstants.borderWhiteColor),
                  ),
                  child: _LoginFormContent(
                    loginFormKey: loginFormKey,
                    controller: controller,
                    isMobile: true,
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

class _TabletLoginLayout extends StatelessWidget {
  final GlobalKey<FormState> loginFormKey;
  final AuthController controller;
  const _TabletLoginLayout({required this.loginFormKey, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.darkWhiteColor,
      body: AppBackground(
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Form(
                key: loginFormKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: SizedBox(
                  width: 480,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        ThemeHelper.logoImage(),
                        height: 90,
                        width: 180,
                        fit: BoxFit.contain,
                      ),
                      32.0.height,
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 28, vertical: 28),
                        decoration: BoxDecoration(
                          color: ColorConstants.primaryColor,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: ColorConstants.borderWhiteColor),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 20,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: _LoginFormContent(
                          loginFormKey: loginFormKey,
                          controller: controller,
                          isMobile: false,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _WebLoginLayout extends StatelessWidget {
  final GlobalKey<FormState> loginFormKey;
  final AuthController controller;
  const _WebLoginLayout({required this.loginFormKey, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.darkWhiteColor,
      body: Row(
        children: [
          Expanded(
            // flex: 5,
            flex: 3,
            child: Container(
              height: double.infinity,
              color: ColorConstants.primaryColor,
              child: Stack(
                children: [
                  // Background illustration
                  // Positioned(
                  //   bottom: 60,
                  //   left: 0,
                  //   right: 0,
                  //   child: Opacity(
                  //     opacity: 0.15,
                  //     child: Image.asset(
                  //       ThemeHelper.logoImage(),
                  //       fit: BoxFit.fitWidth,
                  //     ),
                  //   ),
                  // ),
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          ThemeHelper.logoImage(),
                          height: 120,
                          width: 220,
                          fit: BoxFit.contain,
                        ),
                        32.0.height,
                        // TextWidget(
                        //   text: 'Venu Ghee',
                        //   fontSize: adaptiveFont(context, 32),
                        //   fontWeight: FontWeight.w700,
                        //   color: ColorConstants.redColor,
                        //   textAlign: TextAlign.center,
                        // ),
                        // 12.0.height,
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(horizontal: 40),
                        //   child: TextWidget(
                        //     text: 'Manage your branches, inventory\nand sales all in one place.',
                        //     fontSize: adaptiveFont(context, 15),
                        //     color: ColorConstants.lightTextColor,
                        //     textAlign: TextAlign.center,
                        //     maxLines: 3,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          Expanded(
            flex: 4,
            child: Container(
              height: double.infinity,
              color: ColorConstants.darkWhiteColor,
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 48, vertical: 40),
                  child: Form(
                    key: loginFormKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 420),
                      child: Container(
                        padding: const EdgeInsets.all(32),
                        decoration: BoxDecoration(
                          color: ColorConstants.primaryColor,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                              color: ColorConstants.borderWhiteColor),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 24,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: _LoginFormContent(
                          loginFormKey: loginFormKey,
                          controller: controller,
                          isMobile: false,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LoginFormContent extends StatelessWidget {
  final GlobalKey<FormState> loginFormKey;
  final AuthController controller;
  final bool isMobile;

  const _LoginFormContent({
    required this.loginFormKey,
    required this.controller,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(
          text: 'Sign in to your Account',
          fontSize: isMobile ? 22.sp : adaptiveFont(context, 22),
          fontWeight: FontWeight.w700,
          color: ColorConstants.textColor,
        ),
        SizedBox(height: isMobile ? 4.h : 4),
        TextWidget(
          text: 'Enter your email and password to log in',
          fontSize: isMobile ? 13.sp : adaptiveFont(context, 13),
          fontWeight: FontWeight.w400,
          color: ColorConstants.lightTextColor,
        ),
        SizedBox(height: isMobile ? 20.h : 24),

        TextWidget(
          text: 'Email',
          fontSize: isMobile ? 12.sp : adaptiveFont(context, 12),
          fontWeight: FontWeight.w500,
          color: ColorConstants.textColor,
        ),
        SizedBox(height: isMobile ? 6.h : 6),
        TextFormFieldWidget(
          labelColor: ColorConstants.lightTextColor,
          hintText: 'Loisbecket@gmail.com',
          keyboardType: TextInputType.emailAddress,
          controller: controller.emailController,
          fillColor: isMobile ? ColorConstants.primaryColor : ColorConstants.darkWhiteColor,
          borderColor: ColorConstants.borderColor,
          focusedBorderColor: ColorConstants.textColor,
          borderRadius: isMobile ? 8.r : 8,
        ),
        SizedBox(height: isMobile ? 16.h : 16),

        TextWidget(
          text: 'Password',
          fontSize: isMobile ? 12.sp : adaptiveFont(context, 12),
          fontWeight: FontWeight.w500,
          color: ColorConstants.textColor,
        ),
        SizedBox(height: isMobile ? 6.h : 6),
        TextFormFieldWidget(
          hintText: '*******',
          labelColor: ColorConstants.lightTextColor,
          enablePasswordToggle: true,
          validator: AppValidation.validPassword,
          controller: controller.passwordController,
          fillColor: isMobile ? ColorConstants.primaryColor : ColorConstants.darkWhiteColor,
          borderColor: ColorConstants.borderColor,
          focusedBorderColor: ColorConstants.textColor,
          borderRadius: isMobile ? 8.r : 8,
        ),
        SizedBox(height: isMobile ? 16.h : 12),

        Align(
          alignment: Alignment.centerRight,
          child: InkWell(
            onTap: () => Get.toNamed(AppRoutes.loginScreen),
            child: TextWidget(
              text: 'Forgot Password ?',
              fontSize: isMobile ? 12.sp : adaptiveFont(context, 12),
              fontWeight: FontWeight.w600,
              color: ColorConstants.redColor,
            ),
          ),
        ),
        SizedBox(height: isMobile ? 24.h : 24),

        Obx(
              () => PrimaryButton(
                fontSize: isMobile ? 14.sp : adaptiveFont(context, 16),
            isLoading: controller.isLoading.value,
            title: 'Log In',
            buttonColor: ColorConstants.redColor,
            titleColor: ColorConstants.primaryColor,
            onPressed: () {
              if (loginFormKey.currentState!.validate()) {
                controller.login();
              }
            },
            customRadius: isMobile ? 8.r : 8,
            height: isMobile ? 52.h : 48,
          ),
        ),
        SizedBox(height: isMobile ? 24.h : 24),

        Row(
          children: [
            Expanded(child: Divider(color: ColorConstants.borderWhiteColor)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: isMobile ? 12.w : 12),
              child: TextWidget(
                text: 'Or',
                fontSize: isMobile ? 12.sp : adaptiveFont(context, 12),
                color: ColorConstants.lightTextColor,
              ),
            ),
            Expanded(child: Divider(color: ColorConstants.borderWhiteColor)),
          ],
        ),
        SizedBox(height: isMobile ? 16.h : 16),

        _SocialButton(
          iconPath: ImageConstants.googleIcon,
          label: 'Continue with Google',
          isMobile: isMobile,
          onTap: () {},
        ),
        SizedBox(height: isMobile ? 20.h : 20),

        Center(
          child: RichText(
            text: TextSpan(
              text: "Don't have an account?  ",
              style: TextStyle(
                fontSize: isMobile ? 12.sp : adaptiveFont(context, 12),
                fontWeight: FontWeight.w500,
                color: ColorConstants.lightTextColor,
              ),
              children: [
                TextSpan(
                  text: 'Sign Up',
                  style: TextStyle(
                    color: ColorConstants.redColor,
                    fontSize: isMobile ? 12.sp : adaptiveFont(context, 12),
                    fontWeight: FontWeight.w600,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      // Get.toNamed(AppRoutes.branchAdminBottomNavigationBar);
                      Get.toNamed(AppRoutes.bottomNavigationBarWidget);
                    },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _SocialButton extends StatelessWidget {
  final String iconPath;
  final String label;
  final VoidCallback onTap;
  final bool isMobile;

  const _SocialButton({
    required this.iconPath,
    required this.label,
    required this.onTap,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(isMobile ? 8.r : 8),
      child: Container(
        height: isMobile ? 50.h : 48,
        width: double.infinity,
        decoration: BoxDecoration(
          color: isMobile ? ColorConstants.primaryColor : ColorConstants.darkWhiteColor,
          borderRadius: BorderRadius.circular(isMobile ? 8.r : 8),
          border: Border.all(color: ColorConstants.borderColor),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(iconPath,
                height: isMobile ? 22.h : 22,
                width: isMobile ? 22.w : 22),
            SizedBox(width: isMobile ? 12.w : 12),
            TextWidget(
              text: label,
              fontSize: isMobile ? 13.sp : adaptiveFont(context, 13),
              color: ColorConstants.textColor,
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
      ),
    );
  }
}


// import 'package:get/get.dart';
// import 'package:venu_ghee/core/utils/exports/common_exports.dart';
// import 'package:venu_ghee/core/utils/validation/validation.dart';
// import 'package:venu_ghee/features/auth/presentation/controller/auth_controller.dart';
// import 'package:venu_ghee/routes/app_routes.dart';
//
// class LoginScreen extends StatelessWidget {
//   LoginScreen({super.key});
//
//   final loginFormKey = GlobalKey<FormState>();
//   final AuthController controller = Get.put(AuthController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: ColorConstants.primaryColor,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Form(
//             key: loginFormKey,
//             autovalidateMode: AutovalidateMode.onUserInteraction,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 30.0.height,
//
//                 Center(
//                   child: Image.asset(
//                     ThemeHelper.logoImage(),
//                     height: 100.h,
//                     width: 200.w,
//                     fit: BoxFit.contain,
//                   ),
//                 ),
//                 40.0.height,
//
//                 Container(
//                   width: double.infinity,
//                   margin: EdgeInsets.symmetric(horizontal: 16.w),
//                   padding: EdgeInsets.symmetric(
//                     horizontal: 20.w,
//                     vertical: 20.h,
//                   ),
//                   decoration: BoxDecoration(
//                     color: ColorConstants.darkWhiteColor,
//                     borderRadius: BorderRadius.circular(16.r),
//                     border: Border.all(color: ColorConstants.borderWhiteColor),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       TextWidget(
//                         text: 'Sign in to your Account',
//                         fontSize: 22.sp,
//                         fontWeight: FontWeight.w700,
//                       ),
//                       4.0.height,
//                       TextWidget(
//                         text: 'Enter your email and password to log in',
//                         fontSize: 13.sp,
//                         fontWeight: FontWeight.w400,
//                         color: ColorConstants.lightTextColor,
//                       ),
//                       20.0.height,
//
//                       TextWidget(
//                         text: 'Email',
//                         fontSize: 12.sp,
//                         fontWeight: FontWeight.w500,
//                       ),
//                       6.0.height,
//                       TextFormFieldWidget(
//                         labelColor: ColorConstants.lightTextColor,
//                         hintText: 'Loisbecket@gmail.com',
//                         keyboardType: TextInputType.emailAddress,
//                         controller: controller.emailController,
//                         fillColor: ColorConstants.primaryColor,
//                         borderColor: ColorConstants.borderColor,
//                         focusedBorderColor: ColorConstants.textColor,
//                         borderRadius: 8.r,
//                       ),
//                       16.0.height,
//                       TextWidget(
//                         text: 'Password',
//                         fontSize: 12.sp,
//                         fontWeight: FontWeight.w500,
//                       ),
//                       6.0.height,
//                       TextFormFieldWidget(
//                         hintText: '*******',
//                         labelColor: ColorConstants.lightTextColor,
//                         enablePasswordToggle: true,
//                         validator: AppValidation.validPassword,
//                         controller: controller.passwordController,
//                         fillColor: ColorConstants.primaryColor,
//                         borderColor: ColorConstants.borderColor,
//                         focusedBorderColor: ColorConstants.textColor,
//                         borderRadius: 8.r,
//                       ),
//                       16.0.height,
//
//                       Align(
//                         alignment: Alignment.centerRight,
//                         child: InkWell(
//                           onTap: () => Get.toNamed(AppRoutes.loginScreen),
//                           child: TextWidget(
//                             text: 'Forgot Password ?',
//                             fontSize: 12.sp,
//                             fontWeight: FontWeight.w600,
//                             color: ColorConstants.redColor,
//                           ),
//                         ),
//                       ),
//                       24.0.height,
//
//                       Obx(
//                         () => PrimaryButton(
//                           isLoading: controller.isLoading.value,
//                           title: 'Log In',
//                           buttonColor: ColorConstants.redColor,
//                           titleColor: ColorConstants.primaryColor,
//                           onPressed: () {
//                             if (loginFormKey.currentState!.validate()) {
//                               controller.login();
//                             }
//                           },
//                           customRadius: 8.r,
//                           height: 52.h,
//                         ),
//                       ),
//                       24.0.height,
//
//                       Row(
//                         children: [
//                           Expanded(
//                             child: Divider(
//                               color: ColorConstants.borderWhiteColor,
//                             ),
//                           ),
//                           Padding(
//                             padding: EdgeInsets.symmetric(horizontal: 12.w),
//                             child: TextWidget(
//                               text: 'Or',
//                               fontSize: 12.sp,
//                               color: ColorConstants.lightTextColor,
//                             ),
//                           ),
//                           Expanded(
//                             child: Divider(
//                               color: ColorConstants.borderWhiteColor,
//                             ),
//                           ),
//                         ],
//                       ),
//                       16.0.height,
//
//                       _SocialButton(
//                         iconPath: ImageConstants.googleIcon,
//                         label: 'Continue with Google',
//                         onTap: () {
//                           // controller.googleLogin();
//                         },
//                       ),
//                       20.0.height,
//
//                       Center(
//                         child: RichText(
//                           text: TextSpan(
//                             text: "Don't have an account?  ",
//                             style: TextStyle(
//                               fontSize: 12.sp,
//                               fontWeight: FontWeight.w500,
//                               color: ColorConstants.lightTextColor,
//                             ),
//                             children: [
//                               TextSpan(
//                                 text: 'Sign Up',
//                                 style: TextStyle(
//                                   color: ColorConstants.redColor,
//                                   fontSize: 12.sp,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                                 recognizer: TapGestureRecognizer()
//                                   ..onTap = () {
//                                     Get.toNamed(
//                                       AppRoutes.branchAdminBottomNavigationBar,
//                                     );
//                                   },
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 40.0.height,
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class _SocialButton extends StatelessWidget {
//   final String iconPath;
//   final String label;
//   final VoidCallback onTap;
//
//   const _SocialButton({
//     required this.iconPath,
//     required this.label,
//     required this.onTap,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       borderRadius: BorderRadius.circular(8.r),
//       child: Container(
//         height: 50.h,
//         width: double.infinity,
//         decoration: BoxDecoration(
//           color: ColorConstants.primaryColor,
//           borderRadius: BorderRadius.circular(8.r),
//           border: Border.all(color: ColorConstants.borderColor),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Image.asset(iconPath, height: 22.h, width: 22.w),
//             12.0.width,
//             TextWidget(text: label),
//           ],
//         ),
//       ),
//     );
//   }
// }
