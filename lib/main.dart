import 'package:bloc/bloc.dart';
import 'package:fastaqm_app/Core/theme/app_theme.dart';
import 'package:fastaqm_app/Features/splash/presentation/views/splash_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Core/constatnts/app_strings.dart';
import 'Core/helpers/cachehelper.dart';
import 'Core/helpers/dio_helper.dart';
import 'Core/services/BlocObserver.dart';
import 'Core/services/ServiceLocator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  DioHelper.init();
  setUpServiceLocator();
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppStrings.appName,
      theme: AppTheme.lightTheme(),
      home: const SplashScreen(),
    );
  }
}
