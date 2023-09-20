import 'package:fastaqm_app/Core/constatnts/variables.dart';
import 'package:flutter/material.dart';

class SuraWidget extends StatelessWidget {
  const SuraWidget({super.key, required this.suraPages});
  final List<int> suraPages;

  List<Widget> retPage(context) {
    final List<Widget> pages = [];
    for (int i = 0; i < suraPages.length; i++) {
      pages.add(Image.asset(
        "assets/quran_images/${suraPages[i]}.png",
        height: AppVariables.appSize(context).height,
        fit: BoxFit.fill,
      ));
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
            children: retPage(context),
          ),
        ),
      ),
    );
  }
}
