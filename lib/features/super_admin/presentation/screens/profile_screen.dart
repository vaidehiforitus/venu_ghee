// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
// import 'package:venu_ghee/core/utils/exports/common_exports.dart';
// import 'package:venu_ghee/features/auth/presentation/controller/auth_controller.dart';
// import 'package:venu_ghee/features/super_admin/presentation/controller/profile_controller.dart';
//
// class ProfileScreen extends StatelessWidget {
//   ProfileScreen({super.key});
//
//   final ProfileController controller = Get.put(ProfileController());
//
//   @override
//   Widget build(BuildContext context) {
//     return AppBackground(
//       child: Scaffold(
//         backgroundColor: ColorConstants.transparentColor,
//         body: SafeArea(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
//                 child: TextWidget(
//                   text: 'Profile',
//                   fontSize: 20.sp,
//                   fontWeight: FontWeight.w700,
//                   color: ColorConstants.redColor,
//                 ),
//               ),
//
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 16.w),
//                 child: Row(
//                   children: [
//                     CircleAvatar(
//                       radius: 32.r,
//                       backgroundImage: AssetImage(ImageConstants.branchIcon),
//                     ),
//                     14.0.width,
//
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           TextWidget(
//                             text: 'Sanjay Patel',
//                             fontSize: 20.sp,
//                             fontWeight: FontWeight.w700,
//                           ),
//                           4.0.height,
//                           TextWidget(
//                             text: '+1 111 467 378 399',
//                             fontSize: 13.sp,
//                             color: ColorConstants.lightTextColor,
//                           ),
//                         ],
//                       ),
//                     ),
//                     Image.asset(ImageConstants.pencilIcon, ),
//
//                     // Icon(
//                     //   CupertinoIcons.pencil,
//                     //   size: 26.sp,
//                     //   color: ColorConstants.redColor,
//                     // ),
//                   ],
//                 ),
//               ),
//               24.0.height,
//
//               Expanded(
//                 child: ListView.separated(
//                   padding: EdgeInsets.symmetric(horizontal: 16.w),
//                   itemCount: controller.profileMenus.length,
//                   separatorBuilder: (_, __) => Column(
//                     children: [
//                       18.0.height,
//                       Divider(
//                         color: ColorConstants.borderWhiteColor,
//                         height: 1,
//                       ),
//                       18.0.height,
//                     ],
//                   ),
//                   itemBuilder: (context, index) {
//                     final item = controller.profileMenus[index];
//                     return GestureDetector(
//                       onTap: () {
//                         // TODO: navigate
//                       },
//                       behavior: HitTestBehavior.opaque,
//                       child: Row(
//                         children: [
//                           Icon(
//                             item["icon"],
//                             color: ColorConstants.lightTextColor,
//                             size: 20.sp,
//                           ),
//                           14.0.width,
//
//                           Expanded(
//                             child: TextWidget(
//                               text: item["title"],
//                               fontSize: 16.sp,
//                             ),
//                           ),
//
//                           if (item["trailing"] != null)
//                             TextWidget(
//                               text: item["trailing"],
//                               fontSize: 14.sp,
//                               color: ColorConstants.lightTextColor,
//                             ),
//
//                           4.0.width,
//
//                           if (item["isSwitch"] == true)
//                             Obx(
//                               () => CupertinoSwitch(
//                                 value: controller.isDarkMode.value,
//                                 activeColor: ColorConstants.redColor,
//                                 onChanged: controller.toggleDarkMode,
//                               ),
//                             )
//                           else
//                             Icon(
//                               CupertinoIcons.chevron_right,
//                               size: 18.sp,
//                               color: ColorConstants.lightTextColor,
//                             ),
//                         ],
//                       ),
//                     );
//                   },
//                 ),
//               ),
//
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
//                 child: GestureDetector(
//                   onTap: () {
//                     Get.find<AuthController>().logout();
//                   },
//                   behavior: HitTestBehavior.opaque,
//                   child: Row(
//                     children: [
//                       Icon(
//                         CupertinoIcons.square_arrow_right,
//                         color: ColorConstants.redColor,
//                         size: 22.sp,
//                       ),
//                       12.0.width,
//                       TextWidget(
//                         text: 'Logout',
//                         fontSize: 16.sp,
//                         fontWeight: FontWeight.w700,
//                         color: ColorConstants.redColor,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:venu_ghee/core/utils/exports/common_exports.dart';
import 'package:venu_ghee/features/auth/presentation/controller/auth_controller.dart';
import 'package:venu_ghee/features/branch_admin/presentation/widget/branch_adaptive_scaffold.dart';
import 'package:venu_ghee/features/branch_admin/presentation/widget/branch_admin_bottom_navigation_bar.dart';
import 'package:venu_ghee/features/super_admin/presentation/controller/profile_controller.dart';
import '../../../../core/utils/widgets/responsive_helper/responsive_helper.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final ProfileController controller = Get.put(ProfileController());
  final AuthController authController = Get.isRegistered<AuthController>()
      ? Get.find<AuthController>()
      : Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    // BranchAdminController missing હોય તો put કરો
    if (!Get.isRegistered<BranchAdminController>()) {
      Get.put(BranchAdminController());
    }
    final w = MediaQuery.of(context).size.width;
    if (w < 600) return _mobileLayout(context);
    // return _desktopLayout(context);
    return BranchAdaptiveScaffold(
      title: 'Profile',
      mobileBody: _mobileLayout(context),
      tabletBody: _desktopLayout(context),
      webBody: _desktopLayout(context),
    );
  }

  Widget _mobileLayout(BuildContext context) {
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
                  text: 'Profile',
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  color: ColorConstants.redColor,
                ),
              ),
              _profileHeader(context, isMobile: true),
              SizedBox(height: 24.h),
              Expanded(child: _menuList(context, isMobile: true)),
              _logoutBtn(context, isMobile: true),
            ],
          ),
        ),
      ),
    );
  }

  Widget _desktopLayout(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final double cardWidth = w > 1024 ? 520 : 440;

    return AppBackground(
      child: Scaffold(
        backgroundColor: ColorConstants.transparentColor,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 28),
            child: Center(
              child: SizedBox(
                width: cardWidth,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      text: 'Profile',
                      fontSize: adaptiveFont(context, 22),
                      fontWeight: FontWeight.w700,
                      color: ColorConstants.textColor,
                    ),
                    const SizedBox(height: 24),

                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: ColorConstants.primaryColor,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: ColorConstants.borderWhiteColor),
                      ),
                      child: _profileHeader(context, isMobile: false),
                    ),
                    const SizedBox(height: 16),

                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: ColorConstants.primaryColor,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: ColorConstants.borderWhiteColor),
                      ),
                      child: _menuList(context, isMobile: false),
                    ),
                    const SizedBox(height: 16),

                    Container(
                      decoration: BoxDecoration(
                        color: ColorConstants.primaryColor,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: ColorConstants.borderWhiteColor),
                      ),
                      child: _logoutBtn(context, isMobile: false),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _profileHeader(BuildContext context, {required bool isMobile}) {
    return Padding(
      padding: isMobile
          ? EdgeInsets.symmetric(horizontal: 16.w)
          : EdgeInsets.zero,
      child: Row(
        children: [
          CircleAvatar(
            radius: isMobile ? 32.r : 36,
            backgroundColor: ColorConstants.borderWhiteColor,
            backgroundImage: controller.imageUrl.isNotEmpty
                ? NetworkImage(controller.imageUrl)
                : AssetImage(ImageConstants.branchIcon) as ImageProvider,
          ),
          isMobile ? SizedBox(width: 14.w) : const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  text: controller.ownerName.isNotEmpty
                      ? controller.ownerName
                      : controller.userName,
                  fontSize: isMobile ? 20.sp : adaptiveFont(context, 18),
                  fontWeight: FontWeight.w700,
                  color: ColorConstants.textColor,
                ),
                isMobile ? SizedBox(height: 2.h) : const SizedBox(height: 2),
                if (controller.branchName.isNotEmpty)
                  TextWidget(
                    text: controller.branchName,
                    fontSize: isMobile ? 12.sp : adaptiveFont(context, 12),
                    color: ColorConstants.redColor,
                    fontWeight: FontWeight.w500,
                  ),
                isMobile ? SizedBox(height: 2.h) : const SizedBox(height: 2),
                TextWidget(
                  text: controller.mobileNumber.isNotEmpty
                      ? controller.mobileNumber
                      : '-',
                  fontSize: isMobile ? 13.sp : adaptiveFont(context, 13),
                  color: ColorConstants.lightTextColor,
                ),
              ],
            ),
          ),
          Image.asset(
            ImageConstants.pencilIcon,
            height: isMobile ? 22.h : 22,
            width: isMobile ? 22.w : 22,
          ),
        ],
      ),
    );
  }
  Widget _menuList(BuildContext context, {required bool isMobile}) {
    return ListView.separated(
      shrinkWrap: !isMobile,
      physics: isMobile
          ? const AlwaysScrollableScrollPhysics()
          : const NeverScrollableScrollPhysics(),
      padding: isMobile
          ? EdgeInsets.symmetric(horizontal: 16.w)
          : EdgeInsets.zero,
      itemCount: controller.profileMenus.length,
      separatorBuilder: (_, __) => Column(
        children: [
          isMobile ? SizedBox(height: 18.h) : const SizedBox(height: 14),
          Divider(color: ColorConstants.borderWhiteColor, height: 1),
          isMobile ? SizedBox(height: 18.h) : const SizedBox(height: 14),
        ],
      ),
      itemBuilder: (context, index) {
        final item = controller.profileMenus[index];
        return GestureDetector(
          onTap: () {},
          behavior: HitTestBehavior.opaque,
          child: Row(
            children: [
              Icon(
                item["icon"],
                color: ColorConstants.lightTextColor,
                size: isMobile ? 20.sp : 20,
              ),
              isMobile ? SizedBox(width: 14.w) : const SizedBox(width: 14),
              Expanded(
                child: TextWidget(
                  text: item["title"],
                  fontSize: isMobile ? 16.sp : adaptiveFont(context, 14),
                  color: ColorConstants.textColor,
                ),
              ),
              if (item["trailing"] != null)
                TextWidget(
                  text: item["trailing"],
                  fontSize: isMobile ? 14.sp : adaptiveFont(context, 13),
                  color: ColorConstants.lightTextColor,
                ),
              isMobile ? SizedBox(width: 4.w) : const SizedBox(width: 4),
              if (item["isSwitch"] == true)
                Obx(() => CupertinoSwitch(
                  value: controller.isDarkMode.value,
                  activeColor: ColorConstants.redColor,
                  onChanged: controller.toggleDarkMode,
                ))
              else
                Icon(
                  CupertinoIcons.chevron_right,
                  size: isMobile ? 18.sp : 16,
                  color: ColorConstants.lightTextColor,
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _logoutBtn(BuildContext context, {required bool isMobile}) {
    return Padding(
      padding: isMobile
          ? EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h)
          : const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: GestureDetector(
        onTap: () => authController.logout(),
        behavior: HitTestBehavior.opaque,
        child: Row(
          children: [
            Icon(
              CupertinoIcons.square_arrow_right,
              color: ColorConstants.redColor,
              size: isMobile ? 22.sp : 20,
            ),
            isMobile ? SizedBox(width: 12.w) : const SizedBox(width: 12),
            TextWidget(
              text: 'Logout',
              fontSize: isMobile ? 16.sp : adaptiveFont(context, 14),
              fontWeight: FontWeight.w700,
              color: ColorConstants.redColor,
            ),
          ],
        ),
      ),
    );
  }
}