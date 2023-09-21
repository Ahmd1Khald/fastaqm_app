import 'DesignationInfo.dart';

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
