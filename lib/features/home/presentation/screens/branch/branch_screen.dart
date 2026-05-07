import 'package:get/get.dart';
import 'package:venu_ghee/core/utils/exports/common_exports.dart';
import 'package:venu_ghee/features/home/presentation/controller/branch_controller.dart';
import 'package:venu_ghee/features/home/presentation/screens/branch/add_branch_screen.dart';

class BranchScreen extends StatelessWidget {
  BranchScreen({super.key});

  final BranchController controller = Get.put(BranchController());

  @override
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
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 16.h,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextWidget(
                        text: 'Branch',
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                        color: ColorConstants.redColor,
                      ),
                      PrimaryButton(
                        title: 'Add Branch  +',
                        height: 38.h,
                        width: 120.w,
                        buttonColor: ColorConstants.redColor,
                        titleColor: ColorConstants.primaryColor,
                        fontSize: 14.sp,
                        customRadius: 30.r,
                        onPressed: () => Get.to(() => AddBranchScreen()),
                        // onPressed: () => _showAddBranchBottomSheet(context),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: Obx(() {
                    if (controller.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (controller.branchList.isEmpty) {
                      return Center(
                        child: TextWidget(
                          text: 'No branches found',
                          fontSize: 14.sp,
                          color: ColorConstants.lightTextColor,
                        ),
                      );
                    }
                    return ListView.separated(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      itemCount: controller.branchList.length,
                      separatorBuilder: (_, __) => 12.0.height,
                      itemBuilder: (context, index) {
                        final branch = controller.branchList[index];
                        return _BranchCard(
                          branch: branch,
                          onEdit: () =>
                              _showEditBranchBottomSheet(context, branch),
                        );
                      },
                    );
                  }),
                ),
                10.0.height,
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showAddBranchBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _BranchBottomSheet(controller: controller),
    );
  }

  void _showEditBranchBottomSheet(BuildContext context, BranchModel branch) {
    controller.setEditData(branch);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _BranchBottomSheet(
        controller: controller,
        isEdit: true,
        branch: branch,
      ),
    );
  }
}

class _BranchCard extends StatelessWidget {
  final BranchModel branch;
  final VoidCallback onEdit;

  const _BranchCard({required this.branch, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: ColorConstants.darkWhiteColor,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: ColorConstants.borderWhiteColor),
      ),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: Image.asset(
                  ImageConstants.dashboardIcon,
                  height: 42.h,
                  width: 42.w,
                  fit: BoxFit.cover,
                ),
              ),
              12.0.width,

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      text: branch.name,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    4.0.height,
                    TextWidget(
                      text: 'Owner: ${branch.ownerName}',
                      fontSize: 12.sp,
                      color: ColorConstants.lightTextColor,
                    ),
                  ],
                ),
              ),

              GestureDetector(
                onTap: onEdit,
                child: Icon(
                  Icons.edit_outlined,
                  size: 14.sp,
                  color: ColorConstants.lightTextColor,
                ),
              ),
            ],
          ),
          12.0.height,
          Divider(color: ColorConstants.borderWhiteColor),
          12.0.height,

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 7.h),
                decoration: BoxDecoration(
                  color: branch.isActive
                      ? ColorConstants.inProgressColor
                      : ColorConstants.closeColor,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: TextWidget(
                  text: branch.isActive ? 'IN PROGRESS' : 'CLOSED',
                  fontSize: 10.sp,
                  color: branch.isActive
                      ? ColorConstants.redColor
                      : ColorConstants.lightTextColor,
                ),
              ),

              TextWidget(
                text: 'Mo.  ${branch.phone}',
                fontSize: 12.sp,
                color: ColorConstants.lightTextColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _BranchBottomSheet extends StatelessWidget {
  final BranchController controller;
  final bool isEdit;
  final BranchModel? branch;

  const _BranchBottomSheet({
    required this.controller,
    this.isEdit = false,
    this.branch,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      decoration: BoxDecoration(
        color: ColorConstants.darkWhiteColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Container(
                height: 4.h,
                width: 40.w,
                decoration: BoxDecoration(
                  color: ColorConstants.borderColor,
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
            ),
            16.0.height,

            TextWidget(
              text: isEdit ? 'Edit Branch' : 'Add Branch',
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
            ),
            20.0.height,

            TextWidget(
              text: 'Branch Name',
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
            ),
            6.0.height,
            TextFormFieldWidget(
              controller: controller.nameController,
              hintText: 'Venu Ghee (Katargam)',
              fillColor: ColorConstants.primaryColor,
              borderColor: ColorConstants.borderColor,
              focusedBorderColor: ColorConstants.textColor,
              borderRadius: 8.r,
            ),
            16.0.height,

            TextWidget(
              text: 'Owner Name',
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
            ),
            6.0.height,
            TextFormFieldWidget(
              controller: controller.ownerController,
              hintText: 'Chaman Bhai',
              fillColor: ColorConstants.primaryColor,
              borderColor: ColorConstants.borderColor,
              focusedBorderColor: ColorConstants.textColor,
              borderRadius: 8.r,
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
              hintText: '+91 12345 69854',
              keyboardType: TextInputType.phone,
              fillColor: ColorConstants.primaryColor,
              borderColor: ColorConstants.borderColor,
              focusedBorderColor: ColorConstants.textColor,
              borderRadius: 8.r,
            ),
            16.0.height,

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextWidget(
                  text: 'Status',
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
                Obx(
                  () => Switch(
                    value: controller.isActive.value,
                    activeColor: ColorConstants.redColor,
                    onChanged: (val) => controller.isActive.value = val,
                  ),
                ),
              ],
            ),
            24.0.height,

            Obx(
              () => PrimaryButton(
                isLoading: controller.isSubmitting.value,
                title: isEdit ? 'Update Branch' : 'Add Branch',
                buttonColor: ColorConstants.redColor,
                titleColor: ColorConstants.primaryColor,
                customRadius: 8.r,
                height: 52.h,
                onPressed: () {
                  if (isEdit) {
                    controller.updateBranch(branch!.id);
                  } else {
                    controller.addBranch();
                  }
                },
              ),
            ),
            20.0.height,
          ],
        ),
      ),
    );
  }
}
