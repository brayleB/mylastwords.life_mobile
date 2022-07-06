import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mylastwords/components/loader.dart';
import 'package:mylastwords/components/toastmessage.dart';
import 'package:mylastwords/constants.dart';
import 'package:mylastwords/models/api_response.dart';
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
    apiResponse.error = "Server Error";
  }
  EasyLoading.dismiss();
  return apiResponse;
}

//loginApple
Future<ApiResponse> loginOthers(String password) async {
  EasyLoading.show(status: 'Logging-in');
  ApiResponse apiResponse = ApiResponse();
  try {     
    final response = await http.post(Uri.parse(loginOthersURL),
        headers: {'Accept': 'application/json'},
        body: {'password': password});      
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

//RegisterApple
Future<ApiResponse> registerOthers(  
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
    final response = await http.post(Uri.parse(registerOthersURL),
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
        final errors = jsonDecode(response.body)['error'];
        apiResponse.error = errors[errors.keys.elementAt(0)[0]];
        break;
      case 403:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
      case 302:         
        EasyLoading.showInfo('Account already exist');        
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




//Register
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
