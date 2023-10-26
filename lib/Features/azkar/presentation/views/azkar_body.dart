import 'package:fastaqm_app/Features/azkar/presentation/views/widgets/count_ziker_widget.dart';
import 'package:fastaqm_app/Features/azkar/presentation/views/widgets/slider_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../Core/constatnts/colors.dart';
import '../../../../Core/constatnts/variables.dart';
import '../../../../Core/widgets/customErrorContainer.dart';
import '../../../../Core/widgets/custom_app_bar.dart';
import '../../../../Core/widgets/custom_back_button.dart';
import '../../../../Core/widgets/custom_containt.dart';
import '../../../../Core/widgets/custom_loading.dart';
import '../../../../Core/widgets/custom_next_button.dart';
import '../../../../Core/widgets/reusable_setting_icon.dart';
import '../controller/azkar_cubit.dart';

class AzkarScreen extends StatelessWidget {
  const AzkarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AzkarCubit()..fetchAzkarData(),
      child: BlocConsumer<AzkarCubit, AzkarState>(
        listener: (context, state) {},
        builder: (context, state) {
          print(AppVariables.azkarSelected);
          AzkarCubit cubit = AzkarCubit.get(context);
          if (state is AzkarLoadingFetchData) {
            return Scaffold(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              appBar: customAppBar(context),
              body: const Center(
                child: CustomLoadingPage(),
              ),
            );
          }
          if (state is AzkarSuccessFetchData || cubit.azkarAlsabah.isNotEmpty) {
            return Scaffold(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              appBar: AppBar(
                automaticallyImplyLeading: false,
                forceMaterialTransparency: true,
                leading: IconButton(
                  onPressed: () {
                    cubit.showSliderFunc(true);
                  },
                  icon: reusableSettingIcon(),
                ),
                actions: [
                  Text(
                    cubit.zekrNameSelected,
                    style: GoogleFonts.noticiaText(
                      color: MyColors.darkBrown,
                      fontSize: 22.sp,
                    ),
                  ),
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
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: SizedBox(
                        height: AppVariables.appSize(context).width * 0.2,
                        child: ListView.separated(
                          itemBuilder: (context, index) => InkWell(
                            borderRadius: BorderRadius.circular(40),
                            onTap: () {
                              cubit.changeSelectedAzkarIcon(index);
                            },
                            child: cubit.changeSelectedZiker(index)[index],
                          ),
                          scrollDirection: Axis.horizontal,
                          separatorBuilder: (context, index) => const SizedBox(
                            width: 10,
                          ),
                          itemCount: cubit.changeSelectedZiker(-1).length,
                        ),
                      ),
                    ),
                    SliderWidget(
                      allCount: AppVariables.azkarSelected == 0
                          ? cubit.azkarAlsabah.length
                          : AppVariables.azkarSelected == 1
                              ? cubit.azkarAlmasaa.length
                              : AppVariables.azkarSelected == 2
                                  ? cubit.azkarAlnom.length
                                  : AppVariables.azkarSelected == 3
                                      ? cubit.azkarAlsalaa.length
                                      : 1,
                      current: AppVariables.azkarSelected == 0
                          ? cubit.sabahIndex
                          : AppVariables.azkarSelected == 1
                              ? cubit.masaaIndex
                              : AppVariables.azkarSelected == 2
                                  ? cubit.nomIndex
                                  : AppVariables.azkarSelected == 3
                                      ? cubit.salaaIndex
                                      : 0,
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    CustomContantContainer(
                      text: AppVariables.azkarSelected == 0
                          ? cubit.azkarAlsabah[cubit.sabahIndex]['zekr']
                          : AppVariables.azkarSelected == 1
                              ? cubit.azkarAlmasaa[cubit.masaaIndex]['zekr']
                              : AppVariables.azkarSelected == 2
                                  ? cubit.azkarAlnom[cubit.nomIndex]['zekr']
                                  : AppVariables.azkarSelected == 3
                                      ? cubit.azkarAlsalaa[cubit.salaaIndex]
                                          ['zekr']
                                      : '',
                      fontSize: cubit.sliderValue,
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    CountZikerWidget(
                      num: AppVariables.azkarSelected == 0
                          ? cubit.azkarAlsabah[cubit.sabahIndex]['count']
                          : AppVariables.azkarSelected == 1
                              ? cubit.azkarAlmasaa[cubit.masaaIndex]['count']
                              : AppVariables.azkarSelected == 2
                                  ? cubit.azkarAlnom[cubit.nomIndex]['count']
                                  : AppVariables.azkarSelected == 3
                                      ? cubit.azkarAlsalaa[cubit.salaaIndex]
                                          ['count']
                                      : '',
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 55),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Visibility(
                            visible: AppVariables.azkarSelected == 0 &&
                                    cubit.sabahIndex > 0
                                ? true
                                : AppVariables.azkarSelected == 1 &&
                                        cubit.masaaIndex > 0
                                    ? true
                                    : AppVariables.azkarSelected == 2 &&
                                            cubit.nomIndex > 0
                                        ? true
                                        : AppVariables.azkarSelected == 3 &&
                                                cubit.salaaIndex > 0
                                            ? true
                                            : false,
                            child: CustomBackButton(
                              fnc: () {
                                cubit.decIndex(tt: AppVariables.azkarSelected);
                              },
                              color: MyColors.darkBrown,
                            ),
                          ),
                          Visibility(
                            visible: AppVariables.azkarSelected == 0 &&
                                    cubit.sabahIndex !=
                                        cubit.azkarAlsabah.length - 1
                                ? true
                                : AppVariables.azkarSelected == 1 &&
                                        cubit.masaaIndex !=
                                            cubit.azkarAlmasaa.length - 1
                                    ? true
                                    : AppVariables.azkarSelected == 2 &&
                                            cubit.nomIndex !=
                                                cubit.azkarAlnom.length - 1
                                        ? true
                                        : AppVariables.azkarSelected == 3 &&
                                                cubit.salaaIndex !=
                                                    cubit.azkarAlsalaa.length -
                                                        1
                                            ? true
                                            : false,
                            child: CustomNextButton(
                              fnc: () {
                                cubit.incIndex(tt: AppVariables.azkarSelected);
                              },
                              color: MyColors.darkBrown,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }
          return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBar: customAppBar(context),
            body: const Center(
              child:
                  CustomErrorContainer(title: 'حدث خطأ ما حاول مرة اخرى لاحقا'),
            ),
          );
        },
      ),
    );
  }
}
