import 'package:fastaqm_app/Features/saves/presentation/controller/saves_cubit.dart';
import 'package:flutter/material.dart';

import '../../../../../../Core/constatnts/app_functions.dart';
import '../../../../../../Core/constatnts/colors.dart';

class DuaaSavesIconsButton extends StatelessWidget {
  const DuaaSavesIconsButton({
    Key? key,
    required this.duaa,
    required this.category,
    required this.cubit,
  }) : super(key: key);
  final String duaa;
  final String category;
  final SavesCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 90,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            backgroundColor: MyColors.lightBrown,
            radius: 35,
            child: MaterialButton(
              onPressed: () {
                AppFunctions.shareDuaa(duaa);
              },
              splashColor: MyColors.darkBrown,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
              child: const Center(
                child: Icon(
                  Icons.share,
                  color: MyColors.darkBrown,
                  size: 40,
                ),
              ),
            ),
          ),
          CircleAvatar(
            backgroundColor: cubit.ssInDuaaSavedList(duaa: duaa)
                ? MyColors.darkBrown
                : MyColors.lightBrown,
            radius: 35,
            child: MaterialButton(
              onPressed: () {
                cubit.removedDuaaFromList(duaa: duaa);
              },
              splashColor: MyColors.darkBrown,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
              child: Center(
                child: Icon(
                  Icons.favorite,
                  color: cubit.ssInDuaaSavedList(duaa: duaa)
                      ? MyColors.lightBrown
                      : MyColors.darkBrown,
                  size: 40,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
