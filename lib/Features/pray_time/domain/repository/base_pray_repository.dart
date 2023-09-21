import 'package:dartz/dartz.dart';

import '../../../../Core/error/failure.dart';
import '../../data/model/PrayerData.dart';

abstract class BasePrayRepository {
  Future<Either<Failure, PrayerDataModel>> fetchPrayTime({
    required String country,
    required String date,
  });
}
