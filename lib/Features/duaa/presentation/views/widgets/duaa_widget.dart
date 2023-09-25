import 'package:fastaqm_app/Core/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

import '../../../../../Core/constatnts/colors.dart';
import '../../../../../Core/constatnts/variables.dart';
import 'Love_button.dart';
import 'custom_duaa_title.dart';
import 'duaa_containt.dart';

class DuaaWidget extends StatefulWidget {
  const DuaaWidget({Key? key, required this.list}) : super(key: key);

  final List<Map<String, dynamic>> list;

  @override
  State<DuaaWidget> createState() => _DuaaWidgetState();
}

class _DuaaWidgetState extends State<DuaaWidget> {
  @override
  void initState() {
    AppVariables.duaaSelected = 0;
    super.initState();
  }

  void nextDuaa({required int len}) {
    if (len - AppVariables.duaaSelected > 0) {
      AppVariables.duaaSelected++;
      setState(() {});
    }
  }

  void backDuaa() {
    if (AppVariables.duaaSelected > 0) {
      AppVariables.duaaSelected--;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomDuaaTitle(
              text: widget.list[0]["category"],
            ),
            SizedBox(
              height: AppVariables.appSize(context).width * 0.1,
            ),
            CustomDuaaContant(
              text: widget.list[AppVariables.duaaSelected]["zekr"],
            ),
            IconsButton(
              text: widget.list[AppVariables.duaaSelected]["zekr"],
            ),
            if (AppVariables.duaaSelected == 0) ...[
              CircleAvatar(
                backgroundColor: MyColors.darkBrown,
                radius: 39,
                child: MaterialButton(
                  onPressed: () {
                    nextDuaa(len: widget.list.length - 1);
                  },
                  elevation: 5,
                  //height: AppVariables.appSize(context).width * 0.1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(45),
                  ),
                  color: MyColors.darkBrown,
                  splashColor: MyColors.lightBrown,
                  child: const Center(
                    child: Icon(
                      Icons.keyboard_arrow_right,
                      size: 50,
                      color: MyColors.whiteColor,
                    ),
                  ),
                ),
              ),
            ] else if (AppVariables.duaaSelected == widget.list.length - 1) ...[
              CircleAvatar(
                backgroundColor: MyColors.darkBrown,
                radius: 39,
                child: MaterialButton(
                  onPressed: () {
                    backDuaa();
                  },
                  elevation: 5,
                  //height: AppVariables.appSize(context).width * 0.1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(45),
                  ),
                  color: MyColors.darkBrown,
                  splashColor: MyColors.lightBrown,
                  child: const Center(
                    child: Icon(
                      Icons.keyboard_arrow_left,
                      size: 50,
                      color: MyColors.whiteColor,
                    ),
                  ),
                ),
              ),
            ] else ...[
              Padding(
                padding: EdgeInsets.only(
                  top: AppVariables.appSize(context).width * 0.1,
                  left: 80,
                  right: 80,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      backgroundColor: MyColors.darkBrown,
                      radius: 39,
                      child: MaterialButton(
                        onPressed: () {
                          backDuaa();
                        },
                        elevation: 5,
                        //height: AppVariables.appSize(context).width * 0.1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(45),
                        ),
                        color: MyColors.darkBrown,
                        splashColor: MyColors.lightBrown,
                        child: const Center(
                          child: Icon(
                            Icons.keyboard_arrow_left,
                            size: 50,
                            color: MyColors.whiteColor,
                          ),
                        ),
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: MyColors.darkBrown,
                      radius: 39,
                      child: MaterialButton(
                        onPressed: () {
                          nextDuaa(len: widget.list.length - 1);
                        },
                        elevation: 5,
                        //height: AppVariables.appSize(context).width * 0.1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(45),
                        ),
                        color: MyColors.darkBrown,
                        splashColor: MyColors.lightBrown,
                        child: const Center(
                          child: Icon(
                            Icons.keyboard_arrow_right,
                            size: 50,
                            color: MyColors.whiteColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
