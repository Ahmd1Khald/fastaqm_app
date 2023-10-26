import 'package:fastaqm_app/Core/constatnts/variables.dart';
import 'package:fastaqm_app/Core/widgets/customErrorContainer.dart';
import 'package:fastaqm_app/Core/widgets/custom_containt.dart';
import 'package:fastaqm_app/Core/widgets/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../Core/constatnts/colors.dart';
import '../../../../../../Core/widgets/custom_app_bar.dart';
import '../../../../../../Core/widgets/reusable_setting_icon.dart';
import '../../../../../duaa/presentation/views/widgets/custom_duaa_title.dart';
import '../../../controller/saves_cubit.dart';
import 'ahadith_saved_icons.dart';

class AhadithSaves extends StatelessWidget {
  const AhadithSaves({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SavesCubit()..fetchFavAhadithData(),
      child: BlocConsumer<SavesCubit, SavesState>(
        listener: (context, state) {},
        builder: (context, state) {
          SavesCubit cubit = SavesCubit.get(context);
          if (state is SavesLoadingFetchData) {
            return Scaffold(
              appBar: customAppBar(context),
              body: const Center(child: CustomLoadingPage()),
            );
          }
          if (cubit.ahadithFavList.isNotEmpty) {
            return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                forceMaterialTransparency: true,
                backgroundColor: MyColors.creamColor,
                leading: IconButton(
                  onPressed: () {
                    cubit.showSliderFunc(true);
                  },
                  icon: reusableSettingIcon(),
                ),
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
                      text: cubit.ahadithFavList[AppVariables.hadishSaveIndex]
                          ["title"],
                    ),
                    Text(
                      '${AppVariables.hadishSaveIndex + 1}/${cubit.ahadithFavList.length}',
                      style: GoogleFonts.notoNastaliqUrdu(
                        color: Colors.black,
                        fontSize: 24.sp,
                      ),
                    ),
                    CustomContantContainer(
                      text: cubit.ahadithFavList[AppVariables.hadishSaveIndex]
                          ["hadith"],
                      fontSize: cubit.sliderValue,
                    ),
                    HadithSavesIconsButton(
                      cubit: cubit,
                      hadith: cubit.ahadithFavList[AppVariables.hadishSaveIndex]
                          ["hadith"],
                      number: cubit.ahadithFavList[AppVariables.hadishSaveIndex]
                          ["number"],
                      description:
                          cubit.ahadithFavList[AppVariables.hadishSaveIndex]
                              ["description"],
                    ),
                    if (AppVariables.hadishSaveIndex == 0) ...[
                      CircleAvatar(
                        backgroundColor: MyColors.darkBrown,
                        radius: 38.sp,
                        child: MaterialButton(
                          onPressed: () {
                            cubit.nextHadith(
                                isHadith: true,
                                len: cubit.ahadithFavList.length - 1);
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
                    ] else if (AppVariables.hadishSaveIndex ==
                        cubit.ahadithFavList.length - 1) ...[
                      CircleAvatar(
                        backgroundColor: MyColors.darkBrown,
                        radius: 38.sp,
                        child: MaterialButton(
                          onPressed: () {
                            cubit.backHadith(
                              isHadith: true,
                            );
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
                        width: AppVariables.appSize(context).width * 0.51,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              backgroundColor: MyColors.darkBrown,
                              radius: 38.sp,
                              child: MaterialButton(
                                onPressed: () {
                                  cubit.backHadith(
                                    isHadith: true,
                                  );
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
                            CircleAvatar(
                              backgroundColor: MyColors.darkBrown,
                              radius: 38.sp,
                              child: MaterialButton(
                                onPressed: () {
                                  cubit.nextHadith(
                                      isHadith: true,
                                      len: cubit.ahadithFavList.length - 1);
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
                          ],
                        ),
                      ),
                    ]
                  ],
                ),
              ),
            );
          }
          return Scaffold(
            appBar: customAppBar(context),
            body: const CustomErrorContainer(
              title: "لا يوجد أحاديث مضافة",
            ),
          );
        },
      ),
    );
  }
}
