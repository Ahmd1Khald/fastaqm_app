import 'package:fastaqm_app/Core/constatnts/variables.dart';
import 'package:fastaqm_app/Core/widgets/customErrorContainer.dart';
import 'package:fastaqm_app/Core/widgets/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../Core/constatnts/colors.dart';
import '../../../../../../Core/widgets/custom_app_bar.dart';
import '../../../../../duaa/presentation/views/widgets/custom_duaa_title.dart';
import '../../../../../duaa/presentation/views/widgets/duaa_containt.dart';
import '../../../controller/saves_cubit.dart';
import 'duaa_saved_icons.dart';

class DuaaSaves extends StatelessWidget {
  const DuaaSaves({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SavesCubit()..fetchFavDuaaData(),
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
          if (cubit.duaaFavList.isNotEmpty) {
            return Scaffold(
              appBar: customAppBar(context),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomDuaaTitle(
                      text: cubit.duaaFavList[AppVariables.duaaSaveIndex]
                          ["category"],
                    ),
                    Text(
                      '${AppVariables.duaaSaveIndex + 1}/${cubit.duaaFavList.length}',
                      style: GoogleFonts.notoNastaliqUrdu(
                        color: Colors.black,
                        fontSize: 24,
                      ),
                    ),
                    CustomDuaaContant(
                      text: cubit.duaaFavList[AppVariables.duaaSaveIndex]
                          ["zekr"],
                    ),
                    DuaaSavesIconsButton(
                      cubit: cubit,
                      duaa: cubit.duaaFavList[AppVariables.duaaSaveIndex]
                          ["zekr"],
                      category: cubit.duaaFavList[AppVariables.duaaSaveIndex]
                          ["category"],
                    ),
                    if (AppVariables.duaaSaveIndex == 0) ...[
                      CircleAvatar(
                        backgroundColor: MyColors.darkBrown,
                        radius: 39,
                        child: MaterialButton(
                          onPressed: () {
                            cubit.nextHadith(
                                len: cubit.duaaFavList.length - 1,
                                isHadith: false);
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
                    ] else if (AppVariables.duaaSaveIndex ==
                        cubit.duaaFavList.length - 1) ...[
                      CircleAvatar(
                        backgroundColor: MyColors.darkBrown,
                        radius: 39,
                        child: MaterialButton(
                          onPressed: () {
                            cubit.backHadith(isHadith: false);
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
                    ] else ...[
                      Padding(
                        padding: EdgeInsets.only(
                          top: AppVariables.appSize(context).width * 0.1,
                          left: 80,
                          right: 80,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              backgroundColor: MyColors.darkBrown,
                              radius: 39,
                              child: MaterialButton(
                                onPressed: () {
                                  cubit.backHadith(isHadith: false);
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
                                  cubit.nextHadith(
                                      len: cubit.duaaFavList.length - 1,
                                      isHadith: false);
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
          }
          return Scaffold(
            appBar: customAppBar(context),
            body: const CustomErrorContainer(
              title: "لا يوجد أدعية مضافة",
            ),
          );
        },
      ),
    );
  }
}
