import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotifyHelper {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  String selectedNotificationPayload = '';

  // final BehaviorSubject<String> selectNotificationSubject =
  //     BehaviorSubject<String>();
  initializeNotification() async {
    tz.initializeTimeZones();
    _configureSelectNotificationSubject();
    await _configureLocalTimeZone();
    // await requestIOSPermissions(flutterLocalNotificationsPlugin);
    // final IOSInitializationSettings initializationSettingsIOS =
    //     IOSInitializationSettings(
    //   requestSoundPermission: false,
    //   requestBadgePermission: false,
    //   requestAlertPermission: false,
    //   onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    // );

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_logo');

    const InitializationSettings initializationSettings =
        InitializationSettings(
      //iOS: initializationSettingsIOS,
      android: initializationSettingsAndroid,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      // onSelectNotification: (String? payload) async {
      //   if (payload != null) {
      //     debugPrint('notification payload: ' + payload);
      //   }
      //   selectNotificationSubject.add(payload!);
      // },
    );
  }

  displayNotification({required String title, required String body}) async {
    print('doing test');
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'channel 3',
      'your channel name',
      importance: Importance.max,
      priority: Priority.high,
      sound: RawResourceAndroidNotificationSound('azan'),
    );
    // var iOSPlatformChannelSpecifics = const IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      //iOS: iOSPlatformChannelSpecifics,
    );
    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      "حان الآن موعد آذان $body",
      platformChannelSpecifics,
      payload: 'Default_Sound',
    );
  }

  // scheduledNotification({
  //   required int hour,
  //   required int id,
  //   required int minutes,
  //   String title = "فاستقم",
  //   required String body,
  //   //required String channelId,
  // }) async {
  //   // Calculate the next instance of the specified time
  //   final tz.TZDateTime scheduledDate = _nextInstanceOfTime(hour, minutes);
  //
  //   // Calculate the time difference between the scheduled time and the current time
  //   final Duration timeUntilNotification =
  //       scheduledDate.isBefore(tz.TZDateTime.now(tz.local))
  //           ? scheduledDate
  //               .add(const Duration(days: 1))
  //               .difference(tz.TZDateTime.now(tz.local))
  //           : scheduledDate.difference(tz.TZDateTime.now(tz.local));
  //
  //   print("$scheduledDate +++++++++++++++++++");
  //   await flutterLocalNotificationsPlugin
  //       .zonedSchedule(
  //         id,
  //         title,
  //         "حان الآن موعد آذان $body",
  //         //tz.TZDateTime.from(now, tz.local).add(const Duration(seconds: 5)),
  //         scheduledDate,
  //         const NotificationDetails(
  //           android: AndroidNotificationDetails(
  //             'your channel 5',
  //             'your channel name',
  //             importance: Importance.max,
  //             priority: Priority.high,
  //             sound: RawResourceAndroidNotificationSound('azan'),
  //           ),
  //         ),
  //         androidAllowWhileIdle: true,
  //         uiLocalNotificationDateInterpretation:
  //             UILocalNotificationDateInterpretation.absoluteTime,
  //         matchDateTimeComponents: DateTimeComponents.time,
  //         // payload: '${task.title}|${task.note}|${task.startTime}|',
  //       )
  //       .then((value) => print("scheduledNotification+++++++++++"));
  // }
  //
  // void azkarNotification({
  //   required int hour,
  //   required int minutes,
  //   required int id,
  //   required String title,
  //   required String body,
  // }) async {
  //   // Calculate the next instance of the specified time
  //   final tz.TZDateTime scheduledDate = _nextInstanceOfTime(hour, minutes);
  //
  //   // Calculate the time difference between the scheduled time and the current time
  //   final Duration timeUntilNotification =
  //       scheduledDate.isBefore(tz.TZDateTime.now(tz.local))
  //           ? scheduledDate
  //               .add(const Duration(days: 1))
  //               .difference(tz.TZDateTime.now(tz.local))
  //           : scheduledDate.difference(tz.TZDateTime.now(tz.local));
  //
  //   print("$scheduledDate +++++++++++++++++++");
  //   print("اذكاار +++++++++++++++++++");
  //
  //   await flutterLocalNotificationsPlugin
  //       .zonedSchedule(
  //     id,
  //     "فاستقم",
  //     body,
  //     scheduledDate,
  //     const NotificationDetails(
  //       android: AndroidNotificationDetails(
  //         'your channel 6',
  //         'your channel name',
  //         importance: Importance.max,
  //         priority: Priority.max,
  //         enableVibration: true,
  //         enableLights: true,
  //       ),
  //     ),
  //     uiLocalNotificationDateInterpretation:
  //         UILocalNotificationDateInterpretation.absoluteTime,
  //     matchDateTimeComponents: DateTimeComponents.time,
  //     payload: '${title}|$body', // You can include additional data if needed
  //     androidAllowWhileIdle: true,
  //   )
  //       .then((value) {
  //     print('azkarNotification scheduled for $scheduledDate');
  //   });
  // }

// Calculate the next instance of the specified time

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
            enableVibration: true,
            sound: RawResourceAndroidNotificationSound('azan'),
          ),
        ),
        androidAllowWhileIdle: true,
        androidScheduleMode: AndroidScheduleMode.exact,
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

    print("Azkar notification ++++++++");
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
            'your channel 10',
            'your channel name 10',
            importance: Importance.max,
            priority: Priority.max,
            enableVibration: true,
            enableLights: true,
          ),
        ),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
        payload: '$title|$body', // You can include additional data if needed
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

  tz.TZDateTime _nextInstanceOfTime(int hour, int minutes) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minutes,
    );
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  cancelNotifications({required int id}) async {
    await flutterLocalNotificationsPlugin.cancel(id);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('notification_$id');
    print("cancelNotifications $id+++++++");
  }

  tz.TZDateTime _nextInstanceOfTenAM(int hour, int minutes) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minutes);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  void requestIOSPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
    final String timeZoneName = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));
  }

/*   Future selectNotification(String? payload) async {
    if (payload != null) {
      //selectedNotificationPayload = "The best";
      selectNotificationSubject.add(payload);
      print('notification payload: $payload');
    } else {
      print("Notification Done");
    }
    Get.to(() => SecondScreen(selectedNotificationPayload));
  } */

//Older IOS
  Future onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    // display a dialog with the notification details, tap ok to go to another page
    /* showDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Title'),
        content: const Text('Body'),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: const Text('Ok'),
            onPressed: () async {
              Navigator.of(context, rootNavigator: true).pop();
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Container(color: Colors.white),
                ),
              );
            },
          )
        ],
      ),
    );
 */
    //Get.dialog(Text(body!));
  }

  void _configureSelectNotificationSubject() {
    // selectNotificationSubject.stream.listen((String payload) async {
    //   debugPrint('My payload is ' + payload);
    //   // await Get.to(() => NotificationScreen(payload));
    // });
  }
}
