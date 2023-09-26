import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fastaqm_app/Core/constatnts/assets_manager.dart';
import 'package:fastaqm_app/Features/qibla/presentation/views/qibla_body.dart';
import 'package:flutter/material.dart';

import '../../../../Core/constatnts/colors.dart';
import '../../../../Core/widgets/App_name.dart';
import '../../../home/presentation/views/home_body.dart';
import '../../../saves/presentation/views/saves_body.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  List<Widget> screens = [
    const SavesScreen(),
    const QiblaScreen(),
    const HomeScreen(),
  ];
  int _page = 2;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    const double navBarIconSize = 43;
    return Scaffold(
      bottomNavigationBar: buildCurvedNavigationBar(navBarIconSize),
      appBar: AppBar(
        title: const AppName(),
      ),
      body: screens[_page],
    );
  }

  CurvedNavigationBar buildCurvedNavigationBar(double navBarIconSize) {
    return CurvedNavigationBar(
      index: _page,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      color: MyColors.darkBrown,
      key: _bottomNavigationKey,
      items: <Widget>[
        Image.asset(
          AssetsManager.saveIcon,
          width: navBarIconSize,
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        Image.asset(
          AssetsManager.qiblaBottumIcon,
          width: navBarIconSize,
          //color: Theme.of(context).scaffoldBackgroundColor,
        ),
        Image.asset(
          AssetsManager.homeIcon,
          width: navBarIconSize + 13,
          fit: BoxFit.cover,
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
      ],
      onTap: (index) {
        setState(() {
          _page = index;
        });
      },
    );
  }
}
