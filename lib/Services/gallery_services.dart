import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:mylastwords/Services/user_service.dart';
import 'package:mylastwords/constants.dart';
import 'package:mylastwords/models/api_response.dart';
import 'package:mylastwords/models/note.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';

Future<void> uploadImage(File img) async {
  var stream = new http.ByteStream(img.openRead());
  stream.cast();
  var length = await img.length();
  var request = new http.MultipartRequest('POST', Uri.parse(uploadImageURL));
  request.fields['title'] = 'Static Title';
  var multiport = new http.MultipartFile('image', stream, length);
  request.files.add(multiport);
  var response = await request.send();

  if (response.statusCode == 200) {
    print('image uploaded');
  } else {
    print('failed');
  }
}
