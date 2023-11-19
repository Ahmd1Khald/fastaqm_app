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
    pause = false;
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
      (index) {
        return DropdownMenuItem(
          value: AppVariables.mashaikhAudio[index],
          child: Text(
            AppVariables.mashaikhAudio[index],
            style: const TextStyle(
              color: MyColors.darkBrown,
              fontWeight: FontWeight.w700,
              fontSize: 17,
            ),
          ),
        );
      },
    );
    return menuItems;
  }

  String getAudioUrl({required String audioValue, required int sura}) {
    String suraNum = sura.toString();
    if (sura < 10) {
      suraNum = "00$sura";
    } else if (sura > 10 && sura < 100) {
      suraNum = "0$sura";
    } else {
      suraNum = "$sura";
    }
    switch (audioValue) {
      case "المنشاوي - مجود":
        return "https://server10.mp3quran.net/minsh/Almusshaf-Al-Mojawwad/$suraNum.mp3";
      case "المنشاوي - مرتل":
        return "https://server10.mp3quran.net/minsh/001.mp3";
      case "الحصري - مجود":
        return "https://server13.mp3quran.net/husr/Almusshaf-Al-Mojawwad/$suraNum.mp3";
      case "الحصري - مرتل":
        return "https://server13.mp3quran.net/husr/Rewayat-Qalon-A-n-Nafi/$suraNum.mp3";
      case "عبدالباسط - مجود":
        return "https://server7.mp3quran.net/basit/Almusshaf-Al-Mojawwad/$suraNum.mp3";
      case "عبدالباسط - مرتل":
        return "https://server7.mp3quran.net/basit/$suraNum.mp3";
      case "البنى - مجود":
        return "https://server8.mp3quran.net/bna/Almusshaf-Al-Mojawwad/$suraNum.mp3";
      case "البنى - مرتل":
        return "https://server8.mp3quran.net/bna/$suraNum.mp3";
      case "مصطفى اسماعيل":
        return "https://server8.mp3quran.net/mustafa/Almusshaf-Al-Mojawwad/$suraNum.mp3";
      case "محمد ايوب":
        return "https://server16.mp3quran.net/ayyoub2/Rewayat-Hafs-A-n-Assem/$suraNum.mp3";
      case "ماهر المعيقلي":
        return "https://server12.mp3quran.net/maher/Almusshaf-Al-Mojawwad/$suraNum.mp3";
      case "سعود الشريم":
        return "https://server7.mp3quran.net/shur/$suraNum.mp3";
      case "ناصر القطامي":
        return "https://server6.mp3quran.net/qtm/$suraNum.mp3";
      case "سعد الغامدي":
        return "https://server7.mp3quran.net/s_gmd/$suraNum.mp3";
      case "عبد الرحمن السديس":
        return "https://server11.mp3quran.net/sds/$suraNum.mp3";
      case "صلاح بو خاطر":
        return "https://server8.mp3quran.net/bu_khtr/$suraNum.mp3";
      case "عبدالرشيد صوفي":
        return "https://server16.mp3quran.net/soufi/Rewayat-Hafs-A-n-Assem/$suraNum.mp3";
      case "علي بن عبدالرحمن الحذيفي":
        return "https://server9.mp3quran.net/hthfi/Rewayat-Sho-bah-A-n-Asim/$suraNum.mp3";
      case "علي جابر":
        return "https://server11.mp3quran.net/a_jbr/$suraNum.mp3";
      case "فارس عباد":
        return "https://server8.mp3quran.net/frs_a/$suraNum.mp3";
      default:
        return ""; // return an empty string or null for unknown reciters
    }
  }

  String? audioValue;

  @override
  void dispose() {
    play.release();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //salah bo khater
    //https://server8.mp3quran.net/bu_khtr/001.mp3

    //sudise
    //https://server11.mp3quran.net/sds/001.mp3

    //sad elghamdy
    //https://server7.mp3quran.net/s_gmd/001.mp3

    //naser katald
    //https://server6.mp3quran.net/qtm/001.mp3

    //shuram
    //https://server7.mp3quran.net/shur/001.mp3

    //maher
    //https://server12.mp3quran.net/maher/Almusshaf-Al-Mojawwad/001.mp3

    //ayoub
    //https://server16.mp3quran.net/ayyoub2/Rewayat-Hafs-A-n-Assem/001.mp3

    //mustafa ismail
    //https://server8.mp3quran.net/mustafa/Almusshaf-Al-Mojawwad/001.mp3

    //banna
    //https://server8.mp3quran.net/bna/001.mp3
    //https://server8.mp3quran.net/bna/Almusshaf-Al-Mojawwad/001.mp3

    //abdl baset
    //https://server7.mp3quran.net/basit/Almusshaf-Al-Mojawwad/001.mp3
    //https://server7.mp3quran.net/basit/001.mp3

    //husary
    //https://server13.mp3quran.net/husr/Rewayat-Qalon-A-n-Nafi/001.mp3
    //https://server13.mp3quran.net/husr/Almusshaf-Al-Mojawwad/001.mp3

    //minshawy
    //https://server10.mp3quran.net/minsh/001.mp3
    //https://server10.mp3quran.net/minsh/Almusshaf-Al-Mojawwad/001.mp3

    //mohamed refaat
    //https:server14.mp3quran.net/refat/002.mp3

    //عبدالرشيد صوفي
    //https:server16.mp3quran.net/soufi/Rewayat-Hafs-A-n-Assem/001.mp3

    //علي بن عبدالرحمن الحذيفي
    //https:server9.mp3quran.net/hthfi/Rewayat-Sho-bah-A-n-Asim/001.mp3

    //علي جابر
    //https:server11.mp3quran.net/a_jbr/

    //فارس عباد
    //https:server8.mp3quran.net/frs_a/001.mp3

    return SafeArea(
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
                  // padding: const EdgeInsets.only(left: 4, right: 4),
                  isExpanded: false,
                  autofocus: true,
                  alignment: AlignmentDirectional.center,
                  iconEnabledColor: MyColors.darkBrown,
                  iconDisabledColor: MyColors.darkBrown,
                  value: audioValue,
                  items: audioDropDownList,
                  onChanged: (String? value) {
                    setState(() {
                      isPlay = 0;
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
            height: 15.h,
          ),
          Expanded(
            child: ListView.separated(
              //shrinkWrap: true,
              //physics: const NeverScrollableScrollPhysics(),
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
                              playQuran(
                                  suraUrl: getAudioUrl(
                                      audioValue: audioValue ?? "",
                                      sura: i + 1));
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
          ),
          SizedBox(
            height: 10.h,
          ),
        ],
      ),
    );
  }
}
