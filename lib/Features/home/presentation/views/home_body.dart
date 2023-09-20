import 'package:fastaqm_app/Core/constatnts/app_functions.dart';
import 'package:fastaqm_app/Core/constatnts/assets_manager.dart';
import 'package:fastaqm_app/Core/constatnts/colors.dart';
import 'package:fastaqm_app/Core/constatnts/variables.dart';
import 'package:flutter/material.dart';

import '../../../quran/presentation/views/quran_body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              customItem(
                context: context,
                image: AssetsManager.masjedIcon,
                text: "مواقيت الصلاة",
                func: () {},
              ),
              customItem(
                context: context,
                image: AssetsManager.hadithLogo,
                text: "أحاديث",
                func: () {},
              ),
              customItem(
                context: context,
                image: AssetsManager.quranIcon,
                text: "قرآن",
                func: () {
                  AppFunctions.pushTo(
                      context: context, screen: const QuranScreen());
                },
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              customItem(
                context: context,
                image: AssetsManager.duaaLogo,
                text: "أدعية وظيفية",
                func: () {},
              ),
              customItem(
                context: context,
                image: AssetsManager.azkarIcon,
                text: "أذكار",
                func: () {},
              ),
              customItem(
                context: context,
                image: AssetsManager.bakiatIcon,
                text: "الباقيات الصالحات",
                func: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Column customItem({
    required BuildContext context,
    required String image,
    required String text,
    required VoidCallback func,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
            padding: const EdgeInsets.all(8),
            child: MaterialButton(
              height: AppVariables.appSize(context).width * 0.2,
              minWidth: AppVariables.appSize(context).width * 0.2,
              onPressed: func,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              splashColor: MyColors.lightBrown,
              color: MyColors.darkBrown,
              child: Center(
                child: Image.asset(
                  image,
                  width: AppVariables.appSize(context).width * 0.15,
                ),
              ),
            )),
        // Container(
        //   height: AppVariables.appSize(context).width * 0.2,
        //   width: AppVariables.appSize(context).width * 0.2,
        //   decoration: BoxDecoration(
        //     color: MyColors.darkBrown,
        //     borderRadius: BorderRadius.circular(20),
        //   ),
        //   child: Center(
        //     child: Image.asset(
        //       image,
        //       width: AppVariables.appSize(context).width * 0.15,
        //     ),
        //   ),
        // ),
        Text(
          text,
          textDirection: TextDirection.rtl,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
