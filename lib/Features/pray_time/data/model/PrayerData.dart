class PrayerDataModel {
  final int code;
  final String status;
  final Map<String, dynamic> data;

  PrayerDataModel({
    required this.code,
    required this.status,
    required this.data,
  });

  factory PrayerDataModel.fromJson(Map<String, dynamic> json) {
    return PrayerDataModel(
      code: json['code'],
      status: json['status'],
      data: Map<String, dynamic>.from(json['data']),
    );
  }
}
