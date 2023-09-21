import 'LocationInfo.dart';

class MethodInfo {
  final int id;
  final String name;
  final dynamic params;
  final LocationInfo location;

  MethodInfo({
    required this.id,
    required this.name,
    required this.params,
    required this.location,
  });

  factory MethodInfo.fromJson(Map<String, dynamic> json) {
    return MethodInfo(
      id: json['id'],
      name: json['name'],
      params: json['params'],
      location: LocationInfo.fromJson(json['location']),
    );
  }
}
