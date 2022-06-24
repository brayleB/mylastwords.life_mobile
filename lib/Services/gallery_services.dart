import 'dart:convert';
import 'dart:io';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mylastwords/Services/user_service.dart';
import 'package:mylastwords/components/toastmessage.dart';
import 'package:mylastwords/constants.dart';
import 'package:mylastwords/models/api_response.dart';
import 'package:mylastwords/models/gallery.dart';
import 'package:http/http.dart' as http;

Future<ApiResponse> uploadImage(File img) async {
  EasyLoading.show();
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
  EasyLoading.dismiss();
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

Future<ApiResponse> deleteImage(int id) async {
  EasyLoading.show();
  ApiResponse apiResponse = ApiResponse();
  String token = await getToken();
  try {
    final response = await http.post(
      Uri.parse(deleteImagesURL + '/$id'),
      headers: {
        'content-type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    switch (response.statusCode) {
      case 200:
        print(response.body);
        break;
      case 422:
        final errors = jsonDecode(response.body)['errors'];
        apiResponse.error = errors[errors.keys.elementAt(0)[0]];
        break;
      case 403:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
      default:
        apiResponse.error = "Something went wrong";
    }
  } catch (e) {
    apiResponse.error = '$e' + '. Server Error.';
  }
  EasyLoading.dismiss();
  return apiResponse;
}


