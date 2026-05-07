import 'package:pretty_dio_logger/pretty_dio_logger.dart';

PrettyDioLogger getLogger() => PrettyDioLogger(
  requestHeader: true,
  requestBody: true,
  responseBody: true,
  responseHeader: false,
  error: true,
  compact: false,
  maxWidth: 90,
);