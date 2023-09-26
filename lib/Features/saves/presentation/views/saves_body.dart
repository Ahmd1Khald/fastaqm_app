import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../Core/constatnts/colors.dart';
import '../../../../Core/constatnts/variables.dart';

class SavesScreen extends StatelessWidget {
  const SavesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomBuildItem(
          text: "قرأن",
          fnc: () {},
        ),
        CustomBuildItem(
          text: "أحاديث",
          fnc: () {},
        ),
        CustomBuildItem(
          text: "أذكار",
          fnc: () {},
        ),
      ],
    );
  }
}

class CustomBuildItem extends StatelessWidget {
  const CustomBuildItem({Key? key, required this.fnc, required this.text})
      : super(key: key);

  final VoidCallback fnc;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: MyColors.darkBrown,
            radius: 39,
            child: MaterialButton(
              onPressed: fnc,
              elevation: 5,
              //height: AppVariables.appSize(context).width * 0.1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(45),
              ),
              color: MyColors.darkBrown,
              splashColor: MyColors.lightBrown,
              child: Center(
                child: Icon(
                  Icons.keyboard_arrow_left,
                  size: 50,
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
              ),
            ),
          ),
          SizedBox(
            width: AppVariables.appSize(context).width * 0.06,
          ),
          Container(
            width: AppVariables.appSize(context).width * 0.555,
            height: AppVariables.appSize(context).width * 0.172,
            decoration: BoxDecoration(
                color: MyColors.darkBrown,
                borderRadius: BorderRadius.circular(30)),
            child: Center(
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: GoogleFonts.notoNastaliqUrdu(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 24,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
