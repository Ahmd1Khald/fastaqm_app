import 'DesignationInfo.dart';

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
