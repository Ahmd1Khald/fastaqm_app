import 'package:fastaqm_app/Core/constatnts/app_functions.dart';
import 'package:fastaqm_app/Core/constatnts/assets_manager.dart';
import 'package:fastaqm_app/Core/constatnts/colors.dart';
import 'package:fastaqm_app/Core/constatnts/variables.dart';
import 'package:fastaqm_app/Features/quran/presentation/views/widgets/quran_image_widget.dart';
import 'package:fastaqm_app/Features/quran/presentation/views/widgets/sura_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran/quran.dart' as quran;

import '../../../../Core/widgets/custom_app_bar.dart';

class QuranScreen extends StatelessWidget {
  const QuranScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("quraaaaaaaaaaaaaaaaaaaaaan");
    return Scaffold(
      appBar: customAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const QuranImage(),
            const SizedBox(
              height: 10,
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => BuildSuraContainer(
                context: context,
                index: index,
              ),
              itemCount: 114,
            ),
          ],
        ),
      ),
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
    print("+++++++++++++++++");
    print(quran.getSurahAndVersesFromJuz(25));
    var tt = quran.getSurahAndVersesFromJuz(25);
    print("رقم السور الموجودة في الجزء");
    print(tt.keys.toList());
    int surahNumber = tt.keys.toList()[0];
    int verseNumber = tt.values.toList()[0][1];
    int firstPageInJusa = quran.getPageNumber(surahNumber, verseNumber);
    print("firstPageInJusa");
    print(firstPageInJusa);
    surahNumber = tt.keys.toList()[tt.keys.toList().length - 1];
    verseNumber = tt.values.toList()[tt.values.toList().length - 1][1];
    int lastPageInJusa = quran.getPageNumber(surahNumber, verseNumber);
    print("lastPageInJusa");
    print(lastPageInJusa);

    for (int i = 0; i < quran.getSurahAndVersesFromJuz(30).length; i++) {}
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      child: MaterialButton(
        color: MyColors.lightBrown,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                "${quran.getSurahPages(index + 1).length}",
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
              quran.getSurahNameArabic(index + 1),
              style: GoogleFonts.notoNastaliqUrdu(
                textStyle: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                  color: MyColors.darkBrown,
                ),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Image.asset(
              AssetsManager.q1Icon,
              color: MyColors.darkBrown,
              width: AppVariables.appSize(context).width * 0.12,
            ),
          ],
        ),
      ),
    );
  }
}
