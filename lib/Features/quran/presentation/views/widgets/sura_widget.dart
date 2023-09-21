import 'package:fastaqm_app/Core/constatnts/colors.dart';
import 'package:fastaqm_app/Core/constatnts/variables.dart';
import 'package:flutter/material.dart';

class SuraWidget extends StatelessWidget {
  const SuraWidget({super.key, required this.suraPages});
  final List<int> suraPages;

  List<Widget> retPage(context) {
    bool lock = false;
    final List<Widget> pages = [];
    for (int i = 0; i < suraPages.length; i++) {
      if (suraPages[0] == 2 && !lock || suraPages[0] == 1) {
        pages.add(Container(
          color: MyColors.lightBrown,
          height: 50,
          child: Image.asset(
            "assets/quran_images/${suraPages[i]}.jpg",
            //color: Colors.black,
            //height: AppVariables.appSize(context).height,
            fit: BoxFit.fill,
          ),
        ));
        lock = true;
      } else {
        pages.add(Image.asset(
          "assets/quran_images/${suraPages[i]}.png",
          height: AppVariables.appSize(context).height,
          fit: BoxFit.fill,
        ));
      }
    }

    return pages;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
