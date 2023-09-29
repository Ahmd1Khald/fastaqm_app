import 'package:fastaqm_app/Core/constatnts/colors.dart';
import 'package:fastaqm_app/Features/quran/presentation/views/widgets/ajzaa_body.dart';
import 'package:fastaqm_app/Features/quran/presentation/views/widgets/suwarBody.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuranScreen extends StatelessWidget {
  const QuranScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("quraaaaaaaaaaaaaaaaaaaaaan");
    return DefaultTabController(
      length: 2,
      child: Scaffold(
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
          bottom: TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: [
              Tab(
                child: Text(
                  "الأجزاء",
                  style: GoogleFonts.noticiaText(
                    color: MyColors.darkBrown,
                    fontSize: 24,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  "السور",
                  style: GoogleFonts.noticiaText(
                    color: MyColors.darkBrown,
                    fontSize: 24,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            AjzaaBody(),
            SuwuerBody(),
          ],
        ),
      ),
    );
  }
}
