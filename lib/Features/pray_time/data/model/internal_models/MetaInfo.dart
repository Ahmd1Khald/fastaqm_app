import 'MethodInfo.dart';

class MetaInfo {
  final double latitude;
  final double longitude;
  final String timezone;
  final MethodInfo method;
  final String latitudeAdjustmentMethod;
  final String midnightMode;
  final String school;
  final Map<String, int> offset;

  MetaInfo({
    required this.latitude,
    required this.longitude,
    required this.timezone,
    required this.method,
    required this.latitudeAdjustmentMethod,
    required this.midnightMode,
    required this.school,
    required this.offset,
  });

  factory MetaInfo.fromJson(Map<String, dynamic> json) {
    return MetaInfo(
      latitude: json['latitude'],
      longitude: json['longitude'],
      timezone: json['timezone'],
      method: MethodInfo.fromJson(json['method']),
      latitudeAdjustmentMethod: json['latitudeAdjustmentMethod'],
      midnightMode: json['midnightMode'],
      school: json['school'],
      offset: Map<String, int>.from(json['offset']),
    );
  }
}
