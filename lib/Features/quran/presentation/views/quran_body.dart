import 'package:fastaqm_app/Core/constatnts/colors.dart';
import 'package:fastaqm_app/Core/constatnts/variables.dart';
import 'package:fastaqm_app/Core/widgets/custom_app_bar.dart';
import 'package:fastaqm_app/Features/quran/presentation/views/widgets/surah_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran/quran.dart' as quraan;

import '../../../../Core/constatnts/assets_manager.dart';
import '../../../../Core/constatnts/constant.dart';
import '../../../../Core/widgets/custom_loading.dart';

class QuranScreen extends StatelessWidget {
  const QuranScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("quraaaaaaaaaaaaaaaaaaaaaan");
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        tooltip: 'Go to bookmark',
        backgroundColor: MyColors.lightBrown,
        onPressed: () async {
          fabIsClicked = true;
          if (await readBookmark() == true) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SurahBuilder(
                          arabic: quran[0],
                          sura: bookmarkedSura - 1,
                          suraName: arabicName[bookmarkedSura - 1]['name'],
                          ayah: bookmarkedAyah,
                        )));
          }
        },
        child: const Icon(
          Icons.bookmark,
          color: MyColors.darkBrown,
        ),
      ),
      appBar: customAppBar(context),
      body: FutureBuilder(
        future: readJson(),
        builder: (
          BuildContext context,
          AsyncSnapshot snapshot,
        ) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CustomLoadingPage();
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return const Text('حدث خطئ ما');
            } else if (snapshot.hasData) {
              return IndexCreator(
                quran: snapshot.data,
              );
            } else {
              return const Text('لا يوجد معلومات');
            }
          } else {
            return Text('State: ${snapshot.connectionState}');
          }
        },
      ),
    );
  }
}

class IndexCreator extends StatefulWidget {
  const IndexCreator({Key? key, required this.quran}) : super(key: key);

  @override
  State<IndexCreator> createState() => _IndexCreatorState();
  final List quran;
}

class _IndexCreatorState extends State<IndexCreator> {
  // bool isPlay = false;
  // final play = AudioPlayer();
  // Future<void> playQuran({required int sura}) async {
  //   print("sura $sura");
  //   print(quraan.getAudioURLByVerse(sura, 1));
  //   print(quraan.getAudioURLBySurah(sura));
  //   await play.play(UrlSource(quraan.getAudioURLBySurah(sura)));
  //   setState(() {});
  //   //play.onPlayerComplete;
  //   print(play.getCurrentPosition());
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: MyColors.appBackGroundColor,
      child: ListView(
        children: [
          Center(
            child: Container(
              width: AppVariables.appSize(context).width * 0.8,
              height: AppVariables.appSize(context).width * 0.15,
              decoration: BoxDecoration(
                color: MyColors.darkBrown,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                'القرآن الكريم',
                textAlign: TextAlign.center,
                style: GoogleFonts.notoNastaliqUrdu(
                  color: MyColors.whiteColor,
                  fontSize: 22.sp,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 25.h,
          ),
          for (int i = 0; i < 114; i++)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // SizedBox(
                      //   width: AppVariables.appSize(context).width * 0.14,
                      //   child: Container(
                      //     decoration: BoxDecoration(
                      //         shape: BoxShape.circle,
                      //         border: Border.all(
                      //           color: MyColors.darkBrown,
                      //           width: 5,
                      //         )),
                      //     child: Center(
                      //       child: IconButton(
                      //           onPressed: () {
                      //             playQuran(sura: i + 1);
                      //             setState(() {
                      //               isPlay = !isPlay;
                      //             });
                      //           },
                      //           icon: Icon(
                      //             isPlay ? Icons.pause : Icons.play_arrow,
                      //             color: MyColors.darkBrown,
                      //             size: 26.sp,
                      //           )),
                      //     ),
                      //   ),
                      // ),
                      // SizedBox(
                      //   width: AppVariables.appSize(context).width * 0.04,
                      // ),

                      SizedBox(
                        width: AppVariables.appSize(context).width * 0.7,
                        height: AppVariables.appSize(context).width * 0.17,
                        child: Container(
                          decoration: BoxDecoration(
                            color: MyColors.lightBrown,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: TextButton(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                //ArabicSuraNumber(i: i),
                                if (quraan.getPlaceOfRevelation(i + 1) ==
                                    "Madinah") ...[
                                  Image.asset(
                                    AssetsManager.masjedIcon,
                                    width: 30.sp,
                                  ),
                                ] else ...[
                                  Image.asset(
                                    AssetsManager.makaaIcon,
                                    width: 30.sp,
                                  ),
                                ],
                                const Spacer(),
                                Text(
                                  arabicName[i]['name'],
                                  style: GoogleFonts.notoNastaliqUrdu(
                                    fontSize: 19.3.sp,
                                    fontWeight: FontWeight.w600,
                                    color: MyColors.darkBrown,
                                  ),
                                  textDirection: TextDirection.rtl,
                                ),
                              ],
                            ),
                            onPressed: () {
                              fabIsClicked = false;
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SurahBuilder(
                                          arabic: quran[0],
                                          sura: i,
                                          suraName: arabicName[i]['name'],
                                          ayah: 0,
                                        )),
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      CircleAvatar(
                        backgroundColor: MyColors.darkBrown,
                        radius: 25.sp,
                        child: Text(
                          "${i + 1}",
                          style: GoogleFonts.noticiaText(
                            color: MyColors.whiteColor,
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
