import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../Core/constatnts/colors.dart';
import '../../../../../Core/constatnts/variables.dart';
import '../../controller/azkar_cubit.dart';

class SliderWidget extends StatelessWidget {
  const SliderWidget({Key? key, required this.allCount, required this.current})
      : super(key: key);

  final int allCount;
  final int current;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AzkarCubit, AzkarState>(
      listener: (context, state) {},
      builder: (context, state) {
        AzkarCubit cubit = AzkarCubit.get(context);
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: AppVariables.appSize(context).width * 0.7,
              child: Slider(
                value: AppVariables.azkarSelected == 0
                    ? cubit.sabahIndex.toDouble()
                    : AppVariables.azkarSelected == 1
                        ? cubit.masaaIndex.toDouble()
                        : AppVariables.azkarSelected == 2
                            ? cubit.nomIndex.toDouble()
                            : AppVariables.azkarSelected == 3
                                ? cubit.salaaIndex.toDouble()
                                : 0,
                min: 0,
                max: AppVariables.azkarSelected == 0
                    ? cubit.azkarAlsabah.length.toDouble() - 1
                    : AppVariables.azkarSelected == 1
                        ? cubit.azkarAlmasaa.length.toDouble() - 1
                        : AppVariables.azkarSelected == 2
                            ? cubit.azkarAlnom.length.toDouble() - 1
                            : AppVariables.azkarSelected == 3
                                ? cubit.azkarAlsalaa.length.toDouble() - 1
                                : 0,
                divisions: allCount - 1,
                autofocus: false,
                activeColor: MyColors.darkBrown,
                inactiveColor: MyColors.lightBrown,
                secondaryActiveColor: MyColors.darkBrown,
                onChanged: null,
              ),
            ),
            SizedBox(
              width: AppVariables.appSize(context).width * 0.21,
              child: Text(
                '$current/${allCount - 1}',
                style: TextStyle(
                  fontSize: 22.sp,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
