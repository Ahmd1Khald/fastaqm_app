import 'package:dartz/dartz.dart';

import '../../../../Core/error/failure.dart';
import '../../data/model/pray_time_model.dart';

abstract class BasePrayRepository {
  Future<Either<Failure, PrayerTimings>> fetchPrayTime({
    required String country,
    required String date,
  });
}
