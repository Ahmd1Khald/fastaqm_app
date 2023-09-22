import 'package:fastaqm_app/Core/constatnts/app_strings.dart';
import 'package:fastaqm_app/Core/constatnts/assets_manager.dart';
import 'package:fastaqm_app/Core/constatnts/colors.dart';
import 'package:fastaqm_app/Core/constatnts/variables.dart';
import 'package:fastaqm_app/Core/helpers/cachehelper.dart';
import 'package:fastaqm_app/Features/pray_time/presentation/views/widgets/backgraound_widget.dart';
import 'package:fastaqm_app/Features/pray_time/presentation/views/widgets/date_widget.dart';
import 'package:fastaqm_app/Features/pray_time/presentation/views/widgets/time_wiget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../Core/services/ServiceLocator.dart';
import '../../../../Core/widgets/custom_floating_button.dart';
import '../../data/repository/pray_time_repository.dart';
import '../../domain/usecase/pray_time_usecase.dart';
import '../controller/pray_time_cubit.dart';

class PrayTimeScreen extends StatelessWidget {
  const PrayTimeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.now();
    print(date);
    final double timeNow = DateTime.now().hour.toDouble();
    return BlocProvider(
      create: (context) => PrayTimeCubit(
        PrayTimeUseCase(getIt.get<PrayRepository>()),
      )..fetchPrayData(
          country: CacheHelper.getDate(key: AppStrings.countryNameKey),
          date: date.toString(),
        ),
      child: BlocConsumer<PrayTimeCubit, PrayTimeState>(
        listener: (context, state) {
          if (state is PrayTimeSuccessFetchData) {
            print(state.data.data['timings']['Fajr']);
          }
          if (state is PrayTimeLoadingFetchData) {
            const Center(child: CircularProgressIndicator());
          }
        },
        builder: (context, state) {
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
                          DateWidget(
                            dayName: state.data.data['date']['hijri']['weekday']
                                ['ar'],
                            dayNum: state.data.data['date']['hijri']['day'],
                            monthName: state.data.data['date']['hijri']['month']
                                ['ar'],
                            dateNum: state.data.data['date']['hijri']['year'],
                          ),
                          TimeWidget(
                            prayName: 'الفجر',
                            timeNow: timeNow,
                            prayTime: state.data.data['timings']['Fajr'],
                          ),
                          TimeWidget(
                            prayName: 'الشروق',
                            timeNow: timeNow,
                            prayTime: state.data.data['timings']['Sunrise'],
                          ),
                          TimeWidget(
                            prayName: 'الظهر',
                            timeNow: timeNow,
                            prayTime: state.data.data['timings']['Dhuhr'],
                          ),
                          TimeWidget(
                            prayName: 'العصر',
                            timeNow: timeNow,
                            prayTime: state.data.data['timings']['Asr'],
                          ),
                          TimeWidget(
                            prayName: 'المغرب',
                            timeNow: timeNow,
                            prayTime: state.data.data['timings']['Maghrib'],
                          ),
                          TimeWidget(
                            prayName: 'العشاء',
                            timeNow: timeNow,
                            prayTime: state.data.data['timings']['Isha'],
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
                        Container(
                          height: AppVariables.appSize(context).height * 0.3,
                          width: AppVariables.appSize(context).width * 0.8,
                          decoration: BoxDecoration(
                            color: MyColors.creamColor,
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: MyColors.darkBrown),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.error_outline,
                                color: Colors.red,
                                size: 60,
                              ),
                              const SizedBox(
                                height: 16.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text(
                                    "تحقق من اتصالك بالانترنيت واعد المحاولة لاحقا",
                                    style: GoogleFonts.cairo(
                                      color: MyColors.darkBrown,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 22,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
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
                    SpinKitFadingCircle(
                      itemBuilder: (BuildContext context, int index) {
                        return DecoratedBox(
                          decoration: BoxDecoration(
                            color: index.isEven
                                ? MyColors.babyBrown
                                : MyColors.lightBrown,
                          ),
                        );
                      },
                    ),
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
