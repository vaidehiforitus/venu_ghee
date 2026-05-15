// storage_const.dart
import 'package:get_storage/get_storage.dart';

class StorageConstants {
  static const String accessToken = 'access_token';
  static const String refreshToken = 'refresh_token';
  static const String userType = 'user_type';
  static const String username = 'username';
  static const String userId = 'user_id';
  static const String isLoggedIn = 'is_logged_in';
  static const String email = 'user_email';
  static const String profileImage = 'profile_image';
  static const String branchId = 'branch_id';
  static const String ownerName  = 'owner_name';
  static const String branchName = 'branch_name';
  static const String userImage  = 'user_image';
  static const String mobileNumber = 'mobile_number';

}


class StorageService {
  static final GetStorage _box = GetStorage();

  static String getUserId()   => _box.read(StorageConstants.userId)      ?? '';
  static String getUserType() => _box.read(StorageConstants.userType)    ?? '';
  static String getToken()    => _box.read(StorageConstants.accessToken) ?? '';

  static Future<void> clearAll() async {
    await _box.remove(StorageConstants.accessToken);
    await _box.remove(StorageConstants.refreshToken);
    await _box.remove(StorageConstants.userType);
    await _box.remove(StorageConstants.username);
    await _box.remove(StorageConstants.userId);
    await _box.remove(StorageConstants.isLoggedIn);
    await _box.remove(StorageConstants.email);
    await _box.remove(StorageConstants.profileImage);
  }
}

