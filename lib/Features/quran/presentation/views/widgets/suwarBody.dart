import 'package:fastaqm_app/Features/quran/presentation/views/widgets/sura_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran/quran.dart' as quran;

import '../../../../../Core/constatnts/app_functions.dart';
import '../../../../../Core/constatnts/assets_manager.dart';
import '../../../../../Core/constatnts/colors.dart';
import '../../../../../Core/constatnts/variables.dart';

class SuwuerBody extends StatelessWidget {
  const SuwuerBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage(AssetsManager.quranImage),
            opacity: 0.3,
          )),
        ),
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => BuildSuraContainer(
                  context: context,
                  index: index,
                ),
                itemCount: 114,
                separatorBuilder: (BuildContext context, int index) {
                  return Container(
                    width: AppVariables.appSize(context).width,
                    height: 1,
                    color: MyColors.darkBrown,
                  );
                },
              ),
            ],
          ),
        )
      ],
    );
  }
}

class BuildSuraContainer extends StatelessWidget {
  const BuildSuraContainer(
      {Key? key, required this.context, required this.index})
      : super(key: key);

  final BuildContext context;
  final int index;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: AppVariables.appSize(context).width * 0.18,
      //color: Theme.of(context).scaffoldBackgroundColor,
      splashColor: MyColors.darkBrown,
      onPressed: () {
        //cubit.surapages = quran.getSurahPages(index + 1);
        AppFunctions.pushTo(
            context: context,
            screen: SuraWidget(
              suraPages: quran.getSurahPages(index + 1),
            ));
        //print(quran.getSurahPages(index + 1));
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(
              "صفحة  ${quran.getSurahPages(index + 1).length}",
              style: GoogleFonts.noticiaText(
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: MyColors.darkBrown,
                ),
              ),
            ),
          ),
          const Spacer(),
          Text(
            "سورة  ${quran.getSurahNameArabic(index + 1)}",
            style: GoogleFonts.notoNastaliqUrdu(
              textStyle: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w400,
                color: MyColors.darkBrown,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          if (quran.getPlaceOfRevelation(index + 1) == "Madinah") ...[
            Image.asset(
              AssetsManager.masjedIcon,
              width: 25,
            ),
          ] else ...[
            Image.asset(
              AssetsManager.makaaIcon,
              width: 25,
            ),
          ],
        ],
      ),
    );
  }
}
