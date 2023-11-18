import 'package:audioplayers/audioplayers.dart';
import 'package:fastaqm_app/Core/constatnts/colors.dart';
import 'package:fastaqm_app/Core/constatnts/variables.dart';
import 'package:fastaqm_app/Features/quran/presentation/views/widgets/surah_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran/quran.dart' as quraan;

import '../../../../Core/constatnts/app_functions.dart';
import '../../../../Core/constatnts/assets_manager.dart';
import '../../../../Core/constatnts/constant.dart';
import '../../../../Core/widgets/custom_SnackBar.dart';
import '../../../../Core/widgets/custom_loading.dart';
import '../../../saves/presentation/views/widgets/aya_saves/aya_empty_saves.dart';

class QuranScreen extends StatelessWidget {
  QuranScreen({Key? key}) : super(key: key);

  //https://server7.mp3quran.net/s_gmd/001.mp3
  //https://server7.mp3quran.net/shur/001.mp3
  //https://server8.mp3quran.net/bu_khtr/001.mp3
  //https://server7.mp3quran.net/basit/Almusshaf-Al-Mojawwad/001.mp3
  //https://server7.mp3quran.net/basit/001.mp3
  //https://server11.mp3quran.net/sds/001.mp3
  //https://server6.mp3quran.net/qtm/001.mp3
  //https://server12.mp3quran.net/maher/Almusshaf-Al-Mojawwad/001.mp3
  //https://server16.mp3quran.net/ayyoub2/Rewayat-Hafs-A-n-Assem/001.mp3
  //https://server8.mp3quran.net/mustafa/Almusshaf-Al-Mojawwad/001.mp3
  //https://server8.mp3quran.net/bna/001.mp3
  //https://server8.mp3quran.net/bna/Almusshaf-Al-Mojawwad/001.mp3
  //https://server13.mp3quran.net/husr/Almusshaf-Al-Mojawwad/001.mp3
  //https://server13.mp3quran.net/husr/Rewayat-Qalon-A-n-Nafi/002.mp3
  //https://server10.mp3quran.net/minsh/Almusshaf-Al-Mojawwad/002.mp3

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
          } else {
            AppFunctions.pushTo(
                context: context, screen: const AyaEmptyWidget());
          }
        },
        child: const Icon(
          Icons.bookmark,
          color: MyColors.darkBrown,
        ),
      ),
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
  int isPlay = 0;
  bool pause = false;
  final play = AudioPlayer();
  Future<void> playQuran({required String suraUrl}) async {
    const CustomLoadingPage();
    try {
      if (audioValue == null) {
        customSnackBar(context: context, title: 'اختر صوت القارئ أولا');
      } else {
        const CustomLoadingPage();
        await play.play(UrlSource(suraUrl)).then((value) {
          setState(() {});
        });
      }
    } catch (error) {
      customSnackBar(context: context, title: 'تأكد من اتصالك بالانترنيت');
    }
  }

  Future<void> pauseQuran(/*{required int sura}*/) async {
    await play.pause();
    setState(() {});
  }

  Future<void> resumeQuran(/*{required int sura}*/) async {
    await play.resume();
    setState(() {});
  }

  List<DropdownMenuItem<String>>? get audioDropDownList {
    print(AppVariables.mashaikhAudio);
    List<DropdownMenuItem<String>>? menuItems =
        List<DropdownMenuItem<String>>.generate(
      AppVariables.mashaikhAudio.length,
      (index) => DropdownMenuItem(
        value: AppVariables.mashaikhAudio[index],
        child: Text(
          AppVariables.mashaikhAudio[index],
          style: const TextStyle(
            color: MyColors.darkBrown,
            fontWeight: FontWeight.w700,
            fontSize: 17,
          ),
        ),
      ),
    );
    return menuItems;
  }

  String? audioValue;

  @override
  Widget build(BuildContext context) {
    //playQuran();
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                Container(
                  height: AppVariables.appSize(context).width * 0.12,
                  decoration: BoxDecoration(
                    color: MyColors.lightBrown,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: DropdownButton<String>(
                    hint: Text(
                      audioValue ?? "اختار صوت القارئ",
                      style: const TextStyle(
                          color: MyColors.darkBrown,
                          fontSize: 17,
                          fontWeight: FontWeight.w700),
                    ),
                    borderRadius: BorderRadius.circular(10),
                    dropdownColor: MyColors.creamColor,
                    // style: TextStyle(
                    //   fontSize: 14,
                    // ),
                    padding: const EdgeInsets.only(left: 4, right: 4),
                    isExpanded: false,
                    autofocus: true,
                    iconEnabledColor: MyColors.darkBrown,
                    iconDisabledColor: MyColors.darkBrown,
                    value: audioValue,
                    items: audioDropDownList,
                    onChanged: (String? value) {
                      setState(() {
                        audioValue = value;
                      });
                    },
                  ),
                ),
                const Spacer(),
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_forward,
                      size: 32,
                      color: MyColors.darkBrown,
                    ))
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Container(
                width: AppVariables.appSize(context).width * 0.8,
                height: AppVariables.appSize(context).width * 0.15,
                decoration: BoxDecoration(
                  color: MyColors.darkBrown,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: Text(
                    'القرآن الكريم',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.noticiaText(
                      color: MyColors.whiteColor,
                      fontSize: 28.sp,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 25.h,
            ),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, i) => Padding(
                padding: EdgeInsets.only(bottom: i == 113 ? 50.0 : 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
                                style: GoogleFonts.noticiaText(
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.w600,
                                  color: MyColors.darkBrown,
                                ),
                                textDirection: TextDirection.rtl,
                              ),
                            ],
                          ),
                          onPressed: () {
                            fabIsClicked = false;
                            //playQuran(sura: 114);
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
                    // CircleAvatar(
                    // backgroundColor: MyColors.darkBrown,
                    // radius: 25.sp,
                    // child: Text(
                    // AppFunctions.convertEnglishNumberToArabic(
                    //   (i + 1).toString()),
                    // style: GoogleFonts.noticiaText(
                    // color: MyColors.whiteColor,
                    // fontSize: 22.sp,
                    // fontWeight: FontWeight.w500,
                    // ),
                    // ),
                    // ),

                    CircleAvatar(
                      backgroundColor: MyColors.darkBrown,
                      radius: 25.sp,
                      child: InkWell(
                        onTap: () {
                          if (audioValue != null) {
                            if (isPlay == i + 1) {
                              pause = !pause;
                              if (pause) {
                                pauseQuran();
                              } else {
                                resumeQuran();
                              }
                            } else {
                              isPlay = i + 1;
                              pause = false;
                              playQuran(suraUrl: "");
                            }
                            setState(() {});
                          } else {
                            playQuran(suraUrl: "");
                          }
                        },
                        child: Icon(
                          isPlay == i + 1 && !pause
                              ? Icons.pause
                              : Icons.play_arrow,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              separatorBuilder: (context, index) => SizedBox(
                height: 10.h,
              ),
              itemCount: 114,
            ),
            SizedBox(
              height: 10.h,
            ),
          ],
        ),
      ),
    );
  }
}
