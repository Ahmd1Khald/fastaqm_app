import 'package:fastaqm_app/Core/constatnts/app_strings.dart';
import 'package:fastaqm_app/Core/constatnts/assets_manager.dart';
import 'package:fastaqm_app/Core/constatnts/colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AppName extends StatelessWidget {
  const AppName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Shimmer.fromColors(
          period: const Duration(seconds: 2),
          baseColor: MyColors.babyBrown,
          highlightColor: MyColors.darkBrown,
          child: const Text(
            AppStrings.appName,
            style: TextStyle(
              fontSize: 26,
            ),
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Image.asset(
          AssetsManager.appLogo,
          height: 60,
        )
      ],
    );
  }
}
