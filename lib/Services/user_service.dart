import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mylastwords/components/loader.dart';
import 'package:mylastwords/components/toastmessage.dart';
import 'package:mylastwords/constants.dart';
import 'package:mylastwords/models/api_response.dart';
import 'package:mylastwords/models/apple.dart';
import 'package:mylastwords/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

//login
Future<ApiResponse> login(String email, String password) async {
  EasyLoading.show(status: 'Logging-in');
  ApiResponse apiResponse = ApiResponse();
  try {     
    final response = await http.post(Uri.parse(loginURL),
        headers: {'Accept': 'application/json'},
        body: {'email': email, 'password': password});
    switch (response.statusCode) {
      case 200:
        print(response.body);
        apiResponse.data = User.fromJson(jsonDecode(response.body));
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
    apiResponse.error = "Server Error. Please check Internet Connection";
  }  
  EasyLoading.dismiss();
  return apiResponse;
}



//Register
Future<ApiResponse> register(  
  String name,
  String email,
  String password,
  String img,  
  String contactnumber,
  String address,
  String type,
) async {
  EasyLoading.show(status: 'Signing Up');
  ApiResponse apiResponse = ApiResponse();
  if(img==""){
    img="https://www.seekpng.com/png/detail/110-1100707_person-avatar-placeholder.png";
  }
  try {
    final response = await http.post(Uri.parse(registerURL),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
          'type': type,
          'subcription': "free",
          'status': 1,
          'userImage':img,
          'contactNumber':contactnumber,
          'address':address,
        }));   
    switch (response.statusCode) {
      case 200:
        apiResponse.data = User.fromJson(jsonDecode(response.body));
        break;
      case 422:
        final errors = jsonDecode(response.body)['errors'];
        apiResponse.error = errors[errors.keys.elementAt(0)[0]];
        break;
      case 403:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
      case 302: 
        EasyLoading.showInfo('Email provided already exist');        
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
      default:    
        apiResponse.error = "Something went wrong";
    }
  } catch (e) {
    apiResponse.error = "Server Error";
  }
  EasyLoading.dismiss();
  return apiResponse;
}


//Edit
Future<ApiResponse> updateUserCall(  
  String name,  
  String contactnumber,
  String address,
) async {
  EasyLoading.show(status: 'Updating User Information');
  String token = await getToken();
  int id = await getuserId();
  ApiResponse apiResponse = ApiResponse();
  try {
    final response = await http.post(Uri.parse(updateUserURL),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode({
          'id':id,
          'name': name,          
          'contactNumber':contactnumber,
          'address':address,
        }));           
    switch (response.statusCode) {
      case 200:        
        break;
      case 422:
        final errors = jsonDecode(response.body)['error'];
        apiResponse.error = errors[errors.keys.elementAt(0)[0]];
        break;
      case 403:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
      case 302: 
        EasyLoading.showInfo('Email provided already exist');        
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
      default:    
        apiResponse.error = "Something went wrong";
    }
  } catch (e) {
    print(e.toString());
    apiResponse.error = "Server Error";
  }
  EasyLoading.dismiss();
  return apiResponse;
}


//getuser
Future<ApiResponse> getuserDetails() async {
  EasyLoading.show(status: 'Loading data, please wait');
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(
      Uri.parse(userURL),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
    );
    switch (response.statusCode) {
      case 200:
        apiResponse.data = User.fromJson(jsonDecode(response.body));
        break;
      case 401:
        apiResponse.error = "Unauthorized";
        break;
      default:
        apiResponse.error = "Something went wrong";
    }
  } catch (e) {
    apiResponse.error = "Server Error.";
  }
  EasyLoading.dismiss();
  return apiResponse;  
}



//get token
Future<String> getToken() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('token') ?? '';
}

//get User ID
Future<int> getuserId() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getInt('userId') ?? 0;
}

//get Name
Future<String> getName() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('name') ?? '';
}

//get Name
Future<String> getEmail() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('email') ?? '';
}

//get Name
Future<String> getUserImgURL() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('userImage') ?? '';
}

//logout
Future<bool> logout() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return await pref.remove('token');
}

//getuser
Future<ApiResponse> logoutUser() async {
  EasyLoading.show(status: 'Logging-out');
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.post(
      Uri.parse(logoutURL),
      headers: {'Authorization': 'Bearer $token'},
    );
    print(response.statusCode);
    switch (response.statusCode) {
      case 200:
        print(response.body);
        break;
      case 401:
        apiResponse.error = "Unauthorized";
        break;
      default:
        apiResponse.error = "Something went wrong";
    }
  } catch (e) {    
    ToastMessage().toastMsgError(e.toString());
  }
  SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.remove('name');   
    await pref.remove('email');    
    await pref.remove('userImage');
    await pref.remove('userId');
    await pref.remove('type');
  EasyLoading.showInfo('Logout Successfull');
  return apiResponse;
}


//resetPassword
Future<ApiResponse> forgotPassword(String email) async {
  EasyLoading.show(status: 'Loading...');
  ApiResponse apiResponse = ApiResponse();
  try {    
    final response = await http.post(
      Uri.parse(forgotPasswordURL),
      headers: {
          'Content-Type': 'application/json',        
        },
        body: jsonEncode({
          'email':email,         
        })); 
    print(response.statusCode);
    switch (response.statusCode) {
      case 200:
        print('success');
        break;     
      default:
        apiResponse.error = "Something went wrong";
    }
  } catch (e) {
    apiResponse.error = "Server Error.";
  }
  EasyLoading.dismiss();
  return apiResponse;  
}


//addApple
Future<ApiResponse> addAppleAccount(  
  String appleID,
  String name,
  String email,
) async {
  EasyLoading.show(status: 'Checking Apple Account');
  ApiResponse apiResponse = ApiResponse();
  try {
    final response = await http.post(Uri.parse(addAppleUserURL),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'appleID': appleID,
          'name': name,
          'email': email,        
        }));          
    switch (response.statusCode) {
      case 200:        
        apiResponse.data = AppleAccsModel.fromJson(jsonDecode(response.body));
        break;
      case 422:
        final errors = jsonDecode(response.body)['errors'];
        apiResponse.error = errors[errors.keys.elementAt(0)[0]];
        break;
      case 403:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
      case 302: 
        apiResponse.error = "already exists";
        break;
      default:    
        apiResponse.error = "Something went wrong";
    }
  } catch (e) { 
    apiResponse.error = e.toString();
  }
  EasyLoading.dismiss();
  return apiResponse;
}

//getApple
Future<ApiResponse> getAppleAccount(String appleID) async {
  EasyLoading.show(status: 'Loading data, please wait');
  ApiResponse apiResponse = ApiResponse();
  try {    
    final response = await http.get(
      Uri.parse(getAppleUserURL+"?appleID="+appleID),
      headers: {'Accept': 'application/json'},       
    );   
    switch (response.statusCode) {
      case 200:    
        print(response.body)    ;
        apiResponse.data = AppleAccsModel.fromJson(jsonDecode(response.body));        
        break;              
      default:
        apiResponse.error = "Something went wrong";
    }
  } catch (e) {
    apiResponse.error = "Server Error.";
  }
  EasyLoading.dismiss();
  return apiResponse;  
}

//updateAppleAccount
Future<ApiResponse> updateAppleAccountEmail(  
  String appleID, String email, 
) async {
  EasyLoading.show(status: 'Updating Apple Account');  
  ApiResponse apiResponse = ApiResponse();
  try {
    final response = await http.post(Uri.parse(updateAppleAccountEmailURL),
        headers: {
          'Content-Type': 'application/json',       
        },
        body: jsonEncode({
          'appleID':appleID,
          'email':email,      
        }));           
    switch (response.statusCode) {
      case 200:        
        break;     
      case 302: 
        EasyLoading.showInfo('Email provided already exist');        
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
      default:    
        apiResponse.error = "Something went wrong";
    }
  } catch (e) {
    print(e.toString());
    apiResponse.error = "Server Error";
  }
  EasyLoading.dismiss();
  return apiResponse;
}

//requestAccountRemoval
//updateAppleAccount
Future<ApiResponse> requestAccountRemoval(    
) async {
  EasyLoading.show(status: 'Requesting account removal');  
  String token = await getToken();
  int id = await getuserId();
  ApiResponse apiResponse = ApiResponse();
  try {
    final response = await http.post(Uri.parse(requestAccountRemovalURL),
        headers: {
          'Content-Type': 'application/json','Authorization': 'Bearer $token'      
        },
        body: jsonEncode({
          'id':id,             
        }));   
    print(response.body)       ;
    switch (response.statusCode) {
      case 200:        
        break;      
      default:    
        apiResponse.error = "Something went wrong";
    }
  } catch (e) { 
    apiResponse.error = "Server Error";
  }
  EasyLoading.dismiss();
  return apiResponse;
}

//update Profile Image
Future<ApiResponse> updateProfilePicture(File img) async {
  EasyLoading.show();
  ApiResponse apiResponse = ApiResponse();
  String token = await getToken();
  int id = await getuserId();  
  var stream = http.ByteStream(img.openRead());
  stream.cast();
  // var length = await img.length();
  var request = http.MultipartRequest('POST', Uri.parse(changeProfilePhoto));
  request.fields['id'] = id.toString();  
  request.headers.addAll({'Authorization': 'Bearer $token'});
  request.files.add(http.MultipartFile.fromBytes('file', File(img.path).readAsBytesSync(),filename: img.path));
  var response = await request.send();  
  print(request.headers);
  if (response.statusCode == 200) {
    ToastMessage().toastMsgDark('Photo uploaded successfully');
  } 
  else {
    print(response.reasonPhrase);
    ToastMessage().toastMsgError('Error uploading photo');
  }
  EasyLoading.dismiss();
  return apiResponse;
}