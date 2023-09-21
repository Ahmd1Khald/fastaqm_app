import 'package:fastaqm_app/Core/constatnts/assets_manager.dart';
import 'package:fastaqm_app/Core/constatnts/variables.dart';
import 'package:fastaqm_app/Features/pray_time/presentation/views/widgets/backgraound_widget.dart';
import 'package:fastaqm_app/Features/pray_time/presentation/views/widgets/date_widget.dart';
import 'package:fastaqm_app/Features/pray_time/presentation/views/widgets/time_wiget.dart';
import 'package:flutter/material.dart';

class PrayTimeScreen extends StatelessWidget {
  const PrayTimeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double timeNow = DateTime.now().hour.toDouble();
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            const BackGroundWidget(),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const DateWidget(
                  dayName: 'الجمعة',
                  dayNum: '12',
                  monthName: 'ذي الحجة',
                  dateNum: '1445',
                ),
                TimeWidget(
                  prayName: 'الفجر',
                  timeNow: timeNow,
                  prayTime: "04:23",
                  prayHour: 4,
                ),
                TimeWidget(
                  prayName: 'الشروق',
                  timeNow: timeNow,
                  prayTime: "06:32",
                  prayHour: 6,
                ),
                TimeWidget(
                  prayName: 'الظهر',
                  timeNow: timeNow,
                  prayTime: "12:49",
                  prayHour: 12,
                ),
                TimeWidget(
                  prayName: 'العصر',
                  timeNow: timeNow,
                  prayTime: "16:15",
                  prayHour: 16,
                ),
                TimeWidget(
                  prayName: 'المغرب',
                  timeNow: timeNow,
                  prayTime: "19:06",
                  prayHour: 19,
                ),
                TimeWidget(
                  prayName: 'العشاء',
                  timeNow: timeNow,
                  prayTime: "20:36",
                  prayHour: 20,
                ),
                Image.asset(
                  AssetsManager.prayIcon,
                  fit: BoxFit.cover,
                  width: AppVariables.appSize(context).width * 0.7,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
