import 'package:fastaqm_app/Core/theme/app_theme.dart';
import 'package:fastaqm_app/Features/quran/presentation/controller/quran_cubit.dart';
import 'package:fastaqm_app/Features/splash/presentation/views/splash_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Core/constatnts/app_strings.dart';

void main() {
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => QuranCubit()..setUpQuran()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: AppStrings.appName,
        theme: AppTheme.lightTheme(),
        home: const SplashScreen(),
      ),
    );
  }
}
