class GalleryList {
  final int? id;
  final int? userId;
  final String? title;  

  GalleryList({
    this.id,
    this.userId,
    this.title,    
  });

  //function to convrt json data to notes model
  factory GalleryList.fromJson(Map<String, dynamic> json) {
    return GalleryList(
      id: json["id"],
      userId: json["user_id"],
      title: json["title"],  
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "user_id": userId,
      "title": title,     
    };
  }
}
class GalleryModel {
  final int? id;
  final String? title;
  final List<GalleryList> gallerylist;

  GalleryModel(
      {required this.gallerylist,
      required this.id,
      required this.title,
    });

  factory GalleryModel.fromJson(Map<String, dynamic> data) {    
    final gallerydata = data['gallery'] as List<dynamic>?;   
    final gallerylist = gallerydata != null     
        ? gallerydata
            .map((gallerydata) => GalleryList.fromJson(gallerydata))     
            .toList()   
        : <GalleryList>[];  
    return GalleryModel(
        gallerylist: gallerylist,
        id: data['id'],
        title: data['title'],        
        );
  }
}
