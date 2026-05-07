// app_error_handler.dart
import 'package:venu_ghee/core/utils/widgets/alert_widgets/toast_message.dart';

import 'failures.dart';

class ErrorHandler {
  static void handleError(dynamic error) {
    if (error is Failure) {
      CommonSnackBar.error(error.message);
    }
    else if (error is String) {
      CommonSnackBar.error(error);
    }
    else {
      CommonSnackBar.error("Something went wrong");
    }
  }


}

