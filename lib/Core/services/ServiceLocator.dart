import 'package:get_it/get_it.dart';

import '../../Features/pray_time/data/data_sources/pray_remote_data_source.dart';
import '../../Features/pray_time/data/repository/pray_time_repository.dart';

final getIt = GetIt.instance;

void setUpServiceLocator() {
  getIt.registerSingleton<PrayRepository>(
    PrayRepository(
      basePrayTimeDataSource: PrayRemoteDataSource(),
    ),
  );
}
