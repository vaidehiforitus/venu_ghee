import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:venu_ghee/core/utils/exports/common_exports.dart';
import 'package:venu_ghee/features/home/presentation/controller/profile_controller.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.primaryColor,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              ImageConstants.bgImage,
              fit: BoxFit.cover,
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 16.h,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: TextWidget(
                      text: 'Profile',
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                      color: ColorConstants.redColor,
                    ),
                  ),
                ),

                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16.r),
                    decoration: BoxDecoration(
                      color: ColorConstants.transparentColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(28.r),
                        topRight: Radius.circular(28.r),
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 32.r,
                              backgroundImage: AssetImage(
                                ImageConstants.branchIcon,
                              ),
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

                            Container(
                              height: 36.h,
                              width: 36.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: ColorConstants.redColor,
                                ),
                              ),
                              child: Icon(
                                CupertinoIcons.pencil,
                                size: 18.sp,
                                color: ColorConstants.redColor,
                              ),
                            ),
                          ],
                        ),

                        24.0.height,

                        Expanded(
                          child: ListView.separated(
                            // physics: BouncingScrollPhysics(),
                            itemCount: controller.profileMenus.length,
                            separatorBuilder: (_, __) => 18.0.height,
                            itemBuilder: (context, index) {
                              final item =
                              controller.profileMenus[index];

                              return Row(
                                children: [
                                  Icon(
                                    item["icon"],
                                    color: ColorConstants.lightTextColor,
                                    size: 22.sp,
                                  ),

                                  14.0.width,

                                  Expanded(
                                    child: TextWidget(
                                      text: item["title"],
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),

                                  if (item["trailing"] != null)
                                    TextWidget(
                                      text: item["trailing"],
                                      fontSize: 13.sp,
                                      color: ColorConstants.lightTextColor,
                                    ),

                                  if (item["isSwitch"] == true)
                                    Obx(
                                          () => CupertinoSwitch(
                                        value:
                                        controller.isDarkMode.value,
                                        activeColor:
                                        ColorConstants.redColor,
                                        onChanged:
                                        controller.toggleDarkMode,
                                      ),
                                    )
                                  else
                                    Icon(
                                      CupertinoIcons.chevron_right,
                                      size: 18.sp,
                                      color:
                                      ColorConstants.lightTextColor,
                                    ),
                                ],
                              );
                            },
                          ),
                        ),

                        Row(
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

                        20.0.height,
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}