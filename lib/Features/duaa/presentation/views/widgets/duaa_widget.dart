import 'package:fastaqm_app/Core/widgets/custom_containt.dart';
import 'package:fastaqm_app/Features/duaa/presentation/controller/duaa_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../Core/constatnts/app_strings.dart';
import '../../../../../Core/constatnts/colors.dart';
import '../../../../../Core/constatnts/variables.dart';
import '../../../../../Core/helpers/cachehelper.dart';
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
  bool showSlider = false;
  int playedAya = -1;
  double sliderValue =
      CacheHelper.getDate(key: AppStrings.containerFontKey) ?? 24;

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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        forceMaterialTransparency: true,
        backgroundColor: MyColors.creamColor,
        leading: IconButton(
            onPressed: () {
              setState(() {
                showSlider = !showSlider;
              });
            },
            icon: Icon(
              Icons.settings,
              size: 32.sp,
              color: MyColors.darkBrown,
            )),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_forward,
                size: 32,
                color: MyColors.darkBrown,
              ))
        ],
      ),
      bottomNavigationBar: showSlider
          ? Container(
              height: AppVariables.appSize(context).width * 0.15,
              width: AppVariables.appSize(context).width,
              color: MyColors.lightBrown.withOpacity(0.2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 4,
                    child: Slider(
                      value: sliderValue,
                      onChanged: (value) {
                        setState(() {
                          sliderValue = value;
                          // quranFontSize = value;
                          print(sliderValue);
                        });
                        CacheHelper.saveData(
                            key: 'sliderValue', value: sliderValue);
                      },
                      min: 15,
                      max: 34,
                      activeColor: MyColors.darkBrown,
                      inactiveColor: MyColors.lightBrown,
                      divisions: 8,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: CloseButton(
                      onPressed: () {
                        setState(() {
                          showSlider = false;
                        });
                      },
                    ),
                  ),
                ],
              ),
            )
          : Container(
              color: Colors.white,
              height: 1,
              width: AppVariables.appSize(context).width,
            ),
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
              fontSize: sliderValue,
            ),
            SizedBox(
              height: 20.h,
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
                      CustomBackButton(
                        fnc: () {
                          //backDuaa();
                        },
                        color: Colors.grey,
                      ),
                      CustomNextButton(
                        fnc: () {
                          nextDuaa(len: widget.list.length - 1);
                        },
                        color: MyColors.darkBrown,
                      ),
                    ] else if (AppVariables.duaaSelected ==
                        widget.list.length - 1) ...[
                      CustomBackButton(
                        fnc: () {
                          backDuaa();
                        },
                        color: MyColors.darkBrown,
                      ),
                      CustomNextButton(
                        fnc: () {
                          nextDuaa(len: widget.list.length - 1);
                        },
                        color: Colors.grey,
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
                              color: MyColors.darkBrown,
                            ),
                            CustomNextButton(
                              fnc: () {
                                nextDuaa(len: widget.list.length - 1);
                              },
                              color: MyColors.darkBrown,
                            ),
                          ],
                        ),
                      ),
                    ]
                  ],
                ),
              ),
            ] else ...[
              SizedBox(
                width: AppVariables.appSize(context).width * 0.7,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomBackButton(
                      fnc: () {
                        //backDuaa();
                      },
                      color: Colors.grey,
                    ),
                    CustomNextButton(
                      fnc: () {
                        //nextDuaa(len: widget.list.length - 1);
                      },
                      color: Colors.grey,
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
