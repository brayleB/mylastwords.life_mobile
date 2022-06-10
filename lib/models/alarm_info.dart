class AlarmInfo {
  int? id;
  String? title;
  DateTime? alarmDateTime;
  String? alarmOnOff;

  AlarmInfo({
    this.id,
    this.title,
    this.alarmDateTime,
    this.alarmOnOff,
  });

  factory AlarmInfo.fromMap(Map<String, dynamic> json) => AlarmInfo(
        id: json["id"],
        title: json["title"],
        alarmDateTime: DateTime.parse(json["alarmDateTime"]),
        alarmOnOff: json["alarmOnOff"],
      );
  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "alarmDateTime": alarmDateTime!.toIso8601String(),
        "alarmOnOff": alarmOnOff,
      };
}