import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final AndroidInitializationSettings _androidInitializationSettings =
      const AndroidInitializationSettings('app_logo');

  void initializeNotifications() async {
    InitializationSettings initializationSettings = InitializationSettings(
      android: _androidInitializationSettings,
    );

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void sendNotification({
    required String title,
    required String body,
  }) async {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails(
      "channelId 2",
      "channelName",
      importance: Importance.max,
      priority: Priority.high,
      playSound: false,
      sound: RawResourceAndroidNotificationSound('azan'),
    );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );

    _flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      notificationDetails,
    );
  }

  Future<void> scheduleNotification({
    required String title,
    required String body,
  }) async {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      "channelId 2",
      "channelName",
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      sound: const RawResourceAndroidNotificationSound('azan'),
    );

    NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    tzdata.initializeTimeZones();
    const String timeZoneName =
        'Africa/Cairo'; // Replace with your desired time zone
    tz.setLocalLocation(tz.getLocation(timeZoneName));

    final now = tz.TZDateTime.now(tz.local);
    final scheduledDate =
        now.add(const Duration(seconds: 5)); // Schedule 5 minutes from now

    await _flutterLocalNotificationsPlugin.zonedSchedule(
      0, // Notification ID (use a unique ID for each notification)
      title,
      body,
      scheduledDate,
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  // void scheduleNotification({
  //   required String title,
  //   required String body,
  // }) async {
  //   AndroidNotificationDetails androidNotificationDetails =
  //       const AndroidNotificationDetails(
  //     'channelId 5',
  //     'channelName',
  //     importance: Importance.max,
  //     priority: Priority.high,
  //     playSound: true, // Enable sound
  //     sound:
  //         RawResourceAndroidNotificationSound('azan'), // Specify custom sound
  //   );
  //
  //   NotificationDetails notificationDetails = NotificationDetails(
  //     android: androidNotificationDetails,
  //   );
  //
  //   await _flutterLocalNotificationsPlugin.periodicallyShow(
  //     0,
  //     title,
  //     body,
  //     RepeatInterval.everyMinute,
  //     notificationDetails,
  //   );
  // }
}
