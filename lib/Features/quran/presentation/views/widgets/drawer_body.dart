import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran/quran.dart' as quran;

import '../../../../../Core/constatnts/colors.dart';
import '../../../../../Core/constatnts/variables.dart';

class DrawerBody extends StatelessWidget {
  const DrawerBody({Key? key}) : super(key: key);

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
    return Drawer(
      width: AppVariables.appSize(context).width * 0.8,
      backgroundColor: MyColors.lightBrown,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                ": الأجزاء",
                style: GoogleFonts.notoNastaliqUrdu(
                  fontSize: 28,
                  color: MyColors.darkBrown,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) => SizedBox(
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
                                fontSize: 16,
                                color: MyColors.darkBrown,
                              ),
                            ),
                            const Spacer(),
                            Row(
                              children: [
                                Text(
                                  'الجزء الأول',
                                  style: GoogleFonts.noticiaText(
                                    fontSize: 22,
                                    color: MyColors.darkBrown,
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
                  ),
                  separatorBuilder: (context, index) => Container(
                    width: AppVariables.appSize(context).width,
                    height: 1,
                    color: MyColors.darkBrown,
                  ),
                  itemCount: 30,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
