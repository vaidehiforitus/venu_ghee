  import 'package:get/get.dart';
import 'package:venu_ghee/core/config/app_config.dart';
  import 'package:venu_ghee/core/utils/exports/common_exports.dart';
  import 'package:venu_ghee/core/utils/widgets/responsive_helper/responsive_helper.dart';
  import 'package:venu_ghee/features/super_admin/data/model/response_model/get_branch_details_response_model.dart';
  import 'package:venu_ghee/features/super_admin/presentation/controller/branch_controller.dart';
  import 'package:venu_ghee/features/super_admin/presentation/screens/branch/add_branch_screen.dart';
  import 'package:venu_ghee/features/super_admin/presentation/widget/adaptive_scaffold.dart';

  class BranchScreen extends StatelessWidget {
    BranchScreen({super.key});

    final BranchController controller = Get.put(BranchController());

    @override
    Widget build(BuildContext context) {
      return AdaptiveScaffold(
        title: 'Branch',
        showBreadcrumbIcon: true,
        mobileBody: _MobileBranchBody(controller: controller),
        tabletBody: _BranchContentArea(controller: controller),
      );
    }
  }

  class _MobileBranchBody extends StatelessWidget {
    final BranchController controller;

    const _MobileBranchBody({required this.controller});

    @override
    Widget build(BuildContext context) {
      return AppBackground(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
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
                      width: 130.w,
                      buttonColor: ColorConstants.redColor,
                      titleColor: ColorConstants.primaryColor,
                      fontSize: 14.sp,
                      customRadius: 30.r,
                      onPressed: () => Get.to(() => AddBranchScreen()),
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
                        onEdit: () => _showEditBranchBottomSheet(context, branch),
                      );
                    },
                  );
                }),
              ),
              10.0.height,
            ],
          ),
        ),
      );
    }

    void _showEditBranchBottomSheet(
      BuildContext context,
        Branches branch,
    ) {
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

  class _BranchContentArea extends StatefulWidget {
    final BranchController controller;

    const _BranchContentArea({required this.controller});

    @override
    State<_BranchContentArea> createState() => _BranchContentAreaState();
  }

  class _BranchContentAreaState extends State<_BranchContentArea> {
    bool _isGridView = false;

    @override
    Widget build(BuildContext context) {
      final controller = widget.controller;
      final isWide = MediaQuery.of(context).size.width >= 1024;

      return Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                TextWidget(
                  text: 'Branch',
                  fontSize: adaptiveFont(context, 22),
                  fontWeight: FontWeight.w700,
                  color: ColorConstants.textColor,
                ),
                const Spacer(),
                _ViewToggleBtn(
                  icon: Icons.list,
                  selected: !_isGridView,
                  onTap: () => setState(() => _isGridView = false),
                ),
                8.0.width,
                _ViewToggleBtn(
                  icon: Icons.grid_view,
                  selected: _isGridView,
                  onTap: () => setState(() => _isGridView = true),
                ),
                16.0.width,
                GestureDetector(
                  onTap: () => Get.to(() => AddBranchScreen()),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: ColorConstants.redColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextWidget(
                          text: 'Add Branch',
                          fontSize: adaptiveFont(context, 13),
                          fontWeight: FontWeight.w600,
                          color: ColorConstants.primaryColor,
                        ),
                        4.0.width,
                        Icon(
                          Icons.add,
                          size: 16,
                          color: ColorConstants.primaryColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            20.0.height,

            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (controller.branchList.isEmpty) {
                  return Center(
                    child: TextWidget(
                      text: 'No branches found',
                      fontSize: adaptiveFont(context, 14),
                      color: ColorConstants.lightTextColor,
                    ),
                  );
                }

                if (_isGridView) {
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: isWide ? 4 : 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.82,
                    ),
                    itemCount: controller.branchList.length,
                    itemBuilder: (context, index) {
                      final branch = controller.branchList[index];
                      return _BranchGridCard(
                        branch: branch,
                        onEdit: () =>
                            _showEditDialog(context, branch, controller),
                      );
                    },
                  );
                }

                return Container(
                  decoration: BoxDecoration(
                    color: ColorConstants.primaryColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: ColorConstants.borderWhiteColor),
                  ),
                  child: Column(
                    children: [
                      _TableHeader(),
                      Divider(height: 1, color: ColorConstants.borderWhiteColor),
                      Expanded(
                        child: ListView.separated(
                          itemCount: controller.branchList.length,
                          separatorBuilder: (_, __) => Divider(
                            height: 1,
                            color: ColorConstants.borderWhiteColor,
                          ),
                          itemBuilder: (context, index) {
                            final branch = controller.branchList[index];
                            return _TableRow(
                              branch: branch,
                              onEdit: () =>
                                  _showEditDialog(context, branch, controller),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
      );
    }

    void _showEditDialog(
      BuildContext context,
        Branches branch,
      BranchController controller,
    ) {
      controller.setEditData(branch);
      showDialog(
        context: context,
        builder: (_) =>
            _BranchDialog(controller: controller, isEdit: true, branch: branch),
      );
    }
  }

  class _ViewToggleBtn extends StatelessWidget {
    final IconData icon;
    final bool selected;
    final VoidCallback onTap;

    const _ViewToggleBtn({
      required this.icon,
      required this.selected,
      required this.onTap,
    });

    @override
    Widget build(BuildContext context) {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: selected
                ? ColorConstants.redColor
                : ColorConstants.primaryColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: ColorConstants.borderWhiteColor),
          ),
          child: Icon(
            icon,
            size: 18,
            color: selected
                ? ColorConstants.primaryColor
                : ColorConstants.lightTextColor,
          ),
        ),
      );
    }
  }

  class _TableHeader extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            const SizedBox(width: 48),
            16.0.width,
            _headerCell(context, 'Branch Name', flex: 3),
            _headerCell(context, 'Mobile Number', flex: 3),
            _headerCell(context, 'Email', flex: 3),
            _headerCell(context, 'Owner Name', flex: 2),
            _headerCell(context, 'Status', flex: 2),
            const SizedBox(width: 36),
          ],
        ),
      );
    }

    Widget _headerCell(BuildContext context, String text, {required int flex}) {
      return Expanded(
        flex: flex,
        child: TextWidget(
          text: text,
          fontSize: adaptiveFont(context, 16),
          fontWeight: FontWeight.w600,
          color: ColorConstants.lightTextColor,
        ),
      );
    }
  }

  class _TableRow extends StatelessWidget {
    final Branches branch;
    final VoidCallback onEdit;

    const _TableRow({required this.branch, required this.onEdit});

    @override
    Widget build(BuildContext context) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                "${AppConfig.apiBaseUrl}${branch.image}",

                // branch.image ?? '',
                height: 36,
                width: 36,
                fit: BoxFit.cover,
              ),
            ),
            16.0.width,
            Expanded(
              flex: 3,
              child: TextWidget(
                text: branch.bankName ?? '',
                fontSize: adaptiveFont(context, 16),
                color: ColorConstants.textColor,
              ),
            ),
            Expanded(
              flex: 3,
              child: TextWidget(
                text: branch.mobileNumber ?? '',
                fontSize: adaptiveFont(context, 16),
                color: ColorConstants.lightTextColor,
              ),
            ),
            Expanded(
              flex: 3,
              child: TextWidget(
                text: branch.email?? 'katargam@gmail.com',
                fontSize: adaptiveFont(context, 16),
                color: ColorConstants.lightTextColor,
              ),
            ),
            Expanded(
              flex: 2,
              child: TextWidget(
                text: branch.ownerName ?? '',
                fontSize: adaptiveFont(context, 16),
                color: ColorConstants.lightTextColor,
              ),
            ),
            Expanded(
              flex: 2,
              child: _StatusBadge(isActive: branch.isOpen ?? false),
            ),
            const SizedBox(width: 36),
            Row(
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: onEdit,
                  child: Padding(
                    padding: const EdgeInsets.all(6),
                    child: Icon(
                      Icons.edit_outlined,
                      size: 18,
                      color: ColorConstants.lightTextColor,
                    ),
                  ),
                ),

                10.0.width,

                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => Get.find<BranchController>().deleteBranch(branch.id),
                  child: Padding(
                    padding: const EdgeInsets.all(6),
                    child: Icon(
                      Icons.delete_outline,
                      size: 18,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }
  }

  class _BranchGridCard extends StatelessWidget {
    final Branches branch;
    final VoidCallback onEdit;

    const _BranchGridCard({required this.branch, required this.onEdit});

    @override
    Widget build(BuildContext context) {
      return Container(
        decoration: BoxDecoration(
          color: ColorConstants.primaryColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: ColorConstants.borderWhiteColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.network(
                "${AppConfig.apiBaseUrl}${branch.image}",

                // branch.image ?? '',
                height: 110,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    text: 'Branch Name',
                    fontSize: adaptiveFont(context, 10),
                    color: ColorConstants.lightTextColor,
                  ),
                  4.0.height,
                  Row(
                    children: [
                      Expanded(
                        child: TextWidget(
                          text: branch.branchName ?? '',
                          fontSize: adaptiveFont(context, 13),
                          fontWeight: FontWeight.w600,
                          color: ColorConstants.textColor,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: onEdit,
                            child: Padding(
                              padding: const EdgeInsets.all(4),
                              child: Icon(
                                Icons.edit_outlined,
                                size: 16,
                                color: ColorConstants.lightTextColor,
                              ),
                            ),
                          ),

                          6.0.width,

                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () =>
                                Get.find<BranchController>().deleteBranch(branch.id),
                            child: Padding(
                              padding: const EdgeInsets.all(4),
                              child: Icon(
                                Icons.delete_outline,
                                size: 16,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  6.0.height,
                  _StatusBadge(isActive: branch.isOpen ?? false, small: true),
                ],
              ),
            ),
          ],
        ),
      );
    }
  }

  class _BranchCard extends StatelessWidget {
    final Branches branch;
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
                  child: Image.network(
                    "${AppConfig.apiBaseUrl}${branch.image}",
                    // branch.image ?? '',
                    // ImageConstants.dashboardIcon,
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
                        text: branch.branchName ?? '',
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
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: onEdit,
                      child: Padding(
                        padding: EdgeInsets.all(4.r),
                        child: Icon(
                          Icons.edit_outlined,
                          size: 16.sp,
                          color: ColorConstants.lightTextColor,
                        ),
                      ),
                    ),

                    8.0.width,

                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () =>
                          Get.find<BranchController>().deleteBranch(branch.id),
                      child: Padding(
                        padding: EdgeInsets.all(4.r),
                        child: Icon(
                          Icons.delete_outline,
                          size: 16.sp,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
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
                    color: branch.isOpen ?? false
                        ? ColorConstants.inProgressColor
                        : ColorConstants.closeColor,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: TextWidget(
                    text: branch.isOpen ?? false ? 'IN PROGRESS' : 'CLOSED',
                    fontSize: 10.sp,
                    color: branch.isOpen ?? false
                        ? ColorConstants.redColor
                        : ColorConstants.lightTextColor,
                  ),
                ),
                TextWidget(
                  text: 'Mo.  ${branch.mobileNumber}',
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

  class _StatusBadge extends StatelessWidget {
    final bool isActive;
    final bool small;

    const _StatusBadge({required this.isActive, this.small = false});

    @override
    Widget build(BuildContext context) {
      return Container(
        padding: EdgeInsets.symmetric(
          horizontal: small ? 8 : 10,
          vertical: small ? 3 : 4,
        ),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFFE6F4EA) : const Color(0xFFFCE8E8),
          borderRadius: BorderRadius.circular(20),
        ),
        child: TextWidget(
          text: isActive ? 'OPEN' : 'CLOSED',
          fontSize: adaptiveFont(context, small ? 10 : 11),
          fontWeight: FontWeight.w600,
          color: isActive ? const Color(0xFF2E7D32) : ColorConstants.redColor,
          textAlign: TextAlign.center,
        ),
      );
    }
  }

  class _BranchBottomSheet extends StatelessWidget {
    final BranchController controller;
    final bool isEdit;
    final Branches? branch;

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
              _buildField(
                'Branch Name',
                controller.nameController,
                'Venu Ghee (Katargam)',
              ),
              16.0.height,
              _buildField(
                'Owner Name',
                controller.ownerController,
                'Chaman Bhai',
              ),
              16.0.height,
              _buildField(
                'Mobile Number',
                controller.phoneController,
                '+91 12345 69854',
                keyboardType: TextInputType.phone,
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
                  fontSize: 14,
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

    Widget _buildField(
      String label,
      TextEditingController ctrl,
      String hint, {
      TextInputType? keyboardType,
    }) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(text: label, fontSize: 12.sp, fontWeight: FontWeight.w500),
          6.0.height,
          TextFormFieldWidget(
            controller: ctrl,
            hintText: hint,
            keyboardType: keyboardType,
            fillColor: ColorConstants.primaryColor,
            borderColor: ColorConstants.borderColor,
            focusedBorderColor: ColorConstants.textColor,
            borderRadius: 8.r,
          ),
        ],
      );
    }
  }

  class _BranchDialog extends StatelessWidget {
    final BranchController controller;
    final bool isEdit;
    final Branches? branch;

    const _BranchDialog({
      required this.controller,
      this.isEdit = false,
      this.branch,
    });

    @override
    Widget build(BuildContext context) {
      return Dialog(
        backgroundColor: ColorConstants.primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: SizedBox(
          width: 420,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidget(
                      text: isEdit ? 'Edit Branch' : 'Add Branch',
                      fontSize: adaptiveFont(context, 18),
                      fontWeight: FontWeight.w700,
                      color: ColorConstants.textColor,
                    ),
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Icon(
                        Icons.close,
                        size: 20,
                        color: ColorConstants.lightTextColor,
                      ),
                    ),
                  ],
                ),
                20.0.height,
                _dialogField(
                  context,
                  'Branch Name',
                  controller.nameController,
                  'Venu Ghee (Katargam)',
                ),
                16.0.height,
                _dialogField(
                  context,
                  'Owner Name',
                  controller.ownerController,
                  'Chaman Bhai',
                ),
                16.0.height,
                _dialogField(
                  context,
                  'Mobile Number',
                  controller.phoneController,
                  '+91 12345 69854',
                  keyboardType: TextInputType.phone,
                ),
                16.0.height,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidget(
                      text: 'Status',
                      fontSize: adaptiveFont(context, 13),
                      fontWeight: FontWeight.w500,
                      color: ColorConstants.textColor,
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
                    customRadius: 8,
                    fontSize: 14,
                    height: 48,
                    onPressed: () {
                      if (isEdit) {
                        controller.updateBranch(branch!.id);
                      } else {
                        controller.addBranch();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    Widget _dialogField(
      BuildContext context,
      String label,
      TextEditingController ctrl,
      String hint, {
      TextInputType? keyboardType,
    }) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(
            text: label,
            fontSize: adaptiveFont(context, 12),
            fontWeight: FontWeight.w500,
            color: ColorConstants.textColor,
          ),
          6.0.height,
          TextFormFieldWidget(
            controller: ctrl,
            hintText: hint,
            keyboardType: keyboardType,
            fillColor: ColorConstants.darkWhiteColor,
            borderColor: ColorConstants.borderColor,
            focusedBorderColor: ColorConstants.textColor,
            borderRadius: 8,
          ),
        ],
      );
    }
  }
