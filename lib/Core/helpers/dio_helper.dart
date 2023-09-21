import 'package:dio/dio.dart';

import '../constatnts/const_api.dart';

class DioHelper {
  static late Dio dio;

  static void init() {
    dio = Dio(BaseOptions(
      baseUrl: ApiConstant.baseUrl,
      receiveDataWhenStatusError: true,
    ));
  }

  static Future<Response> getData({
    required String endPoint,
    required String date,
    required String country,
    String city = "",
  }) async {
    return await dio.get(
      '${ApiConstant.baseUrl}$endPoint$date?city=$city&country=$country',
    );
  }
}
