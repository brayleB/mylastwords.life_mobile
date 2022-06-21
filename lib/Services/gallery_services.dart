import 'dart:convert';
import 'dart:io';

import 'package:mylastwords/Services/user_service.dart';
import 'package:mylastwords/components/toastmessage.dart';
import 'package:mylastwords/constants.dart';
import 'package:mylastwords/models/api_response.dart';
import 'package:mylastwords/models/gallery.dart';
import 'package:http/http.dart' as http;

Future<ApiResponse> uploadImage(File img) async {
  
  ApiResponse apiResponse = ApiResponse();
  String token = await getToken();
  int id = await getuserId();  
  var stream = http.ByteStream(img.openRead());
  stream.cast();
  // var length = await img.length();
  var request = http.MultipartRequest('POST', Uri.parse(uploadImageURL));
  request.fields['user_id'] = id.toString();  
  request.headers.addAll({'Authorization': 'Bearer $token'});
  request.files.add(http.MultipartFile.fromBytes('file', File(img.path).readAsBytesSync(),filename: img.path));
  var response = await request.send();  
  print(request.headers);
  if (response.statusCode == 200) {
    ToastMessage().toastMsgDark('Photo uploaded successfully');
  } 
  else {
    ToastMessage().toastMsgError('Error uploading photo');
  }
  return apiResponse;
}

Future<List<GalleryModel>> fetchPhotos() async {
  int id = await getuserId();
  String token = await getToken();
  final response = await http.get(Uri.parse(getImagesURL + '/$id'), headers: {
    'content-type': 'application/json',
    'Authorization': 'Bearer $token'
  });

  if (response.statusCode == 200) {   
    Map<String, dynamic> map = json.decode(response.body);
    List<dynamic> data = map["gallery"];
    return data.map((image) => new GalleryModel.fromJson(image)).toList();
  } else {
    throw Exception('Failed to load images from API');
  }
}


