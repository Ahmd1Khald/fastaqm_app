import 'package:fastaqm_app/Core/widgets/custom_app_bar.dart';
import 'package:fastaqm_app/Core/widgets/custom_containt.dart';
import 'package:fastaqm_app/Features/ahadith/presentation/views/widgets/custom_hadith_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../Core/constatnts/colors.dart';
import '../../../../Core/constatnts/variables.dart';
import '../../../../Core/widgets/custom_loading.dart';
import '../../../duaa/presentation/views/widgets/custom_duaa_title.dart';
import '../controller/ahadith_cubit.dart';

class AhadithScreen extends StatelessWidget {
  const AhadithScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AhadithCubit()..fetchAhadithData(),
      child: BlocConsumer<AhadithCubit, AhadithState>(
        listener: (context, state) {},
        builder: (context, state) {
          AhadithCubit cubit = AhadithCubit.get(context);
          if (state is AhadithLoadingFetchData) {
            return Scaffold(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              appBar: customAppBar(context),
              body: const Center(
                child: CustomLoadingPage(),
              ),
            );
          }
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              forceMaterialTransparency: true,
              backgroundColor: MyColors.creamColor,
              leading: IconButton(
                  onPressed: () {
                    cubit.showSliderFunc(true);
                  },
                  icon: const Icon(
                    Icons.settings,
                    size: 32,
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
            bottomNavigationBar: cubit.showSlider
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
                            value: cubit.sliderValue,
                            onChanged: (value) {
                              cubit.changeFontValue(value);
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
                              cubit.showSliderFunc(false);
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
                    text: cubit.ahadithList[AppVariables.ahadithSelected]
                        ["title"],
                  ),
                  Text(
                    '${AppVariables.ahadithSelected + 1}/${cubit.ahadithList.length}',
                    style: GoogleFonts.notoNastaliqUrdu(
                      color: Colors.black,
                      fontSize: 24.sp,
                    ),
                  ),
                  CustomContantContainer(
                    text: cubit.ahadithList[AppVariables.ahadithSelected]
                        ["hadith"],
                    fontSize: cubit.sliderValue,
                  ),
                  HadithIconsButton(
                    cubit: cubit,
                    hadith: cubit.ahadithList[AppVariables.ahadithSelected]
                        ["hadith"],
                    number: cubit.ahadithList[AppVariables.ahadithSelected]
                        ["number"],
                    description: cubit.ahadithList[AppVariables.ahadithSelected]
                        ["description"],
                  ),
                  if (AppVariables.ahadithSelected == 0) ...[
                    CircleAvatar(
                      backgroundColor: MyColors.darkBrown,
                      radius: 38.sp,
                      child: MaterialButton(
                        onPressed: () {
                          cubit.nextHadith(len: cubit.ahadithList.length);
                        },
                        elevation: 5,
                        //height: AppVariables.appSize(context).width * 0.1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(45),
                        ),
                        color: MyColors.darkBrown,
                        splashColor: MyColors.lightBrown,
                        child: Center(
                          child: Icon(
                            Icons.keyboard_arrow_right,
                            size: 38.sp,
                            color: MyColors.whiteColor,
                          ),
                        ),
                      ),
                    ),
                  ] else if (AppVariables.ahadithSelected ==
                      cubit.ahadithList.length - 1) ...[
                    CircleAvatar(
                      backgroundColor: MyColors.darkBrown,
                      radius: 38.sp,
                      child: MaterialButton(
                        onPressed: () {
                          cubit.backHadith();
                        },
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
                            size: 38.sp,
                            color: MyColors.whiteColor,
                          ),
                        ),
                      ),
                    ),
                  ] else ...[
                    SizedBox(
                      width: AppVariables.appSize(context).width * 0.55,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            backgroundColor: MyColors.darkBrown,
                            radius: 39,
                            child: MaterialButton(
                              onPressed: () {
                                cubit.backHadith();
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
                                cubit.nextHadith(len: cubit.ahadithList.length);
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
        },
      ),
    );
  }
}
