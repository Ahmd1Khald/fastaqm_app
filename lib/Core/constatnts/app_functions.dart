import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:share/share.dart';

class AppFunctions {
  static String convertEnglishNumberToArabic(String input) {
    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const farsi = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];

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
    // Navigator.of(context).push(
    //   PageRouteBuilder(
    //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
    //       return SharedAxisTransition(
    //         transitionType: SharedAxisTransitionType.horizontal,
    //         secondaryAnimation: secondaryAnimation,
    //         animation: animation,
    //         child: child,
    //       );
    //     },
    //     transitionDuration: const Duration(seconds: 1),
    //     barrierColor: Colors.black,
    //     pageBuilder: (context, animation, secondaryAnimation) {
    //       return screen;
    //     },
    //   ),
    // );
  }

  static void shareDuaa(String textToShare, {String subject = ''}) {
    Share.share(
        "$textToShare\n https://play.google.com/store/apps/details?id=at.ahmed1khaled.fastakmapp",
        subject: subject);
  }

  static Future<void> oneSignal() async {
    OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
    OneSignal.initialize("10c43c71-1dcf-4be9-b368-8220add934e1");
    OneSignal.Notifications.requestPermission(true);
  }
}
