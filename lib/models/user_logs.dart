class UserLogModel {
  int? id;
  int? userId;
  String? date;
  String? time;
  String? location;

  UserLogModel({
    this.id,
    this.userId,
    this.date,
    this.time,
    this.location,
  });

  //function to convrt json data to user model
  factory UserLogModel.fromJson(Map<String, dynamic> json) {
    return UserLogModel(
      id: json['id'],
      userId: json['user_id'],
      date: json['date'],
      time: json['time'],
      location: json['location'],
    );
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "user_id": userId,
        "date": date,
        "time": time,
        "location": location,
      };
}
