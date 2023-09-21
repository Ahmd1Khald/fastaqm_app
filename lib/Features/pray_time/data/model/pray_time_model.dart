class PrayerTimings {
  final String fajr;
  final String sunrise;
  final String dhuhr;
  final String asr;
  final String sunset;
  final String maghrib;
  final String isha;
  final String imsak;
  final String midnight;
  final String firstthird;
  final String lastthird;

  PrayerTimings({
    required this.fajr,
    required this.sunrise,
    required this.dhuhr,
    required this.asr,
    required this.sunset,
    required this.maghrib,
    required this.isha,
    required this.imsak,
    required this.midnight,
    required this.firstthird,
    required this.lastthird,
  });

  factory PrayerTimings.fromJson(Map<String, dynamic> json) {
    return PrayerTimings(
      fajr: json['Fajr'],
      sunrise: json['Sunrise'],
      dhuhr: json['Dhuhr'],
      asr: json['Asr'],
      sunset: json['Sunset'],
      maghrib: json['Maghrib'],
      isha: json['Isha'],
      imsak: json['Imsak'],
      midnight: json['Midnight'],
      firstthird: json['Firstthird'],
      lastthird: json['Lastthird'],
    );
  }
}

class HijriDate {
  final String date;
  final String format;
  final String day;
  final Map<String, String> weekday;
  final Map<String, String> month;
  final String year;
  final DesignationInfo designation;
  final List<dynamic> holidays;

  HijriDate({
    required this.date,
    required this.format,
    required this.day,
    required this.weekday,
    required this.month,
    required this.year,
    required this.designation,
    required this.holidays,
  });

  factory HijriDate.fromJson(Map<String, dynamic> json) {
    return HijriDate(
      date: json['date'],
      format: json['format'],
      day: json['day'],
      weekday: Map<String, String>.from(json['weekday']),
      month: Map<String, String>.from(json['month']),
      year: json['year'],
      designation: DesignationInfo.fromJson(json['designation']),
      holidays: List<dynamic>.from(json['holidays']),
    );
  }
}

class GregorianDate {
  final String date;
  final String format;
  final String day;
  final Map<String, String> weekday;
  final Map<String, String> month;
  final String year;
  final DesignationInfo designation;

  GregorianDate({
    required this.date,
    required this.format,
    required this.day,
    required this.weekday,
    required this.month,
    required this.year,
    required this.designation,
  });

  factory GregorianDate.fromJson(Map<String, dynamic> json) {
    return GregorianDate(
      date: json['date'],
      format: json['format'],
      day: json['day'],
      weekday: Map<String, String>.from(json['weekday']),
      month: Map<String, String>.from(json['month']),
      year: json['year'],
      designation: DesignationInfo.fromJson(json['designation']),
    );
  }
}

class DesignationInfo {
  final String abbreviated;
  final String expanded;

  DesignationInfo({
    required this.abbreviated,
    required this.expanded,
  });

  factory DesignationInfo.fromJson(Map<String, dynamic> json) {
    return DesignationInfo(
      abbreviated: json['abbreviated'],
      expanded: json['expanded'],
    );
  }
}

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
