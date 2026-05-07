import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonSnackBar {
  static void success(String message, {String title = "Success"}) {
    show(
      title: title,
      message: message,
      backgroundColor: Colors.green,
    );
  }

  static void error(String message, {String title = "Error"}) {
    show(
      title: title,
      message: message,
      backgroundColor: Colors.red,
    );
  }

  static void info(String message, {String title = "Info"}) {
    show(
      title: title,
      message: message,
      // backgroundColor: Colors.white,
    );
  }

  static void show({
    required String title,
    required String message,
    Color backgroundColor = Colors.black,
    Color textColor = Colors.black,
    SnackPosition position = SnackPosition.TOP,
    int duration = 2,
  }) {
    Get.snackbar(
      title,
      message,
      // backgroundColor: backgroundColor,
      colorText: textColor,
      snackPosition: position,
      duration: Duration(seconds: duration),
      margin: const EdgeInsets.all(12),
      borderRadius: 10,
    );
  }
}
