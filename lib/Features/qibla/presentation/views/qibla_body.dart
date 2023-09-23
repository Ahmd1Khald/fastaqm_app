import 'package:fastaqm_app/Core/widgets/customErrorContainer.dart';
import 'package:fastaqm_app/Features/qibla/presentation/views/widgets/qiblah_widget.dart';
import 'package:flutter/material.dart';

import '../../../../Core/constatnts/app_strings.dart';
import '../../../../Core/helpers/cachehelper.dart';

class QiblaScreen extends StatelessWidget {
  const QiblaScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (CacheHelper.getDate(key: AppStrings.locationKey) == true) {
      return const QiblahWidget();
    }
    return const Scaffold(
      body: CustomErrorContainer(title: 'قم بتفعيل الموقع'),
    );
    //
  }
}
