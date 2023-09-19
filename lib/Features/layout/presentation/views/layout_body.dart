import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fastaqm_app/Core/constatnts/assets_manager.dart';
import 'package:flutter/material.dart';

import '../../../../Core/constatnts/colors.dart';
import '../../../home/presentation/views/home_body.dart';
import '../../../saves/presentation/views/saves_body.dart';
import '../../../settings/presentation/views/settings_body.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({Key? key}) : super(key: key);

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  List<Widget> screens = const [
    SavesScreen(),
    SettingsScreen(),
    HomeScreen(),
  ];
  int _page = 2;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    const double navBarIconSize = 43;
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          index: _page,
          backgroundColor: MyColors.whiteColor,
          color: MyColors.darkBrown,
          key: _bottomNavigationKey,
          items: <Widget>[
            Image.asset(
              AssetsManager.saveIcon,
              width: navBarIconSize,
              color: MyColors.whiteColor,
            ),
            const Icon(
              Icons.settings,
              size: navBarIconSize,
              color: MyColors.whiteColor,
            ),
            Image.asset(
              AssetsManager.homeIcon,
              width: navBarIconSize + 13,
              fit: BoxFit.cover,
              color: MyColors.whiteColor,
            ),
          ],
          onTap: (index) {
            setState(() {
              _page = index;
            });
          },
        ),
        body: screens[_page]);
  }
}
