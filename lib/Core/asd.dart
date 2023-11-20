import 'package:shared_preferences/shared_preferences.dart';

class NotifyHelper {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // ... (other methods and properties)

  Future<void> scheduledNotification({
    required int hour,
    required int id,
    required int minutes,
    String title = "فاستقم",
    required String body,
  }) async {
    // Check if the notification has been used before
    bool notificationUsed = await getNotificationUsedStatus(id);

    if (!notificationUsed) {
      // Calculate the next instance of the specified time
      final tz.TZDateTime scheduledDate = _nextInstanceOfTime(hour, minutes);

      // Calculate the time difference between the scheduled time and the current time
      final Duration timeUntilNotification =
          scheduledDate.isBefore(tz.TZDateTime.now(tz.local))
              ? scheduledDate
                  .add(const Duration(days: 1))
                  .difference(tz.TZDateTime.now(tz.local))
              : scheduledDate.difference(tz.TZDateTime.now(tz.local));

      print("$scheduledDate +++++++++++++++++++");

      await flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        title,
        "حان الآن موعد آذان $body",
        scheduledDate,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'your channel 5',
            'your channel name',
            importance: Importance.max,
            priority: Priority.high,
            sound: RawResourceAndroidNotificationSound('azan'),
          ),
        ),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
        payload: '${title}|$body', // You can include additional data if needed
      );

      // Mark the notification as used
      await setNotificationUsedStatus(id);
    } else {
      print("Notification already used");
    }
  }

  Future<void> azkarNotification({
    required int hour,
    required int minutes,
    required int id,
    required String title,
    required String body,
  }) async {
    // Check if the notification has been used before
    bool notificationUsed = await getNotificationUsedStatus(id);

    if (!notificationUsed) {
      // Calculate the next instance of the specified time
      final tz.TZDateTime scheduledDate = _nextInstanceOfTime(hour, minutes);

      // Calculate the time difference between the scheduled time and the current time
      final Duration timeUntilNotification =
          scheduledDate.isBefore(tz.TZDateTime.now(tz.local))
              ? scheduledDate
                  .add(const Duration(days: 1))
                  .difference(tz.TZDateTime.now(tz.local))
              : scheduledDate.difference(tz.TZDateTime.now(tz.local));

      print("$scheduledDate +++++++++++++++++++");
      print("اذكاار +++++++++++++++++++");

      await flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        "فاستقم",
        body,
        scheduledDate,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'your channel 6',
            'your channel name',
            importance: Importance.max,
            priority: Priority.max,
            enableVibration: true,
            enableLights: true,
          ),
        ),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
        payload: '${title}|$body', // You can include additional data if needed
        androidAllowWhileIdle: true,
      );

      // Mark the notification as used
      await setNotificationUsedStatus(id);
    } else {
      print("Notification already used");
    }
  }

  Future<bool> getNotificationUsedStatus(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('notification_$id') ?? false;
  }

  Future<void> setNotificationUsedStatus(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notification_$id', true);
    print("Marking notification as used: $id");
  }

// ... (other methods)
}
