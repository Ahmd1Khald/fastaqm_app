import 'package:audioplayers/audioplayers.dart';
import 'package:fastaqm_app/Core/constatnts/colors.dart';
import 'package:fastaqm_app/Core/constatnts/variables.dart';
import 'package:fastaqm_app/Features/quran/presentation/views/widgets/surah_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran/quran.dart' as quraan;

import '../../../../Core/constatnts/app_functions.dart';
import '../../../../Core/constatnts/assets_manager.dart';
import '../../../../Core/constatnts/constant.dart';
import '../../../../Core/widgets/custom_SnackBar.dart';
import '../../../../Core/widgets/custom_loading.dart';
import '../../../saves/presentation/views/widgets/aya_saves/aya_empty_saves.dart';

class QuranScreen extends StatefulWidget {
  const QuranScreen({Key? key}) : super(key: key);

  @override
  State<QuranScreen> createState() => _QuranScreenState();
}

class _QuranScreenState extends State<QuranScreen> {
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
  int isDownload = 0;
  bool pause = false;
  bool replay = false;
  final play = AudioPlayer();
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  Future<void> playQuran({required String suraUrl}) async {
    pause = false;
    const CustomLoadingPage();
    try {
      replay = false;
      if (audioValue == null) {
        customSnackBar(context: context, title: 'اختر صوت القارئ أولا');
      } else {
        const CustomLoadingPage();
        await play.play(UrlSource(suraUrl)).then((value) {
          setState(() {});
        });

        play.onPlayerStateChanged.listen((PlayerState state) {
          if (state == PlayerState.completed) {
            // The audio has finished playing
            print('Audio has finished playing');

            setState(() {
              replay = true;
            });
          }
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
    List<DropdownMenuItem<String>>? menuItems =
        List<DropdownMenuItem<String>>.generate(
      AppVariables.mashaikhAudio.length,
      (index) {
        return DropdownMenuItem(
          value: AppVariables.mashaikhAudio[index],
          alignment: AlignmentDirectional.centerEnd,
          enabled: true,
          child: Text(
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.right,
            AppVariables.mashaikhAudio[index],
            style: TextStyle(
              color: MyColors.darkBrown,
              fontWeight: FontWeight.w700,
              fontSize: 17.sp,
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
        return "https://server10.mp3quran.net/minsh/$suraNum.mp3";
      case "الحصري - مجود":
        return "https://server13.mp3quran.net/husr/Almusshaf-Al-Mojawwad/$suraNum.mp3";
      case "الحصري - مرتل":
        return "https://server13.mp3quran.net/husr/Rewayat-Qalon-A-n-Nafi/$suraNum.mp3";
      case "عبدالباسط - مجود":
        return "https://server7.mp3quran.net/basit/Almusshaf-Al-Mojawwad/$suraNum.mp3";
      case "عبدالباسط - مرتل":
        return "https://server7.mp3quran.net/basit/$suraNum.mp3";
      case "البنا - مجود":
        return "https://server8.mp3quran.net/bna/Almusshaf-Al-Mojawwad/$suraNum.mp3";
      case "البنا - مرتل":
        return "https://server8.mp3quran.net/bna/$suraNum.mp3";
      case "مصطفى إسماعيل":
        return "https://server8.mp3quran.net/mustafa/Almusshaf-Al-Mojawwad/$suraNum.mp3";
      case "محمد جبريل":
        return "https://server8.mp3quran.net/jbrl/$suraNum.mp3";
      case "محمد أيوب":
        return "https://server16.mp3quran.net/ayyoub2/Rewayat-Hafs-A-n-Assem/$suraNum.mp3";
      case "مشاري راشد العفاسي":
        return "https://server8.mp3quran.net/afs/$suraNum.mp3";
      case "ماهر المعيقلي - مجود":
        return "https://server12.mp3quran.net/maher/Almusshaf-Al-Mojawwad/$suraNum.mp3";
      case "ماهر المعيقلي - مرتل":
        return "https://server12.mp3quran.net/maher/$suraNum.mp3";
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
      case "منصور السالمي":
        return "https://server14.mp3quran.net/mansor/$suraNum.mp3";
      case "حسن صالح":
        return "https://server16.mp3quran.net/h_saleh/Rewayat-Hafs-A-n-Assem/$suraNum.mp3";
      case "ياسر الدوسري":
        return "https://server11.mp3quran.net/yasser/$suraNum.mp3";
      default:
        return ""; // return an empty string or null for unknown reciters
    }
  }

  String formatTime(Duration position) {
    // Calculate hours, minutes, and seconds
    int hours = position.inHours;
    int minutes = (position.inMinutes % 60);
    int seconds = (position.inSeconds % 60);

    // Format the time as a string
    String formattedTime = hours > 0
        ? '$hours:${minutes < 10 ? '0$minutes' : '$minutes'}:${seconds < 10 ? '0$seconds' : '$seconds'}'
        : '$minutes:${seconds < 10 ? '0$seconds' : '$seconds'}';

    return formattedTime;
  }

  String? audioValue;
  bool loadingDownload = false;

  @override
  void initState() {
    play.onDurationChanged.listen((event) {
      setState(() {
        duration = event;
      });
    });

    play.onPositionChanged.listen((event) {
      setState(() {
        position = event;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    play.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //mansour alsalmy
    //https://server14.mp3quran.net/mansor/001.mp3

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
    //
    // العفاسي
    //https://server8.mp3quran.net/afs/001.mp3
    //
    // محمد جبريل
    //https://server8.mp3quran.net/jbrl/001.mp3

    return SafeArea(
      child: Column(
        children: [
          Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              Container(
                height: AppVariables.appSize(context).width * 0.12,
                decoration: BoxDecoration(
                  color: MyColors.lightBrown,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: DropdownButton<String>(
                  hint: Text(
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.right,
                    audioValue ?? "اختار صوت القارئ",
                    style: TextStyle(
                        color: MyColors.darkBrown,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700),
                  ),
                  borderRadius: BorderRadius.circular(10),
                  dropdownColor: MyColors.creamColor,
                  // style: TextStyle(
                  //   fontSize: 14,
                  // ),
                  // padding: const EdgeInsets.only(left: 4, right: 4),
                  isExpanded: false,
                  icon: SizedBox(
                    width: 60.w,
                    child: Icon(
                      Icons.radio_outlined,
                      size: 27.sp,
                    ),
                  ),
                  autofocus: true,
                  elevation: 0,
                  underline: Container(),
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
              itemBuilder: (context, i) => Padding(
                padding: EdgeInsets.only(bottom: i == 113 ? 50.0 : 0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: AppVariables.appSize(context).width * 0.55,
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
                                  if (replay) {
                                    playQuran(
                                        suraUrl: getAudioUrl(
                                            audioValue: audioValue ?? "",
                                            sura: i + 1));
                                  } else if (pause) {
                                    pauseQuran();
                                  } else {
                                    resumeQuran();
                                  }
                                  setState(() {});
                                } else {
                                  isPlay = i + 1;
                                  pause = false;
                                  replay = false;
                                  playQuran(
                                      suraUrl: getAudioUrl(
                                          audioValue: audioValue ?? "",
                                          sura: i + 1));
                                  setState(() {});
                                }
                              } else {
                                playQuran(suraUrl: "");
                              }
                            },
                            child: Icon(
                              isPlay == i + 1 && replay
                                  ? Icons.replay
                                  : !pause && isPlay == i + 1
                                      ? Icons.pause
                                      : Icons.play_arrow,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 7.w,
                        ),
//download sura
                        CircleAvatar(
                          backgroundColor: MyColors.darkBrown,
                          radius: 25.sp,
                          child: InkWell(
                            onTap: () {
                              bool clicked = false;
//You can download a single file
                              if (audioValue != null) {
                                print(getAudioUrl(
                                    audioValue: audioValue ?? "", sura: i + 1));
                                FileDownloader.downloadFile(
                                    url: getAudioUrl(
                                        audioValue: audioValue ?? "",
                                        sura: i + 1),
                                    name:
                                        "فاستقم - ${arabicName[i]['name']}", //(optional)
                                    onProgress:
                                        (String? fileName, double? progress) {
                                      isDownload = i + 1;
                                      setState(() {
                                        loadingDownload = true;
                                      });
                                      print(
                                          'FILE fileName HAS PROGRESS $progress');
                                    },
                                    onDownloadCompleted: (String path) {
                                      setState(() {
                                        loadingDownload = false;
                                      });
                                      customSnackBar(
                                          context: context,
                                          title: 'تم التحميل بنجاح');
                                    },
                                    onDownloadError: (String error) {
                                      setState(() {
                                        loadingDownload = false;
                                      });
                                      customSnackBar(
                                          context: context,
                                          title: 'تأكد من اتصالك بالانترنيت');
                                    });
                              } else {
                                customSnackBar(
                                    context: context,
                                    title: 'اختر صوت القارئ أولا');
                              }
                            },
                            child: loadingDownload && isDownload == i + 1
                                ? const CircularProgressIndicator(
                                    color: MyColors.lightBrown,
                                  )
                                : const Icon(
                                    Icons.download,
                                    color: Colors.white,
                                  ),
                          ),
                        ),
                      ],
                    ),
                    if (isPlay == i + 1) ...[
                      SizedBox(
                        width: double.infinity,
                        height: AppVariables.appSize(context).width * 0.15,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(formatTime(position)),
                            Slider(
                              min: 0,
                              max: duration.inSeconds.toDouble(),
                              value: position.inSeconds.toDouble(),
                              activeColor: MyColors.darkBrown,
                              onChanged: (double value) async {
                                final position =
                                    Duration(seconds: value.toInt());
                                await play.seek(position);
                              },
                            ),
                            Text(formatTime(duration)),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              separatorBuilder: (context, index) => SizedBox(height: 12.h),
              itemCount: 114,
            ),
          ),
        ],
      ),
    );
  }
}
