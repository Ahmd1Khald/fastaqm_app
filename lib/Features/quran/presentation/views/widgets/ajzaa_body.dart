import 'package:fastaqm_app/Core/constatnts/app_functions.dart';
import 'package:fastaqm_app/Features/quran/presentation/views/widgets/sura_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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

  int getJuzaPageCount({required int num}) {
    int count = 0;
    if (num == 1) {
      count = 1;
    } else if (num == 2) {
      count = 22;
    } else if (num == 3) {
      count = 42;
    } else if (num == 4) {
      count = 62;
    } else if (num == 5) {
      count = 82;
    } else if (num == 6) {
      count = 102;
    } else if (num == 7) {
      count = 121;
    } else if (num == 8) {
      count = 142;
    } else if (num == 9) {
      count = count = 162;
    } else if (num == 10) {
      count = 182;
    } else if (num == 11) {
      count = 201;
    } else if (num == 12) {
      count = 222;
    } else if (num == 13) {
      count = 242;
    } else if (num == 14) {
      count = 262;
    } else if (num == 15) {
      count = 282;
    } else if (num == 16) {
      count = 302;
    } else if (num == 17) {
      count = 322;
    } else if (num == 18) {
      count = 342;
    } else if (num == 19) {
      count = 362;
    } else if (num == 20) {
      count = 382;
    } else if (num == 21) {
      count = 402;
    } else if (num == 22) {
      count = 422;
    } else if (num == 23) {
      count = 442;
    } else if (num == 24) {
      count = 462;
    } else if (num == 25) {
      count = 482;
    } else if (num == 26) {
      count = 502;
    } else if (num == 27) {
      count = 522;
    } else if (num == 28) {
      count = 542;
    } else if (num == 29) {
      count = 562;
    } else if (num == 30) {
      count = 582;
    }

    return count;
  }

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
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  int suraNum = index + 1;
                  return SizedBox(
                    height: AppVariables.appSize(context).width * 0.2,
                    child: Center(
                      child: ListTile(
                        title: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              '${getJuzaPageCount(num: suraNum)} صفحة',
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
                              ],
                            ),
                          ],
                        ),
                        splashColor: MyColors.darkBrown,
                        onTap: () {
                          AppFunctions.pushTo(
                              context: context,
                              screen: SuraWidget(
                                suraPages: [getJuzaPageCount(num: suraNum)],
                              ));
                        },
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => Container(
                  width: AppVariables.appSize(context).width,
                  height: 1,
                  color: MyColors.darkBrown.withOpacity(0.1),
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
