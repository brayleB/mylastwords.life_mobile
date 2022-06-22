class User {
  int? id;
  String? name;
  String? email;
  String? type;
  String? subcription;
  int? status;
  String? userImage;
  String? contact;
  String? address;
  String? token;

  User(
      {this.id,
      this.name,
      this.email,
      this.type,
      this.subcription,
      this.status,
      this.userImage,
      this.contact,
      this.address,
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
      userImage: json['user']['userImage'],
      contact: json['user']['contactNumber'],
      address: json['user']['address'],
      token: json['token'],
    );
  }
}
