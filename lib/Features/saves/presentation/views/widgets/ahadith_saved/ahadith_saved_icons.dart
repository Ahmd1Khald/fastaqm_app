import 'package:fastaqm_app/Features/saves/presentation/controller/saves_cubit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share/share.dart';

import '../../../../../../Core/constatnts/app_functions.dart';
import '../../../../../../Core/constatnts/colors.dart';
import '../../../../../../Core/constatnts/variables.dart';

class HadithSavesIconsButton extends StatelessWidget {
  const HadithSavesIconsButton({
    Key? key,
    required this.hadith,
    required this.description,
    required this.cubit,
    required this.number,
  }) : super(key: key);
  final String hadith;
  final String description;
  final int number;
  final SavesCubit cubit;

  void shareDuaa(String textToShare, {String subject = ''}) {
    Share.share(textToShare, subject: subject);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 55,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            backgroundColor: MyColors.lightBrown,
            radius: 35,
            child: MaterialButton(
              onPressed: () {
                AppFunctions.shareDuaa(hadith);
              },
              splashColor: MyColors.darkBrown,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
              child: const Center(
                child: Icon(
                  Icons.share,
                  color: MyColors.darkBrown,
                  size: 40,
                ),
              ),
            ),
          ),
          CircleAvatar(
            backgroundColor:
                cubit.selected1 ? MyColors.darkBrown : MyColors.lightBrown,
            radius: 35,
            child: MaterialButton(
              onPressed: () async {
                cubit.changeSelectedIcon(tt: 1);
                if (cubit.selected1 == true) {
                  return await showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          backgroundColor: MyColors.lightBrown,
                          content: SizedBox(
                            width: AppVariables.appSize(context).width * 0.8,
                            height: AppVariables.appSize(context).width * 0.9,
                            child: SingleChildScrollView(
                              child: Text(
                                description,
                                textDirection: TextDirection.rtl,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.noticiaText(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          title: Text(
                            ":شرح الحديث",
                            style: GoogleFonts.notoNastaliqUrdu(
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.end,
                          ),
                          alignment: AlignmentDirectional.center,
                          actions: [
                            MaterialButton(
                              onPressed: () {
                                Navigator.pop(context);
                                cubit.changeSelectedIcon(tt: 0);
                              },
                              splashColor: MyColors.lightBrown,
                              color: MyColors.creamColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              child: Text(
                                "الرجوع",
                                style: GoogleFonts.noticiaText(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        );
                      });
                }
              },
              splashColor: MyColors.darkBrown,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
              child: Center(
                child: Icon(
                  Icons.description,
                  color: cubit.selected1
                      ? MyColors.lightBrown
                      : MyColors.darkBrown,
                  size: 40,
                ),
              ),
            ),
          ),
          CircleAvatar(
            backgroundColor: cubit.ssInHadithSavedList(number: number)
                ? MyColors.darkBrown
                : MyColors.lightBrown,
            radius: 35,
            child: MaterialButton(
              onPressed: () {
                cubit.removedHadithFromList(number: number);
              },
              splashColor: MyColors.darkBrown,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
              child: Center(
                child: Icon(
                  Icons.favorite,
                  color: cubit.ssInHadithSavedList(number: number)
                      ? MyColors.lightBrown
                      : MyColors.darkBrown,
                  size: 40,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
