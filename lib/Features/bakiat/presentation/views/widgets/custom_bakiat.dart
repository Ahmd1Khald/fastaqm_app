import 'package:fastaqm_app/Core/helpers/cachehelper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../Core/constatnts/colors.dart';
import '../../../../../Core/constatnts/variables.dart';

class CustomBakiat extends StatefulWidget {
  CustomBakiat({Key? key, required this.text, required this.index})
      : super(key: key);

  @override
  State<CustomBakiat> createState() => _CustomBakiatState();
  final String text;
  final int index;
  int num = 0;
}

class _CustomBakiatState extends State<CustomBakiat> {
  @override
  void initState() {
    if (widget.index == 1) {
      widget.num = CacheHelper.getDate(key: "bakiat1") ?? 0;
    }
    if (widget.index == 2) {
      widget.num = CacheHelper.getDate(key: "bakiat2") ?? 0;
    }
    if (widget.index == 3) {
      widget.num = CacheHelper.getDate(key: "bakiat3") ?? 0;
    }
    if (widget.index == 4) {
      widget.num = CacheHelper.getDate(key: "bakiat4") ?? 0;
    }
    if (widget.index == 5) {
      widget.num = CacheHelper.getDate(key: "bakiat5") ?? 0;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30, right: 15, left: 15),
      child: Row(
        children: [
          Container(
            width: AppVariables.appSize(context).width * 0.2,
            height: AppVariables.appSize(context).width * 0.2,
            decoration: BoxDecoration(
              color: MyColors.lightBrown,
              borderRadius: BorderRadius.circular(40),
            ),
            child: Center(
              child: Text(
                '${widget.num}'.length > 4
                    ? "${widget.num} k+"
                    : '${widget.num}',
                style: GoogleFonts.cairo(
                  color: MyColors.darkBrown,
                  fontWeight: FontWeight.w800,
                  fontSize: 24,
                ),
              ),
            ),
          ),
          const Spacer(),
          Container(
            width: AppVariables.appSize(context).width * 0.46,
            height: AppVariables.appSize(context).width * 0.15,
            decoration: BoxDecoration(
              color: MyColors.darkBrown,
              borderRadius: BorderRadius.circular(40),
            ),
            child: Center(
              child: Text(
                widget.text,
                style: GoogleFonts.notoNastaliqUrdu(
                  color: MyColors.whiteColor,
                  fontWeight: FontWeight.w800,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          SizedBox(
            width: AppVariables.appSize(context).width * 0.02,
          ),
          SizedBox(
            width: AppVariables.appSize(context).width * 0.17,
            child: MaterialButton(
              onPressed: () {
                setState(() {
                  widget.num += 1;
                  if (widget.index == 1) {
                    CacheHelper.saveData(key: "bakiat1", value: widget.num);
                  }
                  if (widget.index == 2) {
                    CacheHelper.saveData(key: "bakiat2", value: widget.num);
                  }
                  if (widget.index == 3) {
                    CacheHelper.saveData(key: "bakiat3", value: widget.num);
                  }
                  if (widget.index == 4) {
                    CacheHelper.saveData(key: "bakiat4", value: widget.num);
                  }
                  if (widget.index == 5) {
                    CacheHelper.saveData(key: "bakiat5", value: widget.num);
                  }
                });
              },
              height: AppVariables.appSize(context).width * 0.14,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
              ),
              color: MyColors.darkBrown,
              splashColor: MyColors.lightBrown,
              child: const Icon(
                Icons.add,
                color: MyColors.whiteColor,
                size: 32,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
