import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  RxBool isDarkMode = false.obs;

  void toggleDarkMode(bool value) {
    isDarkMode.value = value;
  }

  final List<Map<String, dynamic>> profileMenus = [
    {
      "title": "Profile",
      "icon": CupertinoIcons.person,
    },
    {
      "title": "Address",
      "icon": CupertinoIcons.location,
    },
    {
      "title": "Notification",
      "icon": CupertinoIcons.bell,
    },
    {
      "title": "Security",
      "icon": CupertinoIcons.shield,
    },
    {
      "title": "Language",
      "icon": CupertinoIcons.globe,
      "trailing": "English (US)",
    },
    {
      "title": "Dark Mode",
      "icon": CupertinoIcons.moon,
      "isSwitch": true,
    },
    {
      "title": "Help Center",
      "icon": CupertinoIcons.clock,
    },
    {
      "title": "Invite Friends",
      "icon": CupertinoIcons.person_2,
    },
  ];
}