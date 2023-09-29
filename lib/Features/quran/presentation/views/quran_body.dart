import 'package:fastaqm_app/Core/constatnts/app_functions.dart';
import 'package:fastaqm_app/Core/constatnts/assets_manager.dart';
import 'package:fastaqm_app/Core/constatnts/colors.dart';
import 'package:fastaqm_app/Features/quran/presentation/views/widgets/drawer_body.dart';
import 'package:fastaqm_app/Features/quran/presentation/views/widgets/quran_image_widget.dart';
import 'package:fastaqm_app/Features/quran/presentation/views/widgets/sura_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran/quran.dart' as quran;

class QuranScreen extends StatelessWidget {
  const QuranScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("quraaaaaaaaaaaaaaaaaaaaaan");
    return Scaffold(
      appBar: AppBar(
        //automaticallyImplyLeading: false,
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
      drawer: const DrawerBody(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const QuranImage(),
            const SizedBox(
              height: 10,
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => BuildSuraContainer(
                context: context,
                index: index,
              ),
              itemCount: 114,
            ),
          ],
        ),
      ),
    );
  }
}

class BuildSuraContainer extends StatelessWidget {
  const BuildSuraContainer(
      {Key? key, required this.context, required this.index})
      : super(key: key);

  final BuildContext context;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      child: MaterialButton(
        color: MyColors.lightBrown,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        splashColor: MyColors.darkBrown,
        onPressed: () {
          //cubit.surapages = quran.getSurahPages(index + 1);
          AppFunctions.pushTo(
              context: context,
              screen: SuraWidget(
                suraPages: quran.getSurahPages(index + 1),
              ));
          //print(quran.getSurahPages(index + 1));
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                "صفحة  ${quran.getSurahPages(index + 1).length}",
                style: GoogleFonts.noticiaText(
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: MyColors.darkBrown,
                  ),
                ),
              ),
            ),
            const Spacer(),
            Text(
              "سورة  ${quran.getSurahNameArabic(index + 1)}",
              style: GoogleFonts.notoNastaliqUrdu(
                textStyle: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                  color: MyColors.darkBrown,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            if (quran.getPlaceOfRevelation(index + 1) == "Madinah") ...[
              Image.asset(
                AssetsManager.masjedIcon,
                width: 25,
              ),
            ] else ...[
              Image.asset(
                AssetsManager.makaaIcon,
                width: 25,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
