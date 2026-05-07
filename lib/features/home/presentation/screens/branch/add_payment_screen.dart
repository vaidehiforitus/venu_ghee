import 'package:get/get.dart';
import 'package:venu_ghee/core/utils/exports/common_exports.dart';
import 'package:venu_ghee/features/home/presentation/controller/branch_controller.dart';
import 'package:venu_ghee/features/home/presentation/screens/branch/branch_add_product_screen.dart';

class AddPaymentScreen extends StatelessWidget {
  AddPaymentScreen({super.key});

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
                    text: 'Add Payment',
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
                            text: 'Bank Name',
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          6.0.height,
                          TextFormFieldWidget(
                            controller: controller.bankNameController,
                            hintText: 'Bank Name',
                            fillColor: ColorConstants.primaryColor,
                            borderColor: ColorConstants.borderColor,
                            focusedBorderColor: ColorConstants.textColor,
                          ),
                          16.0.height,

                          TextWidget(
                            text: 'Account No.',
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          6.0.height,
                          TextFormFieldWidget(
                            controller: controller.accountNoController,
                            hintText: 'Account No.',
                            keyboardType: TextInputType.number,
                            fillColor: ColorConstants.primaryColor,
                            borderColor: ColorConstants.borderColor,
                            focusedBorderColor: ColorConstants.textColor,
                          ),
                          16.0.height,

                          TextWidget(
                            text: 'IFSC Code',
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          6.0.height,
                          TextFormFieldWidget(
                            controller: controller.ifscController,
                            hintText: 'IFSC Code',
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
                                border: BorderSide(
                                  color: ColorConstants.borderColor,
                                ),
                                // ← border
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
                                  onPressed: () =>
                                      Get.to(() => BranchAddProductScreen()),
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
