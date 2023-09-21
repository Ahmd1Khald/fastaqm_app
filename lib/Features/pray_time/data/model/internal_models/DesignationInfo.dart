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
