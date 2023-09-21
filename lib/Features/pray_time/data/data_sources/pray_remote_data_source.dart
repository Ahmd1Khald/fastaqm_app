import '../../../../Core/constatnts/const_api.dart';
import '../../../../Core/error/exceptions.dart';
import '../../../../Core/helpers/dio_helper.dart';
import '../model/pray_time_model.dart';

abstract class BasePrayTimeDataSource {
  Future<PrayerTimings> getPrayTime({
    required String country,
    required String date,
  });
}

class PrayRemoteDataSource extends BasePrayTimeDataSource {
  @override
  Future<PrayerTimings> getPrayTime({
    required String country,
    required String date,
  }) async {
    final response = await DioHelper.getData(
      endPoint: ApiConstant.getPrayTimeEndPoint,
      date: date,
      country: country,
    );
    if (response.statusCode == 200) {
      //var apiData = await response.data;
      print(response.data);
      return response.data;
    } else {
      print('error +++++++++++++++++++');
      throw const ServerException(errorMessage: 'Error while get Pray Time');
    }
  }
}
