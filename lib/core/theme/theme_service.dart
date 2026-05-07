import 'package:get_storage/get_storage.dart';

class ThemeService {
  final _box = GetStorage();
  final _key = 'themeMode';

  String? getThemeMode() => _box.read(_key);

  void saveThemeMode(String themeMode) => _box.write(_key, themeMode);
}
