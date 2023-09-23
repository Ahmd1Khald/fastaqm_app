import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../Core/constatnts/colors.dart';
import '../../../../../Core/constatnts/variables.dart';
import '../../controller/azkar_cubit.dart';

class CountZikerWidget extends StatelessWidget {
  const CountZikerWidget({Key? key, required this.num}) : super(key: key);

  final String num;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AzkarCubit, AzkarState>(
      listener: (context, state) {},
      builder: (context, state) {
        AzkarCubit cubit = AzkarCubit.get(context);
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                Container(
                  width: AppVariables.appSize(context).width * 0.17,
                  height: AppVariables.appSize(context).width * 0.17,
                  decoration: const BoxDecoration(
                    color: MyColors.lightBrown,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      "${cubit.counterValue.toInt()}",
                      style: const TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.w700,
                        color: MyColors.darkBrown,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: AppVariables.appSize(context).width * 0.18,
                  height: AppVariables.appSize(context).width * 0.18,
                  child: CircularProgressIndicator(
                    strokeWidth: 8,
                    value: cubit.counterIndicator,
                    color: MyColors.darkBrown,
                    backgroundColor: MyColors.whiteColor,
                  ),
                ),
              ],
            ),
            SizedBox(
              width: AppVariables.appSize(context).width * 0.1,
            ),
            SizedBox(
              width: AppVariables.appSize(context).width * 0.35,
              child: MaterialButton(
                onPressed: () {
                  if (cubit.counterValue == int.parse(num == "" ? "1" : num)) {
                    cubit.incIndex(tt: AppVariables.azkarSelected);
                  } else {
                    cubit.incCounter(num);
                  }
                },
                height: AppVariables.appSize(context).width * 0.14,
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                color: MyColors.darkBrown,
                splashColor: MyColors.lightBrown,
                child: Center(
                  child: Text(
                    textAlign: TextAlign.center,
                    num == ""
                        ? "مرة واحدة"
                        : num == "2"
                            ? "مرتان"
                            : num == "3"
                                ? "ثلاث مرات"
                                : num == "4"
                                    ? "اربع مرات"
                                    : num == "7"
                                        ? "سبع مرات"
                                        : num == "10"
                                            ? "عشر مرات"
                                            : num == "100"
                                                ? "مائة مرة"
                                                : "مرة واحدة",
                    style: GoogleFonts.notoNastaliqUrdu(
                      color: MyColors.whiteColor,
                      fontSize: 21,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
