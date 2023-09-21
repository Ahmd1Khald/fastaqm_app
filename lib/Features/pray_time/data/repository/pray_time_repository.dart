import 'package:dartz/dartz.dart';

import '../../../../Core/error/exceptions.dart';
import '../../../../Core/error/failure.dart';
import '../../domain/repository/base_pray_repository.dart';
import '../data_sources/pray_remote_data_source.dart';
import '../model/pray_time_model.dart';

class PrayRepository extends BasePrayRepository {
  final BasePrayTimeDataSource basePrayTimeDataSource;

  PrayRepository({
    required this.basePrayTimeDataSource,
  });

  @override
  Future<Either<Failure, PrayerTimings>> fetchPrayTime({
    required String country,
    required String date,
  }) async {
    try {
      final result = await basePrayTimeDataSource.getPrayTime(
        country: country,
        date: date,
      );
      //print(result);
      return Right(result);
    } on ServerException catch (failure) {
      print('failure  +++++++++++++++++++');
      print(failure);
      return Left(ServerFailure(failure.errorMessage));
    }
  }
}
