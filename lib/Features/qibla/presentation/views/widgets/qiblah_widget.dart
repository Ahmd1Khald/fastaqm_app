import 'dart:math';

import 'package:fastaqm_app/Core/constatnts/assets_manager.dart';
import 'package:fastaqm_app/Core/constatnts/colors.dart';
import 'package:fastaqm_app/Core/constatnts/variables.dart';
import 'package:fastaqm_app/Core/widgets/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';

class QiblahWidget extends StatefulWidget {
  const QiblahWidget({Key? key}) : super(key: key);

  @override
  State<QiblahWidget> createState() => _QiblahWidgetState();
}

class _QiblahWidgetState extends State<QiblahWidget>
    with SingleTickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _animationController;
  double _begin = 0.0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
    );
    _animation = Tween(begin: 0.0, end: 0.0).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder<QiblahDirection>(
          stream: FlutterQiblah.qiblahStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CustomLoadingPage();
            }

            final qiblahDirection = snapshot.data;
            if (qiblahDirection != null) {
              final double newEnd = qiblahDirection.qiblah * (pi / 180) * -1;

              _animation = Tween(
                begin: _begin,
                end: newEnd,
              ).animate(_animationController);

              _begin = newEnd;
              _animationController.forward(from: 0);
            }

            final int directionDegree = qiblahDirection?.direction.toInt() ?? 0;
            final bool isWithinRange = [].contains(directionDegree);

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "$directionDegree°",
                    style: TextStyle(
                      color: isWithinRange ? Colors.green : MyColors.darkBrown,
                      fontSize: 22,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: AppVariables.appSize(context).height * 0.33,
                    child: AnimatedBuilder(
                      animation: _animation,
                      builder: (context, child) => Transform.rotate(
                        angle: _animation.value,
                        child: Image.asset(
                          AssetsManager.qiblaImage,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
