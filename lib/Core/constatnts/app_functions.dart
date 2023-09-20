import 'package:flutter/material.dart';

class AppFunctions {
  static String convertEnglishNumberToArabic(String input) {
    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const farsi = ['۰', '۱', '۲', '۳', '۴', '۵', '٦', '۷', '۸', '۹'];

    for (int i = 0; i < english.length; i++) {
      input = input.replaceAll(english[i], farsi[i]);
    }

    return input;
  }

  static void pushAndRemove({required context, required Widget screen}) {
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => screen), (route) => false);
  }

  static void pushTo({required context, required Widget screen}) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }
}
