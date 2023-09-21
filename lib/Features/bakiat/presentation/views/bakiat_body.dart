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
      body: const SingleChildScrollView(
        child: Column(
          children: [
            CustomBackground(),
            CustomBakiat(text: "سبحان الله"),
            CustomBakiat(text: "الحمد الله"),
            CustomBakiat(text: "لا اله الا االله"),
            CustomBakiat(text: "الله اكبر"),
            CustomBakiat(text: "استغفر الله"),
          ],
        ),
      ),
    );
  }
}
