import 'package:flutter/material.dart';

import '../../../../../Core/constatnts/colors.dart';
import '../../../../../Core/constatnts/variables.dart';

class SliderWidget extends StatefulWidget {
  const SliderWidget({Key? key, required this.allCount, required this.current})
      : super(key: key);

  final int allCount;
  final int current;

  @override
  State<SliderWidget> createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: AppVariables.appSize(context).width * 0.75,
          child: Slider(
            value: curSliderValue,
            min: 0,
            max: widget.allCount.toDouble(),
            divisions: widget.allCount,
            allowedInteraction: SliderInteraction.slideOnly,
            activeColor: MyColors.darkBrown,
            inactiveColor: MyColors.lightBrown,
            onChanged: (value) {
              setState(() {
                curSliderValue = value;
              });
            },
          ),
        ),
        SizedBox(
          width: AppVariables.appSize(context).width * 0.15,
          child: Text(
            '${widget.current}/${widget.allCount}',
            style: const TextStyle(
              fontSize: 24,
            ),
          ),
        ),
      ],
    );
  }
}
