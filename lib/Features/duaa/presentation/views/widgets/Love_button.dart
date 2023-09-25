import 'package:flutter/material.dart';

import '../../../../../Core/constatnts/colors.dart';

class IconsButton extends StatefulWidget {
  const IconsButton({Key? key}) : super(key: key);

  @override
  State<IconsButton> createState() => _IconsButtonState();
}

class _IconsButtonState extends State<IconsButton> {
  bool selected = false;
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
              onPressed: () {},
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
            backgroundColor:
                selected ? MyColors.darkBrown : MyColors.lightBrown,
            radius: 35,
            child: MaterialButton(
              onPressed: () {
                setState(() {
                  selected = !selected;
                });
              },
              splashColor: MyColors.darkBrown,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
              child: Center(
                child: Icon(
                  Icons.favorite,
                  color: selected ? MyColors.lightBrown : MyColors.darkBrown,
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
