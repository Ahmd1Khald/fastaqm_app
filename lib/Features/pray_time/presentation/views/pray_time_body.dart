import 'package:fastaqm_app/Core/constatnts/assets_manager.dart';
import 'package:fastaqm_app/Core/constatnts/variables.dart';
import 'package:fastaqm_app/Features/pray_time/presentation/views/widgets/backgraound_widget.dart';
import 'package:fastaqm_app/Features/pray_time/presentation/views/widgets/date_widget.dart';
import 'package:fastaqm_app/Features/pray_time/presentation/views/widgets/time_wiget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../Core/constatnts/app_strings.dart';
import '../../../../Core/constatnts/colors.dart';
import '../../../../Core/constatnts/constant.dart';
import '../../../../Core/helpers/cachehelper.dart';
import '../../../../Core/widgets/customErrorContainer.dart';
import '../../../../Core/widgets/custom_SnackBar.dart';
import '../../../../Core/widgets/custom_floating_button.dart';
import '../../../../Core/widgets/custom_loading.dart';
import '../controller/pray_time_cubit.dart';

class PrayTimeScreen extends StatelessWidget {
  const PrayTimeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //print(date);
    final double timeNow = DateTime.now().hour.toDouble();
    return BlocProvider(
      create: (context) => PrayTimeCubit()..fetchPrayData(context),
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
                          // TimerCountWidget(
                          //   cubit: cubit,
                          //   color: MyColors.lightBrown,
                          // ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20.0,
                              vertical: 20,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TimeWidget(
                                  prayName: "الظهر",
                                  prayTime: duhrTime,
                                ),
                                TimeWidget(
                                  prayName: "الشروق",
                                  prayTime: shroukTime,
                                ),
                                TimeWidget(
                                  prayName: "الفجر",
                                  prayTime: fajrTime,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 0.0,
                              horizontal: 20,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TimeWidget(
                                  prayName: "العشاء",
                                  prayTime: ishaTime,
                                ),
                                TimeWidget(
                                  prayName: "المغرب",
                                  prayTime: maghrbTime,
                                ),
                                TimeWidget(
                                  prayName: "العصر",
                                  prayTime: asrTime,
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
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (state is PrayTimeErrorFetchData) {
            Future<void> getUserLocation() async {
              try {
                // Check if the device is currently offline
                final bool isOffline =
                    !await InternetConnectionChecker().hasConnection;

                if (isOffline) {
                  // Handle offline scenario: No network connectivity
                  print("----offline-----");
                  CacheHelper.saveData(
                      key: AppStrings.locationKey, value: false);
                  customSnackBar(context: context, title: 'لا يوجد انترنيت');
                } else {
                  // Request location permission
                  var status = await Permission.locationWhenInUse.request();

                  if (status.isGranted) {
                    // Location permission granted, get the location
                    final Position position =
                        await Geolocator.getCurrentPosition();
                    print(position);
                    CacheHelper.saveData(
                        key: AppStrings.locationKey, value: true);
                    CacheHelper.saveData(
                        key: AppStrings.latKey, value: position.latitude);
                    CacheHelper.saveData(
                        key: AppStrings.longKey, value: position.longitude);
                    // Continue with additional logic or data processing here.
                  } else {
                    // Location permission denied
                    CacheHelper.saveData(
                        key: AppStrings.locationKey, value: false);
                    customSnackBar(
                        context: context,
                        title: 'قم بالسماح بأخذ موقعك من الإعدادات');
                    print("----permission denied-----");
                    // Handle the scenario where the user denies location permission
                  }
                }
              } catch (e) {
                // Handle exceptions, including those related to network or location errors
                CacheHelper.saveData(key: AppStrings.locationKey, value: false);
                print("----error-----");
                throw PlatformException(
                  code: 'ERROR_GETTING_LOCATION',
                  message: 'Error getting user location: $e',
                );
              }
            }

            return Scaffold(
              floatingActionButton: customFloatingActionButton(context),
              body: SafeArea(
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    const BackGroundWidget(),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CustomErrorContainer(
                          title: "يجب تفعيل الموقع أولا",
                        ),
                        const SizedBox(
                          height: 45,
                        ),
                        MaterialButton(
                          color: MyColors.darkBrown,
                          onPressed: () async {
                            //const CustomLoadingPage();
                            await getUserLocation().then((value) {
                              cubit.fetchPrayData(context);
                            });
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          splashColor: MyColors.lightBrown,
                          elevation: 5,
                          height: AppVariables.appSize(context).width * 0.15,
                          child: Text(
                            "تفعيل الموقع",
                            style: GoogleFonts.noticiaText(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                            ),
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
              floatingActionButton: customFloatingActionButton(context),
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
