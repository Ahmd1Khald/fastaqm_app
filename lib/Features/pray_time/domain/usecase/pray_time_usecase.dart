import 'package:dartz/dartz.dart';

import '../../../../Core/error/failure.dart';
import '../../../../Core/services/use_cases.dart';
import '../../data/model/PrayerData.dart';
import '../repository/base_pray_repository.dart';

class PrayTimeUseCase extends NoParam {
  final BasePrayRepository basePrayRepository;

  PrayTimeUseCase(this.basePrayRepository);

  Future<Either<Failure, PrayerDataModel>> execute({
    required String country,
    required String date,
  }) async {
    return await basePrayRepository.fetchPrayTime(country: country, date: date);
  }
}
