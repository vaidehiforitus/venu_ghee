import 'package:flutter/material.dart';
import 'package:venu_ghee/core/constants/color_constants.dart';

class AppThemes {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: ColorConstants.primaryColor,
    scaffoldBackgroundColor: ColorConstants.primaryColor,
    fontFamily: 'Inter',
    appBarTheme: AppBarTheme(
      backgroundColor: ColorConstants.primaryColor,
      foregroundColor: ColorConstants.secondaryColor,
    ),
    colorScheme: ColorScheme.light(
      primary: ColorConstants.secondaryColor,
      secondary: ColorConstants.secondaryColor,
      background: ColorConstants.primaryColor,
    ),
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: ColorConstants.secondaryColor,
    scaffoldBackgroundColor: ColorConstants.secondaryColor,
    fontFamily: 'Inter',
    appBarTheme: AppBarTheme(
      backgroundColor: ColorConstants.secondaryColor,
      foregroundColor: ColorConstants.primaryColor,
    ),
    colorScheme: ColorScheme.dark(
      primary: ColorConstants.secondaryColor,
      secondary: ColorConstants.secondaryColor,
      background: ColorConstants.secondaryColor,
    ),
  );
}
