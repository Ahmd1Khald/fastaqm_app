import 'package:fastaqm_app/Core/constatnts/variables.dart';
import 'package:fastaqm_app/Features/duaa/data/model/duaa_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../Core/constatnts/app_functions.dart';
import '../../../../../Core/constatnts/app_strings.dart';
import '../../../../../Core/constatnts/colors.dart';
import '../../../../../Core/helpers/cachehelper.dart';

class IconsButton extends StatefulWidget {
  const IconsButton({
    Key? key,
    required this.duaa,
    required this.category,
  }) : super(key: key);
  final String duaa;
  final String category;

  @override
  State<IconsButton> createState() => _IconsButtonState();
}

class _IconsButtonState extends State<IconsButton> {
  List<String>? listOfFavKeys =
      CacheHelper.getFavDate(key: AppStrings.duaaSavesKey) ?? [];
  bool ssInSavedList({required String id}) {
    listOfFavKeys = CacheHelper.getFavDate(key: AppStrings.duaaSavesKey) ?? [];
    print("listOfFavKeys");
    print(listOfFavKeys);
    if ((listOfFavKeys!.where((element) => element.length == id.length))
        .isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  List<String> semiFavKeysList = [];

  void saveToList({required DuaaModel model}) {
    //ssInSavedList(id: model.zekr);
    for (String value in listOfFavKeys!) {
      semiFavKeysList.add(value);
    }
    print(semiFavKeysList);
    if (semiFavKeysList.contains(model.zekr)) {
      semiFavKeysList.removeWhere((element) => element == model.zekr);
      CacheHelper.saveListOfStrings(
        key: AppStrings.duaaSavesKey,
        value: semiFavKeysList,
      );
      print(semiFavKeysList);
      print("removed");
    } else {
      semiFavKeysList.add(model.zekr);
      CacheHelper.saveListOfStrings(
        key: AppStrings.duaaSavesKey,
        value: semiFavKeysList,
      );
      print(semiFavKeysList);
      print("added");
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppVariables.appSize(context).width * 0.55,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            backgroundColor: MyColors.lightBrown,
            radius: 35.sp,
            child: MaterialButton(
              onPressed: () {
                AppFunctions.shareDuaa(widget.duaa);
              },
              splashColor: MyColors.darkBrown,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
              child: Center(
                child: Icon(
                  Icons.share,
                  color: MyColors.darkBrown,
                  size: 35.sp,
                ),
              ),
            ),
          ),
          CircleAvatar(
            backgroundColor: ssInSavedList(id: widget.duaa)
                ? MyColors.darkBrown
                : MyColors.lightBrown,
            radius: 35.sp,
            child: MaterialButton(
              onPressed: () {
                saveToList(
                    model: DuaaModel(
                  category: widget.category,
                  zekr: widget.duaa,
                ));
              },
              splashColor: MyColors.darkBrown,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
              child: Center(
                child: Icon(
                  Icons.favorite,
                  color: ssInSavedList(
                    id: widget.duaa,
                  )
                      ? MyColors.lightBrown
                      : MyColors.darkBrown,
                  size: 35.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
