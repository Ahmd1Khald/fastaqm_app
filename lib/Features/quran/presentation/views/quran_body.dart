import 'package:fastaqm_app/Core/constatnts/colors.dart';
import 'package:fastaqm_app/Features/quran/presentation/views/widgets/surah_builder.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran/quran.dart' as quraan;

import '../../../../Core/constatnts/arabic_sura_number.dart';
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
      appBar: AppBar(
        backgroundColor: MyColors.lightBrown,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_forward,
                size: 32,
                color: MyColors.darkBrown,
              )),
        ],
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
              return indexCreator(snapshot.data, context);
            } else {
              return const Text('Empty data');
            }
          } else {
            return Text('State: ${snapshot.connectionState}');
          }
        },
      ),
    );
  }
}

// DefaultTabController(
// length: 2,
// child: Scaffold(
// backgroundColor: Theme.of(context).scaffoldBackgroundColor,
// appBar: AppBar(
// backgroundColor: MyColors.lightBrown,
// automaticallyImplyLeading: false,
// actions: [
// IconButton(
// onPressed: () {
// Navigator.pop(context);
// },
// icon: const Icon(
// Icons.arrow_forward,
// size: 32,
// color: MyColors.darkBrown,
// )),
// ],
// bottom: TabBar(
// indicatorSize: TabBarIndicatorSize.tab,
// tabs: [
// Tab(
// child: Text(
// "السور",
// style: GoogleFonts.noticiaText(
// color: MyColors.darkBrown,
// fontSize: 24,
// ),
// ),
// ),
// Tab(
// child: Text(
// "الأجزاء",
// style: GoogleFonts.noticiaText(
// color: MyColors.darkBrown,
// fontSize: 24,
// ),
// ),
// ),
// ],
// ),
// ),
// body: TabBarView(
// children: [
// FutureBuilder(
// future: readJson(),
// builder: (
// BuildContext context,
// AsyncSnapshot snapshot,
// ) {
// if (snapshot.connectionState == ConnectionState.waiting) {
// return const CustomLoadingPage();
// } else if (snapshot.connectionState == ConnectionState.done) {
// if (snapshot.hasError) {
// return const Text('حدث خطئ ما');
// } else if (snapshot.hasData) {
// return indexCreator(snapshot.data, context);
// } else {
// return const Text('Empty data');
// }
// } else {
// return Text('State: ${snapshot.connectionState}');
// }
// },
// ),
// const AjzaaBody(),
// ],
// ),
// ),
// );

Container indexCreator(quran, context) {
  return Container(
    color: const Color.fromARGB(255, 221, 250, 236),
    child: ListView(
      children: [
        for (int i = 0; i < 114; i++)
          Container(
            color: i % 2 == 0
                ? const Color.fromARGB(255, 253, 247, 230)
                : const Color.fromARGB(255, 253, 251, 240),
            child: TextButton(
              child: Row(
                children: [
                  ArabicSuraNumber(i: i),
                  const SizedBox(
                    width: 5,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [],
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  Text(
                    arabicName[i]['name'],
                    style: GoogleFonts.notoNastaliqUrdu(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: MyColors.darkBrown,
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  if (quraan.getPlaceOfRevelation(i + 1) == "Madinah") ...[
                    Image.asset(
                      AssetsManager.masjedIcon,
                      width: 26,
                    ),
                  ] else ...[
                    Image.asset(
                      AssetsManager.makaaIcon,
                      width: 26,
                    ),
                  ],
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
      ],
    ),
  );
}
