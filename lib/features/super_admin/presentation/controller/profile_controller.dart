import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:venu_ghee/core/config/app_config.dart';
import 'package:venu_ghee/core/constants/storage_constants.dart';

class ProfileController extends GetxController {
  final _box = GetStorage();

  RxBool isDarkMode = false.obs;

  String get userName => _box.read(StorageConstants.username) ?? 'Admin';
  String get ownerName => _box.read(StorageConstants.ownerName) ?? '';
  String get branchName => _box.read(StorageConstants.branchName) ?? '';
  String get userImage => _box.read(StorageConstants.userImage) ?? '';
  String get mobileNumber => _box.read(StorageConstants.mobileNumber) ?? '';

  String get imageUrl {
    if (userImage.isEmpty) return '';
    if (userImage.startsWith('http')) return userImage;
    return '${AppConfig.apiBaseUrl}$userImage';
  }

  void toggleDarkMode(bool value) {
    isDarkMode.value = value;
  }

  final List<Map<String, dynamic>> profileMenus = [
    {"title": "Profile", "icon": CupertinoIcons.person},
    {"title": "Address", "icon": CupertinoIcons.location},
    {"title": "Notification", "icon": CupertinoIcons.bell},
    {"title": "Security", "icon": CupertinoIcons.shield},
    {"title": "Language", "icon": CupertinoIcons.globe, "trailing": "English (US)"},
    {"title": "Dark Mode", "icon": CupertinoIcons.moon, "isSwitch": true},
    {"title": "Help Center", "icon": CupertinoIcons.clock},
    {"title": "Invite Friends", "icon": CupertinoIcons.person_2},
  ];
}