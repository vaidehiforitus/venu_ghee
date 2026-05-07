import 'package:get/get.dart';
import 'package:venu_ghee/core/constants/image_constants.dart';
import 'package:venu_ghee/core/theme/theme_controller.dart';
import 'package:venu_ghee/core/utils/exports/common_exports.dart';

class ThemeHelper {
  static ThemeController get controller => Get.find<ThemeController>();

  static String backgroundImage() {
    return controller.isDarkMode
        ? ImageConstants.darkBackground
        : ImageConstants.lightBackground;
  }
  static String logoImage() {
    return controller.isDarkMode
        ? ImageConstants.appLogo
        : ImageConstants.appLogo;
  }

  //  button Border color
  static Color primaryButtonTextColor({Color? override}) {
    if (override != null) return override;
    return controller.isDarkMode
        ? ColorConstants.secondaryColor
        : ColorConstants.primaryColor;
  }

  static Color textColor() {
    return controller.isDarkMode
        ? ColorConstants.primaryColor
        : ColorConstants.secondaryColor;
  }

}
