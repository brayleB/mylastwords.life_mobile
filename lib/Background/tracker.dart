
import 'package:intl/intl.dart';
import 'package:mylastwords/Services/userLogs_services.dart';
import 'package:mylastwords/models/api_response.dart';
import 'package:permission_handler/permission_handler.dart';

class UserTracker {
  

  Future<void> sendUserLogData() async {
    String date = DateFormat('yyyy-MM-dd')
                                    .format(DateTime.now());
    String time = DateFormat('HH:mm:ss')
                                    .format(DateTime.now()); 
    

      ApiResponse response = await addUserLogCall(
          date, time, "40.741895,-73.989308");
      if (response.error == null) {
        print("No error");
      } else {       
        print('${response.error}');
      }  
  }
}
