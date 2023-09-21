import '../../../../Core/constatnts/const_api.dart';
import '../../../../Core/error/exceptions.dart';
import '../../../../Core/helpers/dio_helper.dart';
import '../model/PrayerData.dart';

abstract class BasePrayTimeDataSource {
  Future<PrayerDataModel> getPrayTime({
    required String country,
    required String date,
  });
}

class PrayRemoteDataSource extends BasePrayTimeDataSource {
  @override
  Future<PrayerDataModel> getPrayTime({
    required String country,
    required String date,
  }) async {
    final response = await DioHelper.getData(
      endPoint: ApiConstant.getPrayTimeEndPoint,
      date: date,
      country: country,
    );
    if (response.statusCode == 200) {
      final jsonData = response.data;
      final PrayerDataModel apiData = PrayerDataModel.fromJson(jsonData);
      //print(apiData.data);
      return apiData;
    } else {
      print('error +++++++++++++++++++');
      throw const ServerException(errorMessage: 'Error while get Pray Time');
    }
  }
}
