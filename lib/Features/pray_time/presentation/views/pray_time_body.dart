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
import '../../data/repository/pray_time_repository.dart';
import '../../domain/usecase/pray_time_usecase.dart';
import '../controller/pray_time_cubit.dart';

class PrayTimeScreen extends StatelessWidget {
  const PrayTimeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Create a DateTime object representing the date you want to format
    DateTime date = DateTime.now(); // Replace with your specific date

    // Define the date format
    //final DateFormat formatter = DateFormat('dd-MM-yyyy');

    // Format the date
    //final String formattedDate;

    //print('Formatted Date: $formattedDate');
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
              body: SafeArea(
                child: Stack(
                  alignment: AlignmentDirectional.topCenter,
                  children: [
                    const BackGroundWidget(),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const DateWidget(
                          dayName: 'الجمعة',
                          dayNum: '12',
                          monthName: 'ذي الحجة',
                          dateNum: '1445',
                        ),
                        TimeWidget(
                          prayName: 'الفجر',
                          timeNow: timeNow,
                          prayTime: "04:23",
                          prayHour: 4,
                        ),
                        TimeWidget(
                          prayName: 'الشروق',
                          timeNow: timeNow,
                          prayTime: "06:32",
                          prayHour: 6,
                        ),
                        TimeWidget(
                          prayName: 'الظهر',
                          timeNow: timeNow,
                          prayTime: "12:49",
                          prayHour: 12,
                        ),
                        TimeWidget(
                          prayName: 'العصر',
                          timeNow: timeNow,
                          prayTime: "16:15",
                          prayHour: 16,
                        ),
                        TimeWidget(
                          prayName: 'المغرب',
                          timeNow: timeNow,
                          prayTime: "19:06",
                          prayHour: 19,
                        ),
                        TimeWidget(
                          prayName: 'العشاء',
                          timeNow: timeNow,
                          prayTime: "20:36",
                          prayHour: 20,
                        ),
                        Image.asset(
                          AssetsManager.prayIcon,
                          fit: BoxFit.cover,
                          width: AppVariables.appSize(context).width * 0.7,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          } else if (state is PrayTimeErrorFetchData) {
            print("++++++++++++++++++++++++++++++++++");
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
