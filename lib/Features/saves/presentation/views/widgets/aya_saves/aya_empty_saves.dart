import 'package:flutter/material.dart';

import '../../../../../../Core/widgets/customErrorContainer.dart';
import '../../../../../../Core/widgets/custom_app_bar.dart';

class AyaEmptyWidget extends StatelessWidget {
  const AyaEmptyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context),
      body: const CustomErrorContainer(
        title: "لا يوجد آيـــات مضافة",
      ),
    );
  }
}
