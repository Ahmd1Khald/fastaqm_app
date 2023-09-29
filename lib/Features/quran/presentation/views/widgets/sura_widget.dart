import 'package:fastaqm_app/Core/constatnts/colors.dart';
import 'package:fastaqm_app/Core/constatnts/variables.dart';
import 'package:flutter/material.dart';

class SuraWidget extends StatelessWidget {
  const SuraWidget({super.key, required this.suraPages});
  final List<int> suraPages;

  List<Widget> retPage(context) {
    final List<Widget> pages = [];
    for (int i = suraPages[0]; i <= 604; i++) {
      pages.add(Image.asset(
        "assets/quran_images/$i.png",
        height: AppVariables.appSize(context).height,
        fit: BoxFit.fill,
      ));
    }
    return pages;
  }

  @override
  Widget build(BuildContext context) {
    print(suraPages);
    return Scaffold(
      backgroundColor: MyColors.whiteColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: PageView(
            scrollDirection: Axis.horizontal,
            reverse: true,
            children: retPage(context),
          ),
        ),
      ),
    );
  }
}
