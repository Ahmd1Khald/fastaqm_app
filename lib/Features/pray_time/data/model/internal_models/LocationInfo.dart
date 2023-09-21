class LocationInfo {
  final double latitude;
  final double longitude;

  LocationInfo({
    required this.latitude,
    required this.longitude,
  });

  factory LocationInfo.fromJson(Map<String, dynamic> json) {
    return LocationInfo(
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}
