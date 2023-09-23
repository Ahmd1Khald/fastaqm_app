import 'package:fastaqm_app/Core/constatnts/colors.dart';
import 'package:fastaqm_app/Core/widgets/custom_app_bar.dart';
import 'package:fastaqm_app/Features/azkar/presentation/views/widgets/azkar_masaa.dart';
import 'package:fastaqm_app/Features/azkar/presentation/views/widgets/azkar_sabah.dart';
import 'package:fastaqm_app/Features/azkar/presentation/views/widgets/azkar_sleep.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Core/constatnts/variables.dart';
import '../controller/azkar_cubit.dart';

class AzkarScreen extends StatelessWidget {
  const AzkarScreen({Key? key}) : super(key: key);

  List<Widget> azkar(index) {
    List<Widget> azkars = [
      AzkarSabah(
        containerColor: AppVariables.azkarSelected == index
            ? MyColors.darkBrown
            : MyColors.lightBrown,
        iconColor: AppVariables.azkarSelected == index
            ? MyColors.lightBrown
            : MyColors.darkBrown,
      ),
      AzkarMasaa(
        containerColor: AppVariables.azkarSelected == index
            ? MyColors.darkBrown
            : MyColors.lightBrown,
        iconColor: AppVariables.azkarSelected == index
            ? MyColors.lightBrown
            : MyColors.darkBrown,
      ),
      AzkarSleep(
        containerColor: AppVariables.azkarSelected == index
            ? MyColors.darkBrown
            : MyColors.lightBrown,
        iconColor: AppVariables.azkarSelected == index
            ? MyColors.lightBrown
            : MyColors.darkBrown,
      ),
    ];
    return azkars;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AzkarCubit()..fetchAzkarData(),
      child: BlocConsumer<AzkarCubit, AzkarState>(
        listener: (context, state) {},
        builder: (context, state) {
          AzkarCubit cubit = AzkarCubit.get(context);
          return Scaffold(
            appBar: customAppBar(context),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SizedBox(
                    height: AppVariables.appSize(context).width * 0.2,
                    child: ListView.separated(
                      itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          cubit.changeSelectedAzkarIcon(index);
                        },
                        child: azkar(index)[index],
                      ),
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (context, index) => const SizedBox(
                        width: 10,
                      ),
                      itemCount: azkar(-1).length,
                    ),
                  ),
                ),
                Slider(
                  value: 10,
                  min: 5,
                  max: 20,
                  divisions: 6,
                  allowedInteraction: SliderInteraction.slideOnly,
                  activeColor: MyColors.darkBrown,
                  inactiveColor: MyColors.lightBrown,
                  onChanged: (value) {},
                ),
              ],
            ),
          );
        },
      ),
    );
    ;
  }
}
