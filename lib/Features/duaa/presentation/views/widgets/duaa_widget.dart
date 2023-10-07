import 'package:fastaqm_app/Core/widgets/custom_app_bar.dart';
import 'package:fastaqm_app/Core/widgets/custom_containt.dart';
import 'package:fastaqm_app/Features/duaa/presentation/controller/duaa_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../Core/constatnts/variables.dart';
import '../../../../../Core/widgets/custom_back_button.dart';
import '../../../../../Core/widgets/custom_next_button.dart';
import 'Love_button.dart';
import 'custom_duaa_title.dart';

class DuaaWidget extends StatefulWidget {
  const DuaaWidget({Key? key, required this.list, required this.cubit})
      : super(key: key);

  final List<Map<String, dynamic>> list;
  final DuaaCubit cubit;

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
              height: 20.h,
            ),
            CustomContantContainer(
              text: widget.list[AppVariables.duaaSelected]["zekr"],
            ),
            SizedBox(
              height: 15.h,
            ),
            IconsButton(
              duaa: widget.list[AppVariables.duaaSelected]["zekr"],
              category: widget.list[AppVariables.duaaSelected]["category"],
            ),
            SizedBox(
              height: 25.h,
            ),
            if (widget.list.length > 1) ...[
              SizedBox(
                width: AppVariables.appSize(context).width * 0.7,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (AppVariables.duaaSelected == 0) ...[
                      const Spacer(),
                      CustomNextButton(
                        fnc: () {
                          nextDuaa(len: widget.list.length - 1);
                        },
                      ),
                    ] else if (AppVariables.duaaSelected ==
                        widget.list.length - 1) ...[
                      CustomBackButton(
                        fnc: () {
                          backDuaa();
                        },
                      ),
                    ] else ...[
                      SizedBox(
                        width: AppVariables.appSize(context).width * 0.7,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomBackButton(
                              fnc: () {
                                backDuaa();
                              },
                            ),
                            CustomNextButton(
                              fnc: () {
                                nextDuaa(len: widget.list.length - 1);
                              },
                            ),
                          ],
                        ),
                      ),
                    ]
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
