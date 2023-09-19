import 'package:fastaqm_app/Core/constatnts/app_strings.dart';
import 'package:fastaqm_app/Core/theme/app_theme.dart';
import 'package:fastaqm_app/Features/splash/presentation/views/splash_body.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppStrings.appName,
      theme: AppTheme.lightTheme(),
      home: const SplashScreen(),
    );
  }
}
