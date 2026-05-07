import 'package:get/get.dart';
import 'package:venu_ghee/core/utils/exports/common_exports.dart';
import 'package:venu_ghee/features/home/presentation/controller/branch_controller.dart';
import 'package:venu_ghee/features/home/presentation/screens/branch/add_payment_screen.dart';

class AddBranchScreen extends StatelessWidget {
  AddBranchScreen({super.key});

  final BranchController controller = Get.find<BranchController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.primaryColor,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(ImageConstants.bgImage, fit: BoxFit.cover),
          ),

          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 16.h,
                  ),
                  child: TextWidget(
                    text: 'Add Branch',
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: ColorConstants.redColor,
                  ),
                ),

                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Container(
                      padding: EdgeInsets.all(16.r),
                      decoration: BoxDecoration(
                        color: ColorConstants.darkWhiteColor,
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(
                          color: ColorConstants.borderWhiteColor,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextWidget(
                            text: 'Owner Name',
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          6.0.height,
                          TextFormFieldWidget(
                            controller: controller.ownerController,
                            hintText: 'Owner Name',
                            fillColor: ColorConstants.primaryColor,
                            borderColor: ColorConstants.borderColor,
                            focusedBorderColor: ColorConstants.textColor,
                          ),
                          16.0.height,

                          TextWidget(
                            text: 'Branch Name',
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          6.0.height,
                          TextFormFieldWidget(
                            controller: controller.nameController,
                            hintText: 'Branch Name',
                            fillColor: ColorConstants.primaryColor,
                            borderColor: ColorConstants.borderColor,
                            focusedBorderColor: ColorConstants.textColor,
                          ),
                          16.0.height,

                          TextWidget(
                            text: 'Address',
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          6.0.height,
                          TextFormFieldWidget(
                            controller: controller.addressController,
                            hintText: 'Street Address',
                            fillColor: ColorConstants.primaryColor,
                            borderColor: ColorConstants.borderColor,
                            focusedBorderColor: ColorConstants.textColor,
                          ),
                          10.0.height,
                          Row(
                            children: [
                              Expanded(
                                child: TextFormFieldWidget(
                                  controller: controller.stateController,
                                  hintText: 'State / Province',
                                  fillColor: ColorConstants.primaryColor,
                                  borderColor: ColorConstants.borderColor,
                                  focusedBorderColor: ColorConstants.textColor,
                                ),
                              ),
                              10.0.width,
                              Expanded(
                                child: TextFormFieldWidget(
                                  controller: controller.zipController,
                                  hintText: 'Zip Code',
                                  keyboardType: TextInputType.number,
                                  fillColor: ColorConstants.primaryColor,
                                  borderColor: ColorConstants.borderColor,
                                  focusedBorderColor: ColorConstants.textColor,
                                ),
                              ),
                            ],
                          ),
                          16.0.height,

                          TextWidget(
                            text: 'Email',
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          6.0.height,
                          TextFormFieldWidget(
                            controller: controller.emailController,
                            hintText: 'dummy@gmail.com',
                            keyboardType: TextInputType.emailAddress,
                            fillColor: ColorConstants.primaryColor,
                            borderColor: ColorConstants.borderColor,
                            focusedBorderColor: ColorConstants.textColor,
                          ),
                          16.0.height,

                          TextWidget(
                            text: 'Mobile Number',
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          6.0.height,
                          TextFormFieldWidget(
                            controller: controller.phoneController,
                            hintText: '00000 - 00000',
                            keyboardType: TextInputType.phone,
                            prefixIcon: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10.w,
                                vertical: 12.h,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('🇮🇳', style: TextStyle(fontSize: 16.sp)),
                                  4.0.width,
                                  TextWidget(
                                    text: '+91',
                                    fontSize: 13.sp,
                                    color: ColorConstants.textColor,
                                  ),
                                  8.0.width,
                                  Container(
                                    height: 20.h,
                                    width: 1,
                                    color: ColorConstants.borderColor,
                                  ),
                                ],
                              ),
                            ),
                            fillColor: ColorConstants.primaryColor,
                            borderColor: ColorConstants.borderColor,
                            focusedBorderColor: ColorConstants.textColor,
                          ),
                          16.0.height,

                          TextWidget(
                            text: 'Password',
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          6.0.height,
                          TextFormFieldWidget(
                            controller: controller.passwordController,
                            hintText: 'Password',
                            enablePasswordToggle: true,
                            fillColor: ColorConstants.primaryColor,
                            borderColor: ColorConstants.borderColor,
                            focusedBorderColor: ColorConstants.textColor,
                          ),
                          16.0.height,

                          TextWidget(
                            text: 'Confirm Password',
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          6.0.height,
                          TextFormFieldWidget(
                            controller: controller.confirmPasswordController,
                            hintText: 'Confirm Password',
                            enablePasswordToggle: true,
                            fillColor: ColorConstants.primaryColor,
                            borderColor: ColorConstants.borderColor,
                            focusedBorderColor: ColorConstants.textColor,
                          ),
                          24.0.height,

                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              PrimaryButton(
                                title: 'Cancel',
                                height: 44.h,
                                width: 100.w,
                                buttonColor: Colors.transparent,
                                titleColor: ColorConstants.textColor,
                                customRadius: 30.r,
                                border: BorderSide(color: ColorConstants.borderColor), // ← border
                                onPressed: () => Get.back(),
                              ),
                              16.0.width,

                              Obx(
                                    () => PrimaryButton(
                                  isLoading: controller.isSubmitting.value,
                                  title: 'Next',
                                  height: 44.h,
                                  width: 100.w,
                                  buttonColor: ColorConstants.redColor,
                                  titleColor: ColorConstants.primaryColor,
                                  customRadius: 30.r,
                                  onPressed: () => Get.to(() => AddPaymentScreen()),
                                ),
                              ),
                            ],
                          ),
                          10.0.height,
                        ],
                      ),
                    ),
                  ),
                ),
                16.0.height,
              ],
            ),
          ),
        ],
      ),
    );
  }
}