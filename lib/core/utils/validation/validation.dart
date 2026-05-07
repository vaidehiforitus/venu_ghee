import 'package:flutter/services.dart';

class AppValidation {
  static String? confirmPasswordValidation(String? value, String? password) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    } else {
      if (password != value) {
        return 'Passwords do not match';
      }
      return null;
    }
  }

  static String? passwordValidation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter password';
    }

    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }

    return null;
  }

  /// ✅ Confirm Password Validation
  static String? validConfirmPassword(
      String? value,
      String password,
      ) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }

    if (value != password) {
      return 'Passwords do not match';
    }

    return null;
  }
  static String? validateEmail(String? value) {
    if (value!.isEmpty) {
      return 'Please enter your email address.';
    }

    // Only allow emails ending with @gmail.com
    final RegExp emailRegex = RegExp(r'^[\w-\.]+@gmail\.com$');

    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid Gmail address.';
    }
    return null;
  }
  //
  // static String? validConfirmPassword(String? value, String password) {
  //   if (value == null || value.isEmpty) {
  //     return 'Please confirm your password';
  //   }
  //   if (value != password) {
  //     return 'Passwords do not match';
  //   }
  //   return null;
  // }

  static String? validateOtpCode(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Code cannot be empty";
    } else if (value.trim().length < 4) {
      return "Enter 4-digit code";
    }
    return null;
  }

  static String? validateUsername(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Username is required';
    } else if (!RegExp(r'^[a-zA-Z0-9_]{3,15}$').hasMatch(value)) {
      return 'Enter 3–15 characters: letters, numbers, underscores only';
    }
    return null;
  }

  static String? validPassword(String? value) {
    if (value == null || value.isEmpty) {
      return "please enter password";
    } else if (value.length < 6) {
      return "Password must be at least 6 characters";
    }
    return null;
  }

  static String? validatePassword(String? value) {
    RegExp regex = RegExp(
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
    );
    if (value!.isEmpty) {
      return 'Please enter password';
    } else {
      if (value.length < 8) {
        // return 'Password must be at least 8 characters long and include';
        return 'password length must be greater than 6';
      } else {
        if (!regex.hasMatch(value)) {
          return 'uppercase, lowercase, number, and special character';
        }
        return null;
      }
    }
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }

    // Regular expression for phone number validation:
    // - Allows only digits (0-9)
    // - Must be exactly 10 digits long
    final phoneRegex = RegExp(r'^[0-9]{10}$');

    if (!phoneRegex.hasMatch(value)) {
      return 'Enter a valid 10-digit phone number';
    }

    return null; // Valid phone number
  }

  static String? validateNewPassword(String? value) {
    RegExp regex = RegExp(
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
    );
    if (value!.isEmpty) {
      return 'Please enter password';
    } else if (value.length < 8) {
      return 'Password length must be greater than 8';
    } else if (!regex.hasMatch(value)) {
      return 'Password must contain uppercase, lowercase, number, and special character';
    }
    return null;
  }

  static String? validateConfirmPassword(String? value) {
    if (value!.isEmpty) {
      return 'Confirm password cannot be empty';
    }
    return null;
  }

  static String? validateNormalText(
    String? value, {
    String fieldName = 'Field',
  }) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }

    // if (value.trim().length < 3) {
    //   return '$fieldName must be at least 3 characters';
    // }

    return null;
  }

  static String? validateImage(String? path,
      {String fieldName = 'Image'}) {
    if (path == null || path.isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

}

class LowerCaseTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return TextEditingValue(
      text: newValue.text.toLowerCase(),
      selection: newValue.selection,
    );
  }
}
