import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'theme_service.dart';

class ThemeController extends GetxController {
  final ThemeService _service = ThemeService();
  var isDarkModeSwitch = false.obs;

  ThemeMode themeMode = ThemeMode.system;

  @override
  void onInit() {
    super.onInit();

    final saved = _service.getThemeMode();
    themeMode = _fromString(saved) ?? ThemeMode.system;
    Get.changeThemeMode(themeMode);
    _updateSwitchUI();

    // System brightness change listener
    WidgetsBinding.instance.platformDispatcher.onPlatformBrightnessChanged =
        () {
      if (themeMode == ThemeMode.system) {
        Get.changeThemeMode(ThemeMode.system);
        _updateSwitchUI();
        update();                  // rebuild all GetBuilder widgets
        Get.forceAppUpdate();      // force entire app rebuild
      }
    };
  }

  @override
  void onReady() {
    super.onReady();
    _updateSwitchUI();
  }

  bool get isDarkMode {
    if (themeMode == ThemeMode.system) {
      final brightness =
          WidgetsBinding.instance.platformDispatcher.platformBrightness;
      return brightness == Brightness.dark;
    }
    return themeMode == ThemeMode.dark;
  }

  void toggleByIconTap() {
    if (themeMode == ThemeMode.system) {
      final brightness =
          WidgetsBinding.instance.platformDispatcher.platformBrightness;
      final next =
      brightness == Brightness.dark ? ThemeMode.light : ThemeMode.dark;
      switchTheme(next);
    } else {
      switchTheme(
        themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark,
      );
    }
  }

  void toggleDarkSwitch(bool value) {
    switchTheme(value ? ThemeMode.dark : ThemeMode.light);
  }

  void switchTheme(ThemeMode next) {
    themeMode = next;
    _service.saveThemeMode(_toString(next));
    Get.changeThemeMode(themeMode);
    _updateSwitchUI();
    update();               // rebuild all GetBuilder widgets
    Get.forceAppUpdate();   // force entire app rebuild — all screens update
  }

  void _updateSwitchUI() {
    isDarkModeSwitch.value = isDarkMode;
  }

  String _toString(ThemeMode m) {
    switch (m) {
      case ThemeMode.light:
        return "light";
      case ThemeMode.dark:
        return "dark";
      default:
        return "system";
    }
  }

  ThemeMode? _fromString(String? s) {
    switch (s) {
      case "light":
        return ThemeMode.light;
      case "dark":
        return ThemeMode.dark;
      case "system":
        return ThemeMode.system;
      default:
        return null;
    }
  }
}