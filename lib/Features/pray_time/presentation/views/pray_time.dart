import 'package:fastaqm_app/Features/pray_time/presentation/views/widgets/backgraound_widget.dart';
import 'package:fastaqm_app/Features/pray_time/presentation/views/widgets/date_widget.dart';
import 'package:flutter/material.dart';

class PrayTimeScreen extends StatelessWidget {
  const PrayTimeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            BackGroundWidget(),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                DateWidget(
                  dayName: 'الجمعة',
                  dayNum: '12',
                  monthName: 'ذي الحجة',
                  dateNum: '1445',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
