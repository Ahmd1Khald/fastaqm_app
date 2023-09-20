import 'package:fastaqm_app/Core/constatnts/variables.dart';
import 'package:flutter/material.dart';

class SuraWidget extends StatelessWidget {
  const SuraWidget({super.key});
  List<Widget> retPage(context) {
    final List<Widget> pages = [
      Image.asset(
        "assets/10.png",
        height: AppVariables.appSize(context).height,
        fit: BoxFit.fill,
      ),
      Image.asset(
        "assets/10.png",
        height: AppVariables.appSize(context).height,
        fit: BoxFit.fill,
      ),
      Image.asset(
        "assets/10.png",
        height: AppVariables.appSize(context).height,
        fit: BoxFit.fill,
      ),
      Image.asset(
        "assets/10.png",
        height: AppVariables.appSize(context).height,
        fit: BoxFit.fill,
      ),
    ];
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
