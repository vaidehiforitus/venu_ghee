import 'package:get/get.dart';
import 'package:venu_ghee/core/utils/exports/common_exports.dart';
import 'package:venu_ghee/core/utils/widgets/responsive_helper/responsive_helper.dart';
import 'package:venu_ghee/features/super_admin/presentation/controller/branch_controller.dart';
import 'package:venu_ghee/features/super_admin/presentation/screens/branch/branch_add_product_screen.dart';
import 'package:venu_ghee/features/super_admin/presentation/widget/adaptive_scaffold.dart';

class AddPaymentScreen extends StatelessWidget {
  AddPaymentScreen({super.key});

  final BranchController controller = Get.find<BranchController>();

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    if (w < 600) return _MobileAddPaymentLayout(controller: controller);
    return AdaptiveScaffold(
      title: 'Add Payment',
      showBreadcrumbIcon: true,
      mobileBody: _MobileAddPaymentLayout(controller: controller),
      tabletBody: _DesktopAddPaymentBody(controller: controller),
    );
  }
}

class _MobileAddPaymentLayout extends StatelessWidget {
  final BranchController controller;
  const _MobileAddPaymentLayout({required this.controller});

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: Scaffold(
        backgroundColor: ColorConstants.transparentColor,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
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
                  child: _PaymentFormCard(controller: controller, isMobile: true),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                child: const _StepIndicator(currentStep: 1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DesktopAddPaymentBody extends StatelessWidget {
  final BranchController controller;
  const _DesktopAddPaymentBody({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 72),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  TextWidget(
                    text: 'Add Payment',
                    fontSize: adaptiveFont(context, 22),
                    fontWeight: FontWeight.w700,
                    color: ColorConstants.textColor,
                  ),
                  const Spacer(),
                  _OutlineBtn(label: 'Cancel', onTap: () => Get.back()),
                  12.0.width,
                  Obx(() => _FilledBtn(
                    label: 'Next',
                    isLoading: controller.isSubmitting.value,
                    onTap: () => Get.to(() => BranchAddProductScreen()),
                  )),
                ],
              ),
              24.0.height,
              _PaymentFormCard(controller: controller, isMobile: false),
            ],
          ),
        ),

        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: const _StepIndicator(currentStep: 1),
          ),
        ),
      ],
    );
  }
}

class _PaymentFormCard extends StatelessWidget {
  final BranchController controller;
  final bool isMobile;

  const _PaymentFormCard({required this.controller, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: isMobile ? EdgeInsets.all(16.r) : const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: ColorConstants.darkWhiteColor,
        borderRadius: BorderRadius.circular(isMobile ? 16.r : 16),
        border: Border.all(color: ColorConstants.borderWhiteColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _fieldLabel(context, 'Bank Name', isMobile),
          SizedBox(height: isMobile ? 6.h : 6),
          TextFormFieldWidget(
            controller: controller.bankNameController,
            hintText: 'Bank Name',
            fillColor: ColorConstants.primaryColor,
            borderColor: ColorConstants.borderColor,
            focusedBorderColor: ColorConstants.textColor,
          ),

          SizedBox(height: isMobile ? 16.h : 16),

          if (isMobile) ...[
            _fieldLabel(context, 'Account No.', isMobile),
            SizedBox(height: 6.h),
            TextFormFieldWidget(
              controller: controller.accountNoController,
              hintText: 'Account No.',
              keyboardType: TextInputType.number,
              fillColor: ColorConstants.primaryColor,
              borderColor: ColorConstants.borderColor,
              focusedBorderColor: ColorConstants.textColor,
            ),
            SizedBox(height: 16.h),
            _fieldLabel(context, 'IFSC Code', isMobile),
            SizedBox(height: 6.h),
            TextFormFieldWidget(
              controller: controller.ifscController,
              hintText: 'IFSC Code',
              fillColor: ColorConstants.primaryColor,
              borderColor: ColorConstants.borderColor,
              focusedBorderColor: ColorConstants.textColor,
            ),
          ] else ...[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _fieldLabel(context, 'Account No.', isMobile),
                      const SizedBox(height: 6),
                      TextFormFieldWidget(
                        controller: controller.accountNoController,
                        hintText: 'Account No.',
                        keyboardType: TextInputType.number,
                        fillColor: ColorConstants.primaryColor,
                        borderColor: ColorConstants.borderColor,
                        focusedBorderColor: ColorConstants.textColor,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _fieldLabel(context, 'IFSC Code', isMobile),
                      const SizedBox(height: 6),
                      TextFormFieldWidget(
                        controller: controller.ifscController,
                        hintText: 'IFSC Code',
                        fillColor: ColorConstants.primaryColor,
                        borderColor: ColorConstants.borderColor,
                        focusedBorderColor: ColorConstants.textColor,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],

          if (isMobile) ...[
            SizedBox(height: 24.h),
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
                  border: BorderSide(color: ColorConstants.borderColor),
                  onPressed: () => Get.back(),
                ),
                16.0.width,
                Obx(() => PrimaryButton(
                  isLoading: controller.isSubmitting.value,
                  title: 'Next',
                  height: 44.h,
                  width: 100.w,
                  buttonColor: ColorConstants.redColor,
                  titleColor: ColorConstants.primaryColor,
                  customRadius: 30.r,
                  onPressed: () => Get.to(() => BranchAddProductScreen()),
                )),
              ],
            ),
            10.0.height,
          ],
        ],
      ),
    );
  }

  Widget _fieldLabel(BuildContext context, String text, bool isMobile) {
    return TextWidget(
      text: text,
      fontSize: isMobile ? 12.sp : adaptiveFont(context, 12),
      fontWeight: FontWeight.w500,
      color: ColorConstants.textColor,
    );
  }
}

class _StepIndicator extends StatelessWidget {
  final int currentStep;
  const _StepIndicator({required this.currentStep});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (i) {
        final isActive = i == currentStep;
        final isDone = i < currentStep;
        return Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              width: isActive ? 36 : 30,
              height: isActive ? 36 : 30,
              decoration: BoxDecoration(
                color: isActive || isDone
                    ? ColorConstants.redColor
                    : ColorConstants.primaryColor,
                shape: BoxShape.circle,
                border: Border.all(
                  color: isActive || isDone
                      ? ColorConstants.redColor
                      : ColorConstants.borderColor,
                  width: 1.5,
                ),
              ),
              child: Center(
                child: isDone
                    ? Icon(Icons.check,
                    size: 14, color: ColorConstants.primaryColor)
                    : Text(
                  '${i + 1}',
                  style: TextStyle(
                    fontSize: adaptiveFont(context, 13),
                    fontWeight: FontWeight.w600,
                    color: isActive
                        ? ColorConstants.primaryColor
                        : ColorConstants.lightTextColor,
                  ),
                ),
              ),
            ),
            if (i < 2)
              Row(
                children: List.generate(
                  5,
                      (d) => Container(
                    width: 7,
                    height: 1.5,
                    margin: const EdgeInsets.symmetric(horizontal: 1.5),
                    color: i < currentStep
                        ? ColorConstants.redColor
                        : ColorConstants.borderColor,
                  ),
                ),
              ),
          ],
        );
      }),
    );
  }
}

class _OutlineBtn extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _OutlineBtn({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 9),
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(color: ColorConstants.borderColor),
          borderRadius: BorderRadius.circular(30),
        ),
        child: TextWidget(
          text: label,
          fontSize: adaptiveFont(context, 13),
          fontWeight: FontWeight.w500,
          color: ColorConstants.textColor,
        ),
      ),
    );
  }
}

class _FilledBtn extends StatelessWidget {
  final String label;
  final bool isLoading;
  final VoidCallback onTap;
  const _FilledBtn(
      {required this.label, required this.onTap, this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 9),
        decoration: BoxDecoration(
          color: ColorConstants.redColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: isLoading
            ? SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(
                strokeWidth: 2, color: ColorConstants.primaryColor))
            : TextWidget(
          text: label,
          fontSize: adaptiveFont(context, 13),
          fontWeight: FontWeight.w600,
          color: ColorConstants.primaryColor,
        ),
      ),
    );
  }
}

