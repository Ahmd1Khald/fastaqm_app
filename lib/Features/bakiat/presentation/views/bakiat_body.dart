import 'package:fastaqm_app/Core/constatnts/app_strings.dart';
import 'package:fastaqm_app/Core/constatnts/assets_manager.dart';
import 'package:fastaqm_app/Core/constatnts/colors.dart';
import 'package:fastaqm_app/Core/constatnts/variables.dart';
import 'package:fastaqm_app/Core/helpers/cachehelper.dart';
import 'package:fastaqm_app/Core/widgets/custom_app_bar.dart';
import 'package:fastaqm_app/Features/bakiat/presentation/views/widgets/custom_background.dart';
import 'package:fastaqm_app/Features/bakiat/presentation/views/widgets/custom_bakiat.dart';
import 'package:flutter/material.dart';

class BakiatScreen extends StatefulWidget {
  const BakiatScreen({Key? key}) : super(key: key);

  @override
  State<BakiatScreen> createState() => _BakiatScreenState();
}

class _BakiatScreenState extends State<BakiatScreen> {
  bool isDelete = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CustomBackground(),
            CustomBakiat(text: "سبحان الله", index: 1),
            CustomBakiat(text: "الحمد لله", index: 2),
            CustomBakiat(text: "لا إله إلا الله", index: 3),
            CustomBakiat(text: "الله أكبر", index: 4),
            CustomBakiat(text: "أستغفر الله", index: 5),
            SizedBox(
              height: AppVariables.appSize(context).width * 0.07,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10),
              child: Container(
                width: AppVariables.appSize(context).width * 0.8,
                height: AppVariables.appSize(context).width * 0.093,
                decoration: BoxDecoration(
                  color: MyColors.lightBrown,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Dismissible(
                  // onDismissed: (direction) {
                  //
                  // },
                  behavior: HitTestBehavior.deferToChild,
                  confirmDismiss: (direction) async {
                    print("--------------------");
                    print(direction);
                    setState(() {
                      isDelete = false;
                      CacheHelper.removeData(key: AppStrings.bakiat1Key);
                      CacheHelper.removeData(key: AppStrings.bakiat2Key);
                      CacheHelper.removeData(key: AppStrings.bakiat3Key);
                      CacheHelper.removeData(key: AppStrings.bakiat4Key);
                      CacheHelper.removeData(key: AppStrings.bakiat5Key);
                    });
                    return false;
                  },
                  direction: DismissDirection.endToStart,
                  key: const Key("value"),
                  background: Container(
                    width: AppVariables.appSize(context).width * 0.8,
                    height: AppVariables.appSize(context).width * 0.093,
                    decoration: BoxDecoration(
                      color: MyColors.darkBrown,
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Image.asset(
                        AssetsManager.basketIcon,
                        color:
                            isDelete ? MyColors.lightBrown : MyColors.darkBrown,
                        width: AppVariables.appSize(context).width * 0.1,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
