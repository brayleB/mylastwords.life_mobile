class User {
  int? id;
  String? name;
  String? email;
  String? type;
  String? subcription;
  int? status;
  String? token;

  User(
      {this.id,
      this.name,
      this.email,
      this.type,
      this.subcription,
      this.status,
      this.token});

  //function to convrt json data to user model
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['user']['id'],
      name: json['user']['name'],
      email: json['user']['email'],
      type: json['user']['type'],
      subcription: json['user']['subcription'],
      status: json['user']['status'],
      token: json['token'],
    );
  }
}
