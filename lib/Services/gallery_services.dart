import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:mylastwords/Services/user_service.dart';
import 'package:mylastwords/components/toastmessage.dart';
import 'package:mylastwords/constants.dart';
import 'package:mylastwords/models/api_response.dart';
import 'package:mylastwords/models/note.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';

Future<ApiResponse> uploadImage(File img) async {

  print(img);
  ApiResponse apiResponse = ApiResponse();
  String token = await getToken();
  int id = await getuserId();  
  var stream = http.ByteStream(img.openRead());
  stream.cast();
  var length = await img.length();
  var request = http.MultipartRequest('POST', Uri.parse(uploadImageURL));
  request.fields['user_id'] = id.toString();  
  request.headers.addAll({'Authorization': 'Bearer $token'});
  request.files.add(http.MultipartFile.fromBytes('file', File(img.path).readAsBytesSync(),filename: img.path));
  var response = await request.send();   
  if (response.statusCode == 200) {
    ToastMessage().toastMsgDark('Photo uploaded successfully');
  } 
  else {
    ToastMessage().toastMsgError('Error uploading photo');
  }
  return apiResponse;
}


