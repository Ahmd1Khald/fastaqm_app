import 'package:animated_button/animated_button.dart';
import 'package:fastaqm_app/Core/constatnts/app_strings.dart';
import 'package:fastaqm_app/Core/constatnts/colors.dart';
import 'package:fastaqm_app/Core/constatnts/variables.dart';
import 'package:fastaqm_app/Core/helpers/cachehelper.dart';
import 'package:fastaqm_app/Core/widgets/custom_app_bar.dart';
import 'package:fastaqm_app/Features/bakiat/presentation/views/widgets/custom_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

class BakiatScreen extends StatefulWidget {
  const BakiatScreen({Key? key}) : super(key: key);

  @override
  State<BakiatScreen> createState() => _BakiatScreenState();
}

class _BakiatScreenState extends State<BakiatScreen>
    with SingleTickerProviderStateMixin {
  bool isDelete = false;
  int selectedItem = 0;
  int index0 = CacheHelper.getDate(key: AppStrings.bakiat1Key) ?? 0;
  int index1 = CacheHelper.getDate(key: AppStrings.bakiat2Key) ?? 0;
  int index2 = CacheHelper.getDate(key: AppStrings.bakiat3Key) ?? 0;
  int index3 = CacheHelper.getDate(key: AppStrings.bakiat4Key) ?? 0;
  int index4 = CacheHelper.getDate(key: AppStrings.bakiat5Key) ?? 0;
  int index5 = CacheHelper.getDate(key: AppStrings.bakiat6Key) ?? 0;
  int index6 = CacheHelper.getDate(key: AppStrings.bakiat7Key) ?? 0;

  final List<IconData> options = [
    Icons.settings,
    Icons.person,
    Icons.favorite,
    Icons.home,
    Icons.star,
  ];

  late Animation<Alignment> firstAnim;
  late Animation<Alignment> secondAnim;
  late Animation<Alignment> thirdAnim;
  late Animation<Alignment> fourthAnim;
  late Animation<Alignment> fifthAnim;
  late Animation<double> verticalPadding;
  late AnimationController controller;
  final duration = const Duration(milliseconds: 190);

  Widget getItem(String source, VoidCallback fnc) {
    final size1 = 68.0.sp;
    final size2 = 45.0.sp;
    return InkWell(
      onTap: fnc,
      splashColor: MyColors.darkBrown,
      child: Container(
        width: size1,
        height: size2,
        decoration: const BoxDecoration(
          color: MyColors.lightBrown,
          borderRadius: BorderRadius.all(
            Radius.circular(40),
          ),
        ),
        child: Center(
            child: Text(
          source,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        )),
      ),
    );
  }

  Widget buildPrimaryItem(IconData source) {
    final size1 = 68.0.sp;
    final size2 = 45.0.sp;
    return Container(
      width: size1,
      height: size2,
      decoration: BoxDecoration(
        color: MyColors.lightBrown,
        borderRadius: const BorderRadius.all(
          Radius.circular(16),
        ),
        boxShadow: [
          BoxShadow(
              color: MyColors.lightBrown.withOpacity(0.1),
              blurRadius: verticalPadding.value),
        ],
      ),
      child: Icon(
        source,
        color: MyColors.darkBrown,
        size: 27.sp,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    dataIndex = [
      index0,
      index1,
      index2,
      index3,
      index4,
      index5,
      index6,
    ];
    controller = AnimationController(vsync: this, duration: duration);

    final anim = CurvedAnimation(parent: controller, curve: Curves.linear);
    firstAnim =
        Tween<Alignment>(begin: Alignment.centerRight, end: Alignment.topRight)
            .animate(anim);
    secondAnim =
        Tween<Alignment>(begin: Alignment.centerRight, end: Alignment.topLeft)
            .animate(anim);
    thirdAnim = Tween<Alignment>(
            begin: Alignment.centerRight, end: Alignment.centerLeft)
        .animate(anim);
    fourthAnim = Tween<Alignment>(
            begin: Alignment.centerRight, end: Alignment.bottomLeft)
        .animate(anim);
    fifthAnim = Tween<Alignment>(
            begin: Alignment.centerRight, end: Alignment.bottomRight)
        .animate(anim);
    verticalPadding = Tween<double>(begin: 0, end: 26).animate(anim);
  }

  List<int>? dataIndex;

  List<String> dataBakiat = [
    "أستغفر الله",
    "سبحان الله",
    "الحمد لله",
    "لا إله إلا الله",
    "الله أكبر",
    "اللهم صل على محمد",
    "سبحان الله وبحمده",
  ];
  Widget _buildItemList(BuildContext context, int index) {
    print("dataIndex $dataIndex");
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: AppVariables.appSize(context).width * 0.5,
          child: Container(
            width: AppVariables.appSize(context).width * 0.4,
            height: 70.h,
            decoration: BoxDecoration(
                color: selectedItem == index //&& index != data.length - 1
                    ? MyColors.lightBrown
                    : MyColors.appBackGroundColor,
                borderRadius: BorderRadius.circular(16)),
            child: Center(
              child: Text(
                dataBakiat[index],
                textAlign: TextAlign.center,
                style: GoogleFonts.noticiaText(
                  fontSize: 22.sp,
                  color: MyColors.darkBrown,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: customAppBar(context),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(
          left: 10.0,
        ),
        child: Container(
          width: 150.w,
          height: 190.h,
          margin: const EdgeInsets.only(right: 15),
          child: AnimatedBuilder(
            animation: controller,
            builder: (context, child) {
              return Stack(
                children: <Widget>[
                  Align(
                    alignment: secondAnim.value,
                    child: Container(
                      padding:
                          EdgeInsets.only(left: 37, top: verticalPadding.value),
                      child: getItem(
                        "الحالي",
                        () {
                          controller.reverse();
                          if (selectedItem == 0) {
                            CacheHelper.removeData(key: AppStrings.bakiat1Key);
                          }
                          if (selectedItem == 1) {
                            CacheHelper.removeData(key: AppStrings.bakiat2Key);
                          }
                          if (selectedItem == 2) {
                            CacheHelper.removeData(key: AppStrings.bakiat3Key);
                          }
                          if (selectedItem == 3) {
                            CacheHelper.removeData(key: AppStrings.bakiat4Key);
                          }
                          if (selectedItem == 4) {
                            CacheHelper.removeData(key: AppStrings.bakiat5Key);
                          }
                          if (selectedItem == 5) {
                            CacheHelper.removeData(key: AppStrings.bakiat6Key);
                          }
                          if (selectedItem == 6) {
                            CacheHelper.removeData(key: AppStrings.bakiat7Key);
                          }
                          dataIndex![selectedItem] = 0;
                          setState(() {});
                        },
                      ),
                    ),
                  ),
                  Align(
                      alignment: fourthAnim.value,
                      child: Container(
                        padding: EdgeInsets.only(
                            left: 38, bottom: verticalPadding.value),
                        child: getItem(
                          "الكل",
                          () {
                            controller.reverse();
                            CacheHelper.removeData(key: AppStrings.bakiat1Key);
                            CacheHelper.removeData(key: AppStrings.bakiat2Key);
                            CacheHelper.removeData(key: AppStrings.bakiat3Key);
                            CacheHelper.removeData(key: AppStrings.bakiat4Key);
                            CacheHelper.removeData(key: AppStrings.bakiat5Key);
                            CacheHelper.removeData(key: AppStrings.bakiat6Key);
                            CacheHelper.removeData(key: AppStrings.bakiat7Key);
                            dataIndex = [0, 0, 0, 0, 0, 0, 0];
                            setState(() {});
                          },
                        ),
                      )),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        controller.isCompleted
                            ? controller.reverse()
                            : controller.forward();
                      },
                      child: buildPrimaryItem(
                        controller.isCompleted || controller.isAnimating
                            ? Icons.close
                            : Icons.delete,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CustomBackground(),
            Padding(
              padding: EdgeInsets.only(
                top: AppVariables.appSize(context).width * 0.15,
                bottom: AppVariables.appSize(context).width * 0.08,
              ),
              child: Container(
                height: AppVariables.appSize(context).width * 0.3,
                width: AppVariables.appSize(context).width,
                child: ScrollSnapList(
                  itemBuilder: _buildItemList,
                  itemSize: 180.sp,
                  dynamicItemSize: true,
                  initialIndex: selectedItem.toDouble(),
                  scrollPhysics: const ClampingScrollPhysics(),
                  //onReachEnd: () {},
                  background: MyColors.appBackGroundColor,
                  itemCount: dataBakiat.length,
                  reverse: true,
                  onItemFocus: (int) {
                    selectedItem = int;
                    setState(() {});
                    print(int);
                  },
                ),
              ),
            ),
            Container(
              width: AppVariables.appSize(context).width * 0.2,
              height: AppVariables.appSize(context).width * 0.13,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: MyColors.darkBrown,
                  )),
              child: Center(
                  child: Text(
                "${dataIndex![selectedItem]}".length > 5
                    ? "10k +"
                    : "${dataIndex![selectedItem]}",
                style: GoogleFonts.noticiaText(
                  fontSize: 22.sp,
                  color: MyColors.darkBrown,
                ),
              )),
            ),
            Padding(
              padding: EdgeInsets.only(
                  bottom: AppVariables.appSize(context).width * 0.08,
                  top: AppVariables.appSize(context).width * 0.08),
              child: AnimatedButton(
                onPressed: () {
                  dataIndex![selectedItem]++;
                  if (selectedItem == 0) {
                    CacheHelper.saveData(
                        key: AppStrings.bakiat1Key,
                        value: dataIndex![selectedItem]);
                  }
                  if (selectedItem == 1) {
                    CacheHelper.saveData(
                        key: AppStrings.bakiat2Key,
                        value: dataIndex![selectedItem]);
                  }
                  if (selectedItem == 2) {
                    CacheHelper.saveData(
                        key: AppStrings.bakiat3Key,
                        value: dataIndex![selectedItem]);
                  }
                  if (selectedItem == 3) {
                    CacheHelper.saveData(
                        key: AppStrings.bakiat4Key,
                        value: dataIndex![selectedItem]);
                  }
                  if (selectedItem == 4) {
                    CacheHelper.saveData(
                        key: AppStrings.bakiat5Key,
                        value: dataIndex![selectedItem]);
                  }
                  if (selectedItem == 5) {
                    CacheHelper.saveData(
                        key: AppStrings.bakiat6Key,
                        value: dataIndex![selectedItem]);
                  }
                  if (selectedItem == 6) {
                    CacheHelper.saveData(
                        key: AppStrings.bakiat7Key,
                        value: dataIndex![selectedItem]);
                  }
                  setState(() {});
                },
                enabled: true,
                color: MyColors.darkBrown,
                shadowDegree: ShadowDegree.light,
                shape: BoxShape.circle,
                height: AppVariables.appSize(context).width * 0.35,
                width: AppVariables.appSize(context).width * 0.35,
                child: Text(
                  '+',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 30.sp,
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
