import 'package:fastaqm_app/Features/ahadith/data/model/hadith_model.dart';
import 'package:fastaqm_app/Features/ahadith/presentation/controller/ahadith_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../Core/constatnts/app_functions.dart';
import '../../../../../Core/constatnts/colors.dart';
import '../../../../../Core/constatnts/variables.dart';

class HadithIconsButton extends StatelessWidget {
  const HadithIconsButton({
    Key? key,
    required this.hadith,
    required this.description,
    required this.cubit,
    required this.number,
  }) : super(key: key);
  final String hadith;
  final String description;
  final int number;
  final AhadithCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 40,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            backgroundColor: MyColors.lightBrown,
            radius: 35.sp,
            child: MaterialButton(
              onPressed: () {
                AppFunctions.shareDuaa(hadith);
              },
              splashColor: MyColors.darkBrown,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
              child: Center(
                child: Icon(
                  Icons.share,
                  color: MyColors.darkBrown,
                  size: 35.sp,
                ),
              ),
            ),
          ),
          CircleAvatar(
            backgroundColor:
                cubit.selected1 ? MyColors.darkBrown : MyColors.lightBrown,
            radius: 35.sp,
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
                                  fontSize: 24.sp,
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
                  size: 35.sp,
                ),
              ),
            ),
          ),
          CircleAvatar(
            backgroundColor: cubit.ssInSavedList(number: number)
                ? MyColors.darkBrown
                : MyColors.lightBrown,
            radius: 35.sp,
            child: MaterialButton(
              onPressed: () {
                //cubit.changeSelectedIcon(tt: 2);
                cubit.saveToList(
                    model: HadithModel(
                  number: number,
                  hadith: hadith,
                  description: description,
                ));
              },
              splashColor: MyColors.darkBrown,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
              child: Center(
                child: Icon(
                  Icons.favorite,
                  color: cubit.ssInSavedList(number: number)
                      ? MyColors.lightBrown
                      : MyColors.darkBrown,
                  size: 35.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
