import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fastaqm_app/Core/constatnts/variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:share/share.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

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

  static Future<void> sendNotification({
    required String title,
    required String body,
    required String type,
  }) async {
    print("Push Notification -------->");
    var headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'key=AAAAxmGcOwI:APA91bGlwvJHOCYCGF8TNpHFosarYpHfTYLqhq5PjdM3C1sbWhC3NPyA38Hdy6q3OMRSAXEzVCWEJ7WqNCbcj2iBZvJrk7J3zath4OsQF5Eyy1-Vux10ptyQksFTFUxrUEhF4Eu5Qp0C'
    };
    var data = json.encode({
      "to": AppVariables.deviceToken,
      "notification": {
        "title": title,
        "body": body,
        "mutable_content": true,
        "sound": "Tri-tone"
      },
      "data": {
        "type": type,
      }
    });
    var dio = Dio();
    var response = await dio.request(
      'https://fcm.googleapis.com/fcm/send',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      print(json.encode(response.data));
    } else {
      print(response.statusMessage);
    }
  }

  static Future<void> configureLocalTimeZone() async {
    tz.initializeTimeZones();
    final String timeZoneName = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));

    print("tz.TimeZone => ${tz.getLocation(timeZoneName)}");
  }
}
