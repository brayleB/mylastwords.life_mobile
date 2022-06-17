import 'dart:convert';

import 'package:mylastwords/Services/user_service.dart';
import 'package:mylastwords/constants.dart';
import 'package:mylastwords/models/api_response.dart';
import 'package:mylastwords/models/note.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

//addNote
Future<ApiResponse> addNote(String title, String body) async {
  ApiResponse apiResponse = ApiResponse();
  String token = await getToken();
  int id = await getuserId();
  try {
    final response = await http.post(Uri.parse(addNoteURL),
        headers: {
          'content-type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: json.encode({
          'userId': id,
          'title': title,
          'body': body,
        }));

    switch (response.statusCode) {
      case 200:      
        apiResponse.data = Note.fromJson(jsonDecode(response.body));
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
  return apiResponse;
}

// //getNotes
// Future<ApiResponse> getNotes() async {
//   ApiResponse apiResponse = ApiResponse();
//   int id = await getuserId();
//   String token = await getToken();
//   try {
//     final response = await http.post(Uri.parse(getNotesURL + '/$id'), headers: {
//       'content-type': 'application/json',
//       'Authorization': 'Bearer $token'
//     });
//     print(response.statusCode);
//     switch (response.statusCode) {
//       case 200:
//         apiResponse.data = Getnotes.fromJson(jsonDecode(response.body));
//         break;
//       case 401:
//         apiResponse.error = "Unauthorized";
//         break;
//       default:
//         apiResponse.error = "Something went wrong";
//     }
//   } catch (e) {
//     apiResponse.error = '$e' + '. Server Error.';
//   }
//   return apiResponse;
// }

Future<List<NotesModel>> fetchNotes() async {
  int id = await getuserId();
  String token = await getToken();
  final response = await http.get(Uri.parse(getNotesURL + '/$id'), headers: {
    'content-type': 'application/json',
    'Authorization': 'Bearer $token'
  });

  if (response.statusCode == 200) {
    // print(response.body);
    Map<String, dynamic> map = json.decode(response.body);
    List<dynamic> data = map["notes"];  
    print(data);
    return data.map((note) => new NotesModel.fromJson(note)).toList();
  } else {
    throw Exception('Failed to load jobs from API');
  }
}

// Future<List<Job>> fetchJobs() async {
//   final jobsListAPIUrl = 'https://mock-json-service.glitch.me/';
//   final response = await http.get(Uri.parse(jobsListAPIUrl));

//   if (response.statusCode == 200) {
//     List jsonResponse = json.decode(response.body);
//     return jsonResponse.map((job) => new Job.fromJson(job)).toList();
//   } else {
//     throw Exception('Failed to load jobs from API');
//   }
// }
// //get token
// Future<String> getToken() async {
//   SharedPreferences pref = await SharedPreferences.getInstance();
//   return pref.getString('token') ?? '';
// }

// //get User ID
// Future<int> getuserId() async {
//   SharedPreferences pref = await SharedPreferences.getInstance();
//   return pref.getInt('userId') ?? 0;
// }

//addNote
Future<ApiResponse> deleteNote(int id) async {
  ApiResponse apiResponse = ApiResponse();
  String token = await getToken();
  print(id);
  try {
    final response = await http.post(
      Uri.parse(deleteNotesUrl + '/$id'),
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
  return apiResponse;
}

Future<ApiResponse> updateNote(int id, String title, String body) async {
  ApiResponse apiResponse = ApiResponse();
  String token = await getToken();
  try {
    final response = await http.post(
      Uri.parse(updateNotesURL + '/$id'),
      headers: {
        'content-type': 'application/json',
        'Authorization': 'Bearer $token'
      },    
        body: json.encode({          
          'title': title,
          'body': body,
        }));    
      print(response.statusCode);
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
  return apiResponse;
}


