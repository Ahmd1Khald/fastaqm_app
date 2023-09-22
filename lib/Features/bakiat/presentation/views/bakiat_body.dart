import 'package:fastaqm_app/Core/widgets/custom_app_bar.dart';
import 'package:fastaqm_app/Features/bakiat/presentation/views/widgets/custom_background.dart';
import 'package:fastaqm_app/Features/bakiat/presentation/views/widgets/custom_bakiat.dart';
import 'package:flutter/material.dart';

class BakiatScreen extends StatelessWidget {
  const BakiatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CustomBackground(),
            CustomBakiat(text: "سبحان الله", index: 1),
            CustomBakiat(text: "الحمد لله", index: 2),
            CustomBakiat(text: "لا إله إلا الله", index: 3),
            CustomBakiat(text: "الله أكبر", index: 4),
            CustomBakiat(text: "أستغفر الله", index: 5),
          ],
        ),
      ),
    );
  }
}
