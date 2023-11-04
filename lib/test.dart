// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:timezone/timezone.dart' as tz;
//
// class NotificationService {
//   final FlutterLocalNotificationsPlugin notificationsPlugin =
//       FlutterLocalNotificationsPlugin();
//
//   Future<void> initNotification() async {
//     AndroidInitializationSettings initializationSettingsAndroid =
//         const AndroidInitializationSettings('app_logo');
//
//     var initializationSettingsIOS = DarwinInitializationSettings(
//         requestAlertPermission: true,
//         requestBadgePermission: true,
//         requestSoundPermission: true,
//         onDidReceiveLocalNotification:
//             (int id, String? title, String? body, String? payload) async {});
//
//     var initializationSettings = InitializationSettings(
//         android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
//     await notificationsPlugin.initialize(initializationSettings,
//         onDidReceiveNotificationResponse:
//             (NotificationResponse notificationResponse) async {});
//   }
//
//   notificationDetails() {
//     return const NotificationDetails(
//         android: AndroidNotificationDetails(
//           'channelId 2channelId 2',
//           'channelNamechannelName',
//           importance: Importance.max,
//           //priority: Priority.high,
//           playSound: true,
//           sound: RawResourceAndroidNotificationSound('azan'),
//         ),
//         iOS: DarwinNotificationDetails());
//   }
//
//   Future showNotification({
//     int id = 0,
//     required String title,
//     required String body,
//     String? payLoad,
//   }) async {
//     await notificationsPlugin.show(
//       id,
//       title,
//       body,
//       await notificationDetails(),
//     );
//     final a = await notificationsPlugin.getActiveNotifications();
//     final b = await notificationsPlugin
//         .getNotificationAppLaunchDetails()
//         .whenComplete(() => null);
//     final c = await notificationsPlugin
//         .pendingNotificationRequests()
//         .whenComplete(() => null);
//     print("getActiveNotifications => ${a}");
//     print("getNotificationAppLaunchDetails => ${b}");
//     print("pendingNotificationRequests => ${c}");
//   }
//
//   void scheduleNotification({
//     int id = 0,
//     required String title,
//     required String body,
//     required int minutes,
//     required int hour,
//     required int second,
//     String? payLoad,
//   }) async {
//     try {
//       final now = DateTime.now();
//       print("now +++++++++ ${now}");
//       print(
//           "scheduledNotificationDateTime => ${tz.TZDateTime.from(now, tz.local).add(const Duration(seconds: 5))}");
//       await notificationsPlugin.zonedSchedule(
//         id,
//         title,
//         body,
//         tz.TZDateTime.from(now, tz.local).add(const Duration(seconds: 5)),
//         await notificationDetails(),
//         androidAllowWhileIdle: true,
//         androidScheduleMode: AndroidScheduleMode.alarmClock,
//         matchDateTimeComponents: DateTimeComponents.time,
//         uiLocalNotificationDateInterpretation:
//             UILocalNotificationDateInterpretation.absoluteTime,
//         // uiLocalNotificationDateInterpretation:
//         //     UILocalNotificationDateInterpretation.absoluteTime,
//       );
//
//       final a = await notificationsPlugin.getActiveNotifications();
//       final b = await notificationsPlugin.getNotificationAppLaunchDetails();
//       final c = await notificationsPlugin.pendingNotificationRequests();
//       print("getActiveNotifications => ${a}");
//       print("getNotificationAppLaunchDetails => ${b}");
//       print("pendingNotificationRequests => ${c}");
//     } catch (e) {
//       print('Error scheduling notification: $e');
//     }
//   }
// }
