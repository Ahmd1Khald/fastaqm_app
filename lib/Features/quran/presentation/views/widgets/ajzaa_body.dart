import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran/quran.dart' as quran;

import '../../../../../Core/constatnts/assets_manager.dart';
import '../../../../../Core/constatnts/colors.dart';
import '../../../../../Core/constatnts/variables.dart';

class AjzaaBody extends StatelessWidget {
  const AjzaaBody({Key? key}) : super(key: key);

  String getJuzaName({required int num}) {
    String ss = "";
    if (num == 1) {
      ss = "الجزء الأول";
    } else if (num == 2) {
      ss = "الجزء الثاني";
    } else if (num == 3) {
      ss = "الجزء الثالث";
    } else if (num == 4) {
      ss = "الجزء الرابع";
    } else if (num == 5) {
      ss = "الجزء الخامس";
    } else if (num == 6) {
      ss = "الجزء السادس";
    } else if (num == 7) {
      ss = "الجزء السابع";
    } else if (num == 8) {
      ss = "الجزء الثامن";
    } else if (num == 9) {
      ss = "الجزء التاسع";
    } else if (num == 10) {
      ss = "الجزء العاشر";
    } else if (num == 11) {
      ss = "الجزء الحادي عشر";
    } else if (num == 12) {
      ss = "الجزء الثاني عشر";
    } else if (num == 13) {
      ss = "الجزء الثالث عشر";
    } else if (num == 14) {
      ss = "الجزء الرابع عشر";
    } else if (num == 15) {
      ss = "الجزء الخامس عشر";
    } else if (num == 16) {
      ss = "الجزء السادس عشر";
    } else if (num == 17) {
      ss = "الجزء السابع عشر";
    } else if (num == 18) {
      ss = "الجزء الثامن عشر";
    } else if (num == 19) {
      ss = "الجزء التاسع عشر";
    } else if (num == 20) {
      ss = "الجزء العشرون";
    } else if (num == 21) {
      ss = "الجزء الحادي والعشرون";
    } else if (num == 22) {
      ss = "الجزء الثاني والعشرون";
    } else if (num == 23) {
      ss = "الجزء الثالث والعشرون";
    } else if (num == 24) {
      ss = "الجزء الرابع والعشرون";
    } else if (num == 25) {
      ss = "الجزء الخامس والعشرون";
    } else if (num == 26) {
      ss = "الجزء السادس والعشرون";
    } else if (num == 27) {
      ss = "الجزء السابع والعشرون";
    } else if (num == 28) {
      ss = "الجزء الثامن والعشرون";
    } else if (num == 29) {
      ss = "الجزء التاسع والعشرون";
    } else if (num == 30) {
      ss = "الجزء الثلاثون";
    }

    return ss;
  }

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
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage(AssetsManager.quranImage),
            opacity: 0.3,
          )),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  int suraNum = index + 1;
                  return SizedBox(
                    height: AppVariables.appSize(context).width * 0.17,
                    child: Center(
                      child: ListTile(
                        title: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              '45 صفحة',
                              style: GoogleFonts.noticiaText(
                                textStyle: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  color: MyColors.darkBrown,
                                ),
                              ),
                            ),
                            const Spacer(),
                            Row(
                              children: [
                                Text(
                                  getJuzaName(num: suraNum),
                                  style: GoogleFonts.notoNastaliqUrdu(
                                    textStyle: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w400,
                                      color: MyColors.darkBrown,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  '.${index + 1}',
                                  style: GoogleFonts.noticiaText(
                                    fontSize: 22,
                                    color: MyColors.darkBrown,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        //leading: Text('45 صفحة'),
                        splashColor: MyColors.darkBrown,
                        onTap: () {},
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => Container(
                  width: AppVariables.appSize(context).width,
                  height: 1,
                  color: MyColors.darkBrown,
                ),
                itemCount: 30,
              ),
            ),
          ],
        )
      ],
    );
  }
}
