import 'package:fastaqm_app/Core/constatnts/app_functions.dart';
import 'package:fastaqm_app/Core/widgets/customErrorContainer.dart';
import 'package:fastaqm_app/Features/duaa/presentation/views/widgets/custom_aya_widget.dart';
import 'package:fastaqm_app/Features/duaa/presentation/views/widgets/duaa_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../Core/constatnts/colors.dart';
import '../../../../Core/constatnts/variables.dart';
import '../../../../Core/widgets/custom_app_bar.dart';
import '../../../../Core/widgets/custom_loading.dart';
import '../controller/duaa_cubit.dart';

class DuaaScreen extends StatelessWidget {
  const DuaaScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DuaaCubit()..fetchDuaaData(),
      child: BlocConsumer<DuaaCubit, DuaaState>(
        listener: (context, state) {},
        builder: (context, state) {
          print(AppVariables.duaaSelected);
          DuaaCubit cubit = DuaaCubit.get(context);
          if (state is DuaaLoadingFetchData) {
            return Scaffold(
              appBar: customAppBar(context),
              body: const Center(
                child: CustomLoadingPage(),
              ),
            );
          }
          if (state is DuaaSuccessFetchData) {
            return Scaffold(
              appBar: customAppBar(context),
              body: SingleChildScrollView(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CustomAyaWidget(),
                  const SizedBox(
                    height: 20,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => BuildDuaaContainer(
                      context: context,
                      index: index,
                      list: cubit.duaaLists[index],
                    ),
                    itemCount: cubit.duaaLists.length,
                  ),
                ],
              )),
            );
          }
          return Scaffold(
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

class BuildDuaaContainer extends StatelessWidget {
  const BuildDuaaContainer(
      {Key? key,
      required this.context,
      required this.index,
      required this.list})
      : super(key: key);

  final BuildContext context;
  final int index;
  final List<Map<String, dynamic>> list;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: MyColors.darkBrown,
            radius: 39,
            child: MaterialButton(
              onPressed: () {
                AppFunctions.pushTo(
                    context: context,
                    screen: DuaaWidget(
                      list: list,
                    ));
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
          SizedBox(
            width: AppVariables.appSize(context).width * 0.06,
          ),
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Container(
                width: AppVariables.appSize(context).width * 0.6,
                height: AppVariables.appSize(context).width * 0.19,
                decoration: BoxDecoration(
                    color: MyColors.darkBrown,
                    borderRadius: BorderRadius.circular(30)),
              ),
              Container(
                width: AppVariables.appSize(context).width * 0.555,
                height: AppVariables.appSize(context).width * 0.172,
                decoration: BoxDecoration(
                    color: MyColors.lightBrown,
                    borderRadius: BorderRadius.circular(30)),
                child: Center(
                  child: Text(
                    list[0]["category"] == "الدعاء عند إفطار الصائم - الصوم"
                        ? "الدعاء عند الإفطار"
                        : list[0]["category"] ==
                                "الرُّقية الشرعية من القرآن الكريم"
                            ? "الرُّقية الشرعية"
                            : list[0]["category"] ==
                                    "دعاء دخول القرية أو البلدة"
                                ? "دعاء دخول البلدة"
                                : list[0]["category"] ==
                                        "دعاء دخول الخلاء - الحمام"
                                    ? "دعاء دخول الخلاء"
                                    : list[0]["category"] ==
                                            "دعاء لبس الثوب الجديد"
                                        ? "دعاء لبس ثوب جديد"
                                        : list[0]["category"],
                    textAlign: TextAlign.center,
                    style: GoogleFonts.noticiaText(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
