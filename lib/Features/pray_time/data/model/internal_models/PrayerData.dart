class PrayerData {
  final int code;
  final String status;
  final Map<String, dynamic> data;

  PrayerData({
    required this.code,
    required this.status,
    required this.data,
  });

  factory PrayerData.fromJson(Map<String, dynamic> json) {
    return PrayerData(
      code: json['code'],
      status: json['status'],
      data: Map<String, dynamic>.from(json['data']),
    );
  }
}
