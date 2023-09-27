import 'package:fastaqm_app/Core/constatnts/variables.dart';
import 'package:fastaqm_app/Core/widgets/customErrorContainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../Core/constatnts/colors.dart';
import '../../../../../Core/widgets/custom_app_bar.dart';
import '../../../../duaa/presentation/views/widgets/custom_duaa_title.dart';
import '../../../../duaa/presentation/views/widgets/duaa_containt.dart';
import '../../controller/saves_cubit.dart';
import 'ahadith_saved_icons.dart';

class AhadithSaves extends StatelessWidget {
  const AhadithSaves({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SavesCubit()..setUp(),
      child: BlocConsumer<SavesCubit, SavesState>(
        listener: (context, state) {},
        builder: (context, state) {
          SavesCubit cubit = SavesCubit.get(context);
          if (AppVariables.hadishSaveLists.isNotEmpty) {
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
                      '${AppVariables.hadishSaveIndex + 1}/${AppVariables.hadishSaveLists.length}',
                      style: GoogleFonts.notoNastaliqUrdu(
                        color: Colors.black,
                        fontSize: 24,
                      ),
                    ),
                    CustomDuaaContant(
                      text: AppVariables
                          .hadishSaveLists[AppVariables.hadishSaveIndex].hadith,
                    ),
                    HadithSavesIconsButton(
                      cubit: cubit,
                      hadith: AppVariables
                          .hadishSaveLists[AppVariables.hadishSaveIndex].hadith,
                      number: AppVariables
                          .hadishSaveLists[AppVariables.hadishSaveIndex].number,
                      description: AppVariables
                          .hadishSaveLists[AppVariables.hadishSaveIndex]
                          .description,
                    ),
                    if (AppVariables.hadishSaveIndex == 0) ...[
                      CircleAvatar(
                        backgroundColor: MyColors.darkBrown,
                        radius: 39,
                        child: MaterialButton(
                          onPressed: () {
                            cubit.nextHadith(
                                len: AppVariables.hadishSaveLists.length - 1);
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
                    ] else if (AppVariables.hadishSaveIndex ==
                        AppVariables.hadishSaveLists.length - 1) ...[
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
                                  cubit.nextHadith(
                                      len: AppVariables.hadishSaveLists.length -
                                          1);
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
              title: "لا يوجد أحاديث مضافه",
            ),
          );
        },
      ),
    );
  }
}
