import 'dart:math';

import 'package:fastaqm_app/Core/constatnts/assets_manager.dart';
import 'package:fastaqm_app/Core/constatnts/colors.dart';
import 'package:fastaqm_app/Core/constatnts/variables.dart';
import 'package:fastaqm_app/Core/widgets/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';

class QiblahWidget extends StatefulWidget {
  const QiblahWidget({super.key});

  @override
  State<QiblahWidget> createState() => _QiblahWidgetState();
}

Animation<double>? animation;
AnimationController? _animationController;
double begin = 0.0;

class _QiblahWidgetState extends State<QiblahWidget>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 450));
    animation = Tween(begin: 0.0, end: 0.0).animate(_animationController!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder(
          stream: FlutterQiblah.qiblahStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CustomLoadingPage();
            }

            final qiblahDirection = snapshot.data;
            animation = Tween(
                    begin: begin,
                    end: (qiblahDirection!.qiblah * (pi / 180) * -1))
                .animate(_animationController!);
            begin = (qiblahDirection.qiblah * (pi / 180) * -1);
            _animationController!.forward(from: 0);

            return Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${qiblahDirection.direction.toInt()}°",
                      style: TextStyle(
                          color: qiblahDirection.direction.toInt() == 122 ||
                                  qiblahDirection.direction.toInt() == 121 ||
                                  qiblahDirection.direction.toInt() == 123 ||
                                  qiblahDirection.direction.toInt() == 124 ||
                                  qiblahDirection.direction.toInt() == 125
                              ? Colors.green
                              : MyColors.darkBrown,
                          fontSize: 22),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                        height: AppVariables.appSize(context).height * 0.33,
                        child: AnimatedBuilder(
                          animation: animation!,
                          builder: (context, child) => Transform.rotate(
                              angle: animation!.value,
                              child: Image.asset(
                                AssetsManager.qiblaImage,
                                //color: MyColors.darkBrown,
                              )),
                        ))
                  ]),
            );
          },
        ),
      ),
    );
  }
}
