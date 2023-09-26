import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share/share.dart';

import '../../../../../Core/constatnts/colors.dart';
import '../../../../../Core/constatnts/variables.dart';

class HadithIconsButton extends StatefulWidget {
  const HadithIconsButton(
      {Key? key, required this.text, required this.description})
      : super(key: key);

  @override
  State<HadithIconsButton> createState() => _HadithIconsButtonState();
  final String text;
  final String description;
}

class _HadithIconsButtonState extends State<HadithIconsButton> {
  bool selected1 = false;
  bool selected2 = false;
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
                shareDuaa(subject: "لا تنسونا من صالح الدعاء", widget.text);
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
                selected1 ? MyColors.darkBrown : MyColors.lightBrown,
            radius: 35,
            child: MaterialButton(
              onPressed: () {
                setState(() async {
                  selected1 = !selected1;
                  if (selected1 == true) {
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
                                  widget.description,
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
                                  selected1 = false;
                                  setState(() {});
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
                });
              },
              splashColor: MyColors.darkBrown,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
              child: Center(
                child: Icon(
                  Icons.description,
                  color: selected1 ? MyColors.lightBrown : MyColors.darkBrown,
                  size: 40,
                ),
              ),
            ),
          ),
          CircleAvatar(
            backgroundColor:
                selected2 ? MyColors.darkBrown : MyColors.lightBrown,
            radius: 35,
            child: MaterialButton(
              onPressed: () {
                setState(() {
                  selected2 = !selected2;
                });
              },
              splashColor: MyColors.darkBrown,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
              child: Center(
                child: Icon(
                  Icons.favorite,
                  color: selected2 ? MyColors.lightBrown : MyColors.darkBrown,
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
