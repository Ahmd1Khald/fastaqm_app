import 'package:fastaqm_app/Core/constatnts/assets_manager.dart';
import 'package:fastaqm_app/Core/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Core/constatnts/colors.dart';
import '../../../../Core/constatnts/variables.dart';
import '../controller/azkar_cubit.dart';

class AzkarScreen extends StatelessWidget {
  const AzkarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AzkarCubit()..fetchAzkarData(),
      child: BlocConsumer<AzkarCubit, AzkarState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: customAppBar(context),
            body: Column(
              children: [
                Container(
                  width: AppVariables.appSize(context).width * 0.2,
                  height: AppVariables.appSize(context).width * 0.2,
                  decoration: BoxDecoration(
                    color: MyColors.lightBrown,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Center(
                    child: Image.asset(AssetsManager.sunIcon),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
