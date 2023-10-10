import 'package:audioplayers/audioplayers.dart';
import 'package:fastaqm_app/Core/constatnts/colors.dart';
import 'package:fastaqm_app/Core/constatnts/variables.dart';
import 'package:flutter/material.dart';
import 'package:quran/quran.dart' as quran;

class SuraWidget extends StatelessWidget {
  const SuraWidget({super.key, required this.suraPages});
  final List<int> suraPages;

  List<Widget> retPage(context) {
    final List<Widget> pages = [];
    for (int i = suraPages[0]; i <= 604; i++) {
      pages.add(Image.asset(
        "assets/quran_images/$i.png",
        height: AppVariables.appSize(context).height,
        fit: BoxFit.fill,
      ));
    }
    return pages;
  }

  Future<void> playQuran() async {
    final play = AudioPlayer();
    await play.play(UrlSource(quran.getAudioURLByVerseNumber(10)));
  }

  @override
  Widget build(BuildContext context) {
    print(suraPages);
    print(quran.getAudioURLByVerseNumber(10));

    return Scaffold(
      backgroundColor: MyColors.whiteColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: InkWell(
            onTap: () {
              playQuran();
            },
            child: PageView(
              scrollDirection: Axis.horizontal,
              reverse: true,
              children: retPage(context),
            ),
          ),
        ),
      ),
    );
  }
}
