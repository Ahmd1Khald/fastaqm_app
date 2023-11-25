import 'package:bloc/bloc.dart';
import 'package:fastaqm_app/Core/constatnts/app_functions.dart';
import 'package:fastaqm_app/Core/theme/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'Core/constatnts/app_strings.dart';
import 'Core/helpers/cachehelper.dart';
import 'Core/services/BlocObserver.dart';
import 'Features/splash/presentation/views/splash_body.dart';
import 'firebase_options.dart';

/*Future<void> _firebaseMessagesBackground(RemoteMessage message) async {
  print("background =====>");
  print("${message.notification!.title}");
  print("${message.notification!.body}");
}*/

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //SharedPreferences prefs = await SharedPreferences.getInstance();
  //prefs.remove('notification_used_friday_8');
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //FirebaseMessaging.onBackgroundMessage(_firebaseMessagesBackground);
  await CacheHelper.init();
  await AppFunctions.oneSignal();
  Bloc.observer = MyBlocObserver();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    //final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

    /*_firebaseMessaging.getToken().then((token) {
      AppVariables.deviceToken = token;
      print('Device Token: $token');
    });*/

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: AppStrings.appName,
          theme: AppTheme.lightTheme(),
          home: const SplashScreen(),
        );
      },
    );
  }
}
