class AppleList {
  final String? appleID;
  final String? email;
  final String? name;  

  AppleList({
    this.appleID,
    this.email,
    this.name,    
  });

  //function to convrt json data to notes model
  factory AppleList.fromJson(Map<String, dynamic> json) {
    return AppleList(
      appleID: json["appleID"],
      email: json["email"],
      name: json["name"],  
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "appleID": appleID,
      "email": email,
      "name": name,     
    };
  }
}
class AppleAccsModel { 
  final List<AppleList> applelist;

  AppleAccsModel(
      {required this.applelist,    
    });

  factory AppleAccsModel.fromJson(Map<String, dynamic> data) {    
    final appledata = data['apple_accounts'] as List<dynamic>?;   
    final applelist = appledata != null     
        ? appledata
            .map((appledata) => AppleList.fromJson(appledata))     
            .toList()   
        : <AppleList>[];  
    return AppleAccsModel(
        applelist: applelist,              
        );
  }
}
