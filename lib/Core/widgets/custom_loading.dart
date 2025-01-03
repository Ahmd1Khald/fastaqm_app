import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../constatnts/colors.dart';

class CustomLoadingPage extends StatelessWidget {
  const CustomLoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpinKitFadingCircle(
      itemBuilder: (BuildContext context, int index) {
        return DecoratedBox(
          decoration: BoxDecoration(
            color: index.isEven ? MyColors.babyBrown : MyColors.lightBrown,
          ),
        );
      },
    );
  }
}
