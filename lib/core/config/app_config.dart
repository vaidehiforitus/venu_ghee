class AppConfig {
  static const String apiBaseUrl = 'http://192.168.1.4:8000';
  static const Duration connectTimeout = Duration(seconds: 10);
  static const Duration receiveTimeout = Duration(seconds: 8);
  static const int maxRetries = 3;
}
