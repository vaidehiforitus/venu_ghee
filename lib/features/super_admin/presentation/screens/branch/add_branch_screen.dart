import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:venu_ghee/core/utils/exports/common_exports.dart';
import 'package:venu_ghee/core/utils/widgets/responsive_helper/responsive_helper.dart';
import 'package:venu_ghee/features/super_admin/presentation/controller/branch_controller.dart';
import 'package:venu_ghee/features/super_admin/presentation/screens/branch/add_payment_screen.dart';
import 'package:venu_ghee/features/super_admin/presentation/widget/adaptive_scaffold.dart';

class AddBranchScreen extends StatelessWidget {
  AddBranchScreen({super.key});

  final BranchController controller = Get.find<BranchController>();

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    if (w < 600) return _MobileAddBranchLayout(controller: controller);
    return AdaptiveScaffold(
      title: 'Add Branch',
      showBreadcrumbIcon: true,
      mobileBody: _MobileAddBranchLayout(controller: controller),
      tabletBody: _DesktopAddBranchBody(controller: controller),
    );
  }
}

class _MobileAddBranchLayout extends StatelessWidget {
  final BranchController controller;
  const _MobileAddBranchLayout({required this.controller});

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
                  text: 'Add Branch',
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  color: ColorConstants.redColor,
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: _BranchFormCard(controller: controller, isMobile: true),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                child: const _StepIndicator(currentStep: 0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DesktopAddBranchBody extends StatelessWidget {
  final BranchController controller;
  const _DesktopAddBranchBody({required this.controller});

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
                    text: 'Add Branch',
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
                    onTap: () {
                      if (controller.validateBranchForm()) {
                        Get.to(() => AddPaymentScreen());
                      }
                    },
                  )),
                ],
              ),
              24.0.height,
              _BranchFormCard(controller: controller, isMobile: false),
            ],
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: const _StepIndicator(currentStep: 0),
          ),
        ),
      ],
    );
  }
}

class _BranchFormCard extends StatelessWidget {
  final BranchController controller;
  final bool isMobile;

  const _BranchFormCard({required this.controller, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Container(
        padding: isMobile ? EdgeInsets.all(16.r) : const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: ColorConstants.darkWhiteColor,
          borderRadius: BorderRadius.circular(isMobile ? 16.r : 16),
          border: Border.all(color: ColorConstants.borderWhiteColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _rowOrColumn(
              isMobile: isMobile,
              left: _field(
                context,
                label: 'Owner Name',
                isMobile: isMobile,
                child: TextFormFieldWidget(
                  controller: controller.ownerController,
                  hintText: 'Owner Name',
                  fontSize: 16,
                  fillColor: ColorConstants.primaryColor,
                  borderColor: ColorConstants.borderColor,
                  focusedBorderColor: ColorConstants.textColor,
                  validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Owner name is required' : null,
                ),
              ),
              right: _field(
                context,
                label: 'Branch Name',
                isMobile: isMobile,
                child: TextFormFieldWidget(
                  controller: controller.nameController,
                  hintText: 'Branch Name',
                  fontSize: 16,
                  fillColor: ColorConstants.primaryColor,
                  borderColor: ColorConstants.borderColor,
                  focusedBorderColor: ColorConstants.textColor,
                  validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Branch name is required' : null,
                ),
              ),
            ),

            SizedBox(height: isMobile ? 16.h : 16),
            _fieldLabel(context, 'Address', isMobile),
            SizedBox(height: isMobile ? 6.h : 6),
            TextFormFieldWidget(
              controller: controller.addressController,
              hintText: 'Street Address',
              fontSize: 16,
              fillColor: ColorConstants.primaryColor,
              borderColor: ColorConstants.borderColor,
              focusedBorderColor: ColorConstants.textColor,
              validator: (v) =>
              (v == null || v.trim().isEmpty) ? 'Address is required' : null,
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextFormFieldWidget(
                    controller: controller.stateController,
                    hintText: 'State / Province',
                    fontSize: 16,
                    fillColor: ColorConstants.primaryColor,
                    borderColor: ColorConstants.borderColor,
                    focusedBorderColor: ColorConstants.textColor,
                    validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'State is required' : null,
                  ),
                ),
                SizedBox(width: isMobile ? 10.w : 10),
                Expanded(
                  child: TextFormFieldWidget(
                    controller: controller.zipController,
                    hintText: 'Zip Code',
                    fontSize: 16,
                    keyboardType: TextInputType.number,
                    fillColor: ColorConstants.primaryColor,
                    borderColor: ColorConstants.borderColor,
                    focusedBorderColor: ColorConstants.textColor,
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) return 'Zip code is required';
                      if (v.trim().length < 6) return 'Enter valid 6-digit zip';
                      return null;
                    },
                  ),
                ),
              ],
            ),

            SizedBox(height: isMobile ? 16.h : 16),
            _rowOrColumn(
              isMobile: isMobile,
              left: _field(
                context,
                label: 'Email',
                isMobile: isMobile,
                child: TextFormFieldWidget(
                  controller: controller.emailController,
                  hintText: 'dummy@gmail.com',
                  fontSize: 16,
                  keyboardType: TextInputType.emailAddress,
                  fillColor: ColorConstants.primaryColor,
                  borderColor: ColorConstants.borderColor,
                  focusedBorderColor: ColorConstants.textColor,
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return 'Email is required';
                    final regex = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');
                    if (!regex.hasMatch(v.trim())) return 'Enter a valid email';
                    return null;
                  },
                ),
              ),
              right: _field(
                context,
                label: 'Mobile Number',
                isMobile: isMobile,
                child: TextFormFieldWidget(
                  controller: controller.phoneController,
                  hintText: '00000 - 00000',
                  fontSize: 16,
                  keyboardType: TextInputType.phone,
                  fillColor: ColorConstants.primaryColor,
                  borderColor: ColorConstants.borderColor,
                  focusedBorderColor: ColorConstants.textColor,
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return 'Mobile number is required';
                    if (v.trim().length < 10) return 'Enter valid 10-digit number';
                    return null;
                  },
                  prefixIcon: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 10.w : 10,
                      vertical: isMobile ? 12.h : 12,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '🇮🇳',
                          style: TextStyle(
                            fontSize: isMobile ? 16.sp : adaptiveFont(context, 16),
                          ),
                        ),
                        SizedBox(width: isMobile ? 4.w : 4),
                        TextWidget(
                          text: '+91',
                          fontSize: isMobile ? 14.sp : adaptiveFont(context, 16),
                          color: ColorConstants.textColor,
                        ),
                        SizedBox(width: isMobile ? 8.w : 8),
                        Container(
                          height: isMobile ? 20.h : 20,
                          width: 1,
                          color: ColorConstants.borderColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: isMobile ? 16.h : 16),

            _rowOrColumn(
              isMobile: isMobile,
              left: _field(
                context,
                label: 'Password',
                isMobile: isMobile,
                child: TextFormFieldWidget(
                  controller: controller.passwordController,
                  hintText: 'Password',
                  fontSize: 16,
                  enablePasswordToggle: true,
                  fillColor: ColorConstants.primaryColor,
                  borderColor: ColorConstants.borderColor,
                  focusedBorderColor: ColorConstants.textColor,
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return 'Password is required';
                    if (v.trim().length < 6) return 'Minimum 6 characters required';
                    return null;
                  },
                ),
              ),
              right: _field(
                context,
                label: 'Confirm Password',
                isMobile: isMobile,
                child: TextFormFieldWidget(
                  controller: controller.confirmPasswordController,
                  hintText: 'Confirm Password',
                  fontSize: 16,
                  enablePasswordToggle: true,
                  fillColor: ColorConstants.primaryColor,
                  borderColor: ColorConstants.borderColor,
                  focusedBorderColor: ColorConstants.textColor,
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return 'Please confirm password';
                    if (v.trim() != controller.passwordController.text.trim()) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
              ),
            ),

            SizedBox(height: isMobile ? 16.h : 16),

            _ImageUploadBox(isMobile: isMobile, controller: controller),

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
                    onPressed: () {
                      if (controller.validateBranchForm()) {
                        Get.to(() => AddPaymentScreen());
                      }
                    },
                  )),
                ],
              ),
              10.0.height,
            ],
          ],
        ),
      ),
    );
  }

  Widget _rowOrColumn({
    required bool isMobile,
    required Widget left,
    required Widget right,
  }) {
    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [left, SizedBox(height: 16.h), right],
      );
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: left),
        const SizedBox(width: 16),
        Expanded(child: right),
      ],
    );
  }

  Widget _field(
      BuildContext context, {
        required String label,
        required Widget child,
        required bool isMobile,
      }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _fieldLabel(context, label, isMobile),
        SizedBox(height: isMobile ? 6.h : 6),
        child,
      ],
    );
  }

  Widget _fieldLabel(BuildContext context, String text, bool isMobile) {
    return TextWidget(
      text: text,
      fontSize: isMobile ? 14.sp : adaptiveFont(context, 16),
      fontWeight: FontWeight.w600,
      color: ColorConstants.textColor,
    );
  }
}

class _ImageUploadBox extends StatelessWidget {
  final bool isMobile;
  final BranchController controller;

  const _ImageUploadBox({
    required this.isMobile,
    required this.controller,
  });

  Future<void> _pickImage() async {
    try {
      final picker = ImagePicker();
      final picked = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
      );
      if (picked != null) {
        controller.selectedImagePath.value = picked.path;
      }
    } catch (e) {
      ErrorHandler.handleError('Image pick failed: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final hasImage = controller.selectedImagePath.value.isNotEmpty;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(
            text: 'Branch Image',
            fontSize: isMobile ? 14.sp : adaptiveFont(context, 16),
            fontWeight: FontWeight.w600,
            color: ColorConstants.textColor,
          ),
          SizedBox(height: isMobile ? 6.h : 6),

          GestureDetector(
            onTap: _pickImage,
            child: Container(
              height: isMobile ? 120.h : 120,
              width: double.infinity,
              decoration: BoxDecoration(
                color: ColorConstants.primaryColor,
                borderRadius: BorderRadius.circular(isMobile ? 12.r : 12),
                border: Border.all(
                  color: hasImage
                      ? ColorConstants.redColor
                      : ColorConstants.borderColor,
                  style: BorderStyle.solid,
                ),
              ),
              child: hasImage
                  ? Stack(
                children: [
                  ClipRRect(
                    borderRadius:
                    BorderRadius.circular(isMobile ? 12.r : 12),
                    child: Image.file(
                      File(controller.selectedImagePath.value),
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  ClipRRect(
                    borderRadius:
                    BorderRadius.circular(isMobile ? 12.r : 12),
                    child: Container(
                      color: Colors.black.withOpacity(0.25),
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.edit_outlined,
                            color: Colors.white,
                            size: isMobile ? 22.sp : 22,
                          ),
                          SizedBox(height: isMobile ? 4.h : 4),
                          Text(
                            'Tap to change',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize:
                              isMobile ? 11.sp : adaptiveFont(context, 11),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 6,
                    right: 6,
                    child: GestureDetector(
                      onTap: () =>
                      controller.selectedImagePath.value = '',
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Icon(
                          Icons.close,
                          size: isMobile ? 14.sp : 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              )
                  : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.upload_file_outlined,
                    size: isMobile ? 28.sp : adaptiveFont(context, 28),
                    color: ColorConstants.redColor,
                  ),
                  SizedBox(height: isMobile ? 6.h : 6),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Click to upload',
                          style: TextStyle(
                            fontSize: isMobile
                                ? 12.sp
                                : adaptiveFont(context, 12),
                            color: ColorConstants.redColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextSpan(
                          text: ' or drag and drop',
                          style: TextStyle(
                            fontSize: isMobile
                                ? 12.sp
                                : adaptiveFont(context, 12),
                            color: ColorConstants.lightTextColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: isMobile ? 4.h : 4),
                  Text(
                    'PNG, JPG up to 5MB',
                    style: TextStyle(
                      fontSize:
                      isMobile ? 10.sp : adaptiveFont(context, 10),
                      color: ColorConstants.lightTextColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (!hasImage) ...[
            SizedBox(height: isMobile ? 4.h : 4),
            Text(
              '* Image is required',
              style: TextStyle(
                fontSize: isMobile ? 11.sp : adaptiveFont(context, 11),
                color: ColorConstants.lightTextColor,
              ),
            ),
          ],
        ],
      );
    });
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