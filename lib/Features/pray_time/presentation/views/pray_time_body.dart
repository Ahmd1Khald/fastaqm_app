import 'package:fastaqm_app/Core/constatnts/assets_manager.dart';
import 'package:fastaqm_app/Core/constatnts/variables.dart';
import 'package:fastaqm_app/Features/pray_time/presentation/views/widgets/backgraound_widget.dart';
import 'package:fastaqm_app/Features/pray_time/presentation/views/widgets/date_widget.dart';
import 'package:fastaqm_app/Features/pray_time/presentation/views/widgets/time_wiget.dart';
import 'package:fastaqm_app/Features/pray_time/presentation/views/widgets/timer_count_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Core/constatnts/constant.dart';
import '../../../../Core/widgets/customErrorContainer.dart';
import '../../../../Core/widgets/custom_floating_button.dart';
import '../../../../Core/widgets/custom_loading.dart';
import '../controller/pray_time_cubit.dart';

class PrayTimeScreen extends StatelessWidget {
  const PrayTimeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.now();
    //print(date);
    final double timeNow = DateTime.now().hour.toDouble();
    return BlocProvider(
      create: (context) => PrayTimeCubit()..fetchPrayData(),
      child: BlocConsumer<PrayTimeCubit, PrayTimeState>(
        listener: (context, state) {
          if (state is PrayTimeSuccessFetchData) {
            //print(state.data.data['timings']['Fajr']);
          }
          if (state is PrayTimeLoadingFetchData) {
            const Center(child: CircularProgressIndicator());
          }
        },
        builder: (context, state) {
          PrayTimeCubit cubit = PrayTimeCubit.get(context);
          if (state is PrayTimeSuccessFetchData) {
            return Scaffold(
              floatingActionButton: customFloatingActionButton(context),
              body: SafeArea(
                child: Stack(
                  alignment: AlignmentDirectional.topCenter,
                  children: [
                    const BackGroundWidget(),
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          const DateWidget(),
                          TimerCountWidget(
                            cubit: cubit,
                          ),
                          TimeWidget(
                            prayName: 'الفجر',
                            timeNow: timeNow,
                            prayTime:
                                fajrTime, //state.data.data['timings']['Fajr'],
                          ),
                          TimeWidget(
                            prayName: 'الشروق',
                            timeNow: timeNow,
                            prayTime:
                                shroukTime, //state.data.data['timings']['Sunrise'],
                          ),
                          TimeWidget(
                            prayName: 'الظهر',
                            timeNow: timeNow,
                            prayTime:
                                duhrTime, //state.data.data['timings']['Dhuhr'],
                          ),
                          TimeWidget(
                            prayName: 'العصر',
                            timeNow: timeNow,
                            prayTime:
                                asrTime, //state.data.data['timings']['Asr'],
                          ),
                          TimeWidget(
                            prayName: 'المغرب',
                            timeNow: timeNow,
                            prayTime:
                                maghrbTime, //state.data.data['timings']['Maghrib'],
                          ),
                          TimeWidget(
                            prayName: 'العشاء',
                            timeNow: timeNow,
                            prayTime:
                                ishaTime, //state.data.data['timings']['Isha'],
                          ),
                          Image.asset(
                            AssetsManager.prayIcon,
                            fit: BoxFit.cover,
                            width: AppVariables.appSize(context).width * 0.7,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (state is PrayTimeErrorFetchData) {
            return Scaffold(
              body: SafeArea(
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    const BackGroundWidget(),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CustomErrorContainer(
                          title: "أعد المحاولة لاحقا",
                        ),
                        Image.asset(
                          AssetsManager.prayIcon,
                          fit: BoxFit.cover,
                          width: AppVariables.appSize(context).width * 0.7,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          } else if (state is PrayTimeLoadingFetchData) {
            return Scaffold(
              body: SafeArea(
                child: Stack(
                  alignment: AlignmentDirectional.topCenter,
                  children: [
                    const BackGroundWidget(),
                    const CustomLoadingPage(),
                    const SizedBox(
                      height: 100,
                    ),
                    Image.asset(
                      AssetsManager.prayIcon,
                      fit: BoxFit.cover,
                      width: AppVariables.appSize(context).width * 0.7,
                    ),
                  ],
                ),
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
