import 'package:audioplayers/audioplayers.dart';
import 'package:fastaqm_app/Core/constatnts/colors.dart';
import 'package:fastaqm_app/Core/constatnts/variables.dart';
import 'package:fastaqm_app/Core/helpers/cachehelper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran/quran.dart' as quraan;
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../../../Core/constatnts/constant.dart';

class SurahBuilder extends StatefulWidget {
  final sura;
  final arabic;
  final suraName;
  int ayah;

  SurahBuilder(
      {Key? key, this.sura, this.arabic, this.suraName, required this.ayah})
      : super(key: key);

  @override
  _SurahBuilderState createState() => _SurahBuilderState();
}

class _SurahBuilderState extends State<SurahBuilder> {
  bool view = true;
  final play = AudioPlayer();
  bool showSlider = false;
  int playedAya = -1;
  double sliderValue = CacheHelper.getDate(key: "sliderValue") ?? 20;
  //double quranFontSize = CacheHelper.getDate(key: "quranFontSize") ?? 18;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => jumbToAyah());
    super.initState();
  }

  jumbToAyah() {
    if (fabIsClicked) {
      itemScrollController.scrollTo(
          index: widget.ayah,
          duration: const Duration(seconds: 2),
          curve: Curves.easeInOutCubic);
    }
    fabIsClicked = false;
  }

  Row verseBuilder(int index, previousVerses) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                widget.arabic[index + previousVerses]['aya_text'],
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontSize: sliderValue,
                  fontFamily: arabicFont,
                  color: playedAya == index + 1
                      ? MyColors.babyBrown
                      : const Color.fromARGB(196, 0, 0, 0),
                ),
              ),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [],
              ),
            ],
          ),
        ),
      ],
    );
  }

  SafeArea singleSuraBuilder(lengthOfSura) {
    Future<void> playQuran({required int aya, required int sura}) async {
      await play.play(UrlSource(quraan.getAudioURLByVerse(sura, aya)));
      setState(() {
        playedAya = aya;
      });
      //play.onPlayerComplete;
      print(play.volume);
    }

    String fullSura = '';
    int previousVerses = 0;
    if (widget.sura + 1 != 1) {
      for (int i = widget.sura - 1; i >= 0; i--) {
        previousVerses = previousVerses + noOfVerses[i];
      }
    }

    if (!view)
      for (int i = 0; i < lengthOfSura; i++) {
        fullSura += (widget.arabic[i + previousVerses]['aya_text']);
      }

    return SafeArea(
      child: Container(
        color: const Color.fromARGB(255, 253, 251, 240),
        child: view
            ? ScrollablePositionedList.builder(
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      (index != 0) || (widget.sura == 0) || (widget.sura == 8)
                          ? const Text('')
                          : const RetunBasmala(),
                      Container(
                        color: index % 2 != 0
                            ? const Color.fromARGB(255, 253, 251, 240)
                            : const Color.fromARGB(255, 253, 247, 230),
                        child: PopupMenuButton(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: verseBuilder(index, previousVerses),
                            ),
                            itemBuilder: (context) => [
                                  PopupMenuItem(
                                    onTap: () {
                                      saveBookMark(widget.sura + 1, index);
                                    },
                                    child: const Row(
                                      children: [
                                        Icon(
                                          Icons.bookmark_add,
                                          color: MyColors.darkBrown,
                                          //Color.fromARGB(255, 56, 115, 59),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text('حفظ'),
                                      ],
                                    ),
                                  ),
                                  PopupMenuItem(
                                    onTap: () {
                                      playQuran(
                                          aya: index + 1,
                                          sura: widget.sura + 1);
                                    },
                                    child: const Row(
                                      //mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Icon(
                                          Icons.play_arrow,
                                          color: MyColors.darkBrown,
                                          //Color.fromARGB(255, 56, 115, 59),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text('سماع للآية'),
                                      ],
                                    ),
                                  ),
                                ]),
                      ),
                    ],
                  );
                },
                itemScrollController: itemScrollController,
                itemPositionsListener: itemPositionsListener,
                itemCount: lengthOfSura,
              )
            : ListView(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            widget.sura + 1 != 1 && widget.sura + 1 != 9
                                ? const RetunBasmala()
                                : const Text(''),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Text(
                                fullSura, //mushaf mode
                                textDirection: TextDirection.rtl,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 10, //sliderValue,
                                  fontFamily: arabicFont,
                                  color: const Color.fromARGB(196, 44, 44, 44),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int LengthOfSura = noOfVerses[widget.sura];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //theme: AppTheme.lightTheme(),
      home: Scaffold(
        bottomNavigationBar: showSlider
            ? Container(
                height: AppVariables.appSize(context).width * 0.15,
                width: AppVariables.appSize(context).width,
                color: Colors.white.withOpacity(0.4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 4,
                      child: Slider(
                        value: sliderValue,
                        onChanged: (value) {
                          setState(() {
                            sliderValue = value;
                            // quranFontSize = value;
                            print(sliderValue);
                          });
                          CacheHelper.saveData(
                              key: 'sliderValue', value: sliderValue);
                        },
                        min: 15,
                        max: 34,
                        activeColor: MyColors.darkBrown,
                        inactiveColor: MyColors.lightBrown,
                        divisions: 8,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: CloseButton(
                        onPressed: () {
                          setState(() {
                            showSlider = false;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              )
            : Container(
                color: Colors.white,
                height: 1,
                width: AppVariables.appSize(context).width,
              ),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () {
                  play.pause();
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_forward,
                  size: 32,
                  color: MyColors.whiteColor,
                )),
          ],
          leading: IconButton(
              onPressed: () {
                setState(() {
                  showSlider = !showSlider;
                });
              },
              icon: const Icon(
                Icons.settings,
              )),
          centerTitle: true,
          title: Text(
            // widget.
            "سورة ${widget.suraName}",
            textAlign: TextAlign.center,
            style: GoogleFonts.noticiaText(
              fontSize: 32,
              fontWeight: FontWeight.w600,
              color: MyColors.whiteColor,
            ),
          ),
          backgroundColor: MyColors.darkBrown,
        ),
        body: singleSuraBuilder(LengthOfSura),
      ),
    );
  }
}

class RetunBasmala extends StatelessWidget {
  const RetunBasmala({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Center(
        child: Text(
          quraan.basmala,
          style: TextStyle(
              fontFamily: 'me_quran',
              fontSize: CacheHelper.getDate(key: 'sliderValue') ?? 30),
          textDirection: TextDirection.rtl,
        ),
      ),
    ]);
  }
}
