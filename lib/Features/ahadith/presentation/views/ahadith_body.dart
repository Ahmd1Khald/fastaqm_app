import 'package:fastaqm_app/Core/widgets/custom_app_bar.dart';
import 'package:fastaqm_app/Features/ahadith/presentation/views/widgets/custom_hadith_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../Core/constatnts/colors.dart';
import '../../../../Core/constatnts/variables.dart';
import '../../../../Core/widgets/custom_loading.dart';
import '../../../duaa/presentation/views/widgets/custom_duaa_title.dart';
import '../../../duaa/presentation/views/widgets/duaa_containt.dart';
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
              appBar: customAppBar(context),
              body: const Center(
                child: CustomLoadingPage(),
              ),
            );
          }
          return Scaffold(
            appBar: customAppBar(context),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CustomDuaaTitle(
                    text: 'صحيح البخاري',
                  ),
                  Text(
                    '${AppVariables.ahadithSelected + 1}/300',
                    style: GoogleFonts.notoNastaliqUrdu(
                      color: Colors.black,
                      fontSize: 24,
                    ),
                  ),
                  CustomDuaaContant(
                    text: cubit.ahadithList[AppVariables.ahadithSelected]
                        ["hadith"],
                  ),
                  HadithIconsButton(
                    text: cubit.ahadithList[AppVariables.ahadithSelected]
                        ["hadith"],
                    description: cubit.ahadithList[AppVariables.ahadithSelected]
                        ["description"],
                  ),
                  if (AppVariables.ahadithSelected == 0) ...[
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
                  ] else if (AppVariables.ahadithSelected ==
                      cubit.ahadithList.length - 1) ...[
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