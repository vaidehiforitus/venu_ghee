import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:venu_ghee/core/utils/exports/common_exports.dart';
import 'package:venu_ghee/features/super_admin/presentation/controller/profile_controller.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final ProfileController controller = Get.put(ProfileController());

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
                  text: 'Profile',
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  color: ColorConstants.redColor,
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 32.r,
                      backgroundImage: AssetImage(ImageConstants.branchIcon),
                    ),
                    14.0.width,

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextWidget(
                            text: 'Sanjay Patel',
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                          ),
                          4.0.height,
                          TextWidget(
                            text: '+1 111 467 378 399',
                            fontSize: 13.sp,
                            color: ColorConstants.lightTextColor,
                          ),
                        ],
                      ),
                    ),
                    Image.asset(ImageConstants.pencilIcon, ),

                    // Icon(
                    //   CupertinoIcons.pencil,
                    //   size: 26.sp,
                    //   color: ColorConstants.redColor,
                    // ),
                  ],
                ),
              ),
              24.0.height,

              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  itemCount: controller.profileMenus.length,
                  separatorBuilder: (_, __) => Column(
                    children: [
                      18.0.height,
                      Divider(
                        color: ColorConstants.borderWhiteColor,
                        height: 1,
                      ),
                      18.0.height,
                    ],
                  ),
                  itemBuilder: (context, index) {
                    final item = controller.profileMenus[index];
                    return GestureDetector(
                      onTap: () {
                        // TODO: navigate
                      },
                      behavior: HitTestBehavior.opaque,
                      child: Row(
                        children: [
                          Icon(
                            item["icon"],
                            color: ColorConstants.lightTextColor,
                            size: 20.sp,
                          ),
                          14.0.width,

                          Expanded(
                            child: TextWidget(
                              text: item["title"],
                              fontSize: 16.sp,
                            ),
                          ),

                          if (item["trailing"] != null)
                            TextWidget(
                              text: item["trailing"],
                              fontSize: 14.sp,
                              color: ColorConstants.lightTextColor,
                            ),

                          4.0.width,

                          if (item["isSwitch"] == true)
                            Obx(
                              () => CupertinoSwitch(
                                value: controller.isDarkMode.value,
                                activeColor: ColorConstants.redColor,
                                onChanged: controller.toggleDarkMode,
                              ),
                            )
                          else
                            Icon(
                              CupertinoIcons.chevron_right,
                              size: 18.sp,
                              color: ColorConstants.lightTextColor,
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                child: GestureDetector(
                  onTap: () {
                    // TODO: logout
                    // Get.offAllNamed(AppRoutes.loginScreen);
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Row(
                    children: [
                      Icon(
                        CupertinoIcons.square_arrow_right,
                        color: ColorConstants.redColor,
                        size: 22.sp,
                      ),
                      12.0.width,
                      TextWidget(
                        text: 'Logout',
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: ColorConstants.redColor,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
