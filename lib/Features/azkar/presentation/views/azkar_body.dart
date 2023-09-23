import 'package:fastaqm_app/Features/azkar/presentation/views/widgets/back_zeker_button.dart';
import 'package:fastaqm_app/Features/azkar/presentation/views/widgets/count_ziker_widget.dart';
import 'package:fastaqm_app/Features/azkar/presentation/views/widgets/next_zeker_button.dart';
import 'package:fastaqm_app/Features/azkar/presentation/views/widgets/slider_widget.dart';
import 'package:fastaqm_app/Features/azkar/presentation/views/widgets/ziker_containt_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Core/constatnts/variables.dart';
import '../../../../Core/widgets/custom_app_bar.dart';
import '../../../../Core/widgets/custom_loading.dart';
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
              appBar: customAppBar(context),
              body: const Center(
                child: CustomLoadingPage(),
              ),
            );
          }
          if (state is AzkarSuccessFetchData || cubit.azkarAlsabah.isNotEmpty) {
            return Scaffold(
              appBar: customAppBar(context),
              body: SingleChildScrollView(
                child: Column(
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
                                  : 1,
                      current: AppVariables.azkarSelected == 0
                          ? cubit.sabahIndex
                          : AppVariables.azkarSelected == 1
                              ? cubit.masaaIndex
                              : AppVariables.azkarSelected == 2
                                  ? cubit.nomIndex
                                  : 0,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ZikerContantWidget(
                      text: AppVariables.azkarSelected == 0
                          ? cubit.azkarAlsabah[cubit.sabahIndex]['zekr']
                          : AppVariables.azkarSelected == 1
                              ? cubit.azkarAlmasaa[cubit.masaaIndex]['zekr']
                              : AppVariables.azkarSelected == 2
                                  ? cubit.azkarAlnom[cubit.nomIndex]['zekr']
                                  : '',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CountZikerWidget(
                      num: AppVariables.azkarSelected == 0
                          ? cubit.azkarAlsabah[cubit.sabahIndex]['count']
                          : AppVariables.azkarSelected == 1
                              ? cubit.azkarAlmasaa[cubit.masaaIndex]['count']
                              : AppVariables.azkarSelected == 2
                                  ? cubit.azkarAlnom[cubit.nomIndex]['count']
                                  : '',
                    ),
                    const SizedBox(
                      height: 45,
                    ),
                    Row(
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
                                      : false,
                          child: BackZikerWidget(
                            fnc: () {
                              cubit.decIndex(tt: AppVariables.azkarSelected);
                            },
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
                                      : false,
                          child: NextZikerWidget(
                            fnc: () {
                              cubit.incIndex(tt: AppVariables.azkarSelected);
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }
          return Scaffold(
            appBar: customAppBar(context),
            body: const Center(
              child: CustomLoadingPage(),
            ),
          );
        },
      ),
    );
  }
}
