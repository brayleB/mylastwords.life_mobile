class AlarmInfo {
  int? id;
  String? title;
  DateTime? alarmDateTime;
  String? alarmOnOff;
  String? repeat;
  String? sound;
  AlarmInfo({
    this.id,
    this.title,
    this.alarmDateTime,
    this.alarmOnOff,
    this.repeat,
    this.sound,
  });

  factory AlarmInfo.fromMap(Map<String, dynamic> json) => AlarmInfo(
        id: json["id"],
        title: json["title"],
        alarmDateTime: DateTime.parse(json["alarmDateTime"]),
        alarmOnOff: json["alarmOnOff"],
        repeat: json["repeat"],
        sound: json["sound"]
      );
  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "alarmDateTime": alarmDateTime!.toIso8601String(),
        "alarmOnOff": alarmOnOff,
        "repeat": repeat,
        "sound": sound
      };
}