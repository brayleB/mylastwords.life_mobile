// ignore_for_file: must_be_immutable, unused_local_variable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mylastwords/Screens/AlarmScreen/alarm_screen.dart';
import 'package:mylastwords/Screens/ProfileScreen/profile_screen.dart';

import 'package:mylastwords/Services/gallery_services.dart';
import 'package:mylastwords/Services/user_service.dart';

import 'package:mylastwords/components/header_tab_add.dart';
import 'package:mylastwords/components/toastmessage.dart';

import 'package:mylastwords/constants.dart';
import 'package:mylastwords/models/api_response.dart';
import 'package:mylastwords/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';



class PreviewImage extends StatelessWidget {
  final File? fileImage;

  PreviewImage({Key? key, required this.fileImage}) : super(key: key);

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderTabAdd(
        backgroundcolor: headerBackgroundColor,
        title: "Profile Photo",
        saveFunc: () async {
          ApiResponse resp = await updateProfilePicture(fileImage!);                  
            if(resp.error==null){    
              ApiResponse getImg = await getuserDetails();
              var data = getImg.data as User;   
              SharedPreferences prefs = await SharedPreferences.getInstance();                     
              await prefs.setString('userImage',data.userImage.toString());    
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AlarmScreen())); 
            }  
            else{
              ToastMessage().toastMsgDark(resp.error.toString());
            }        
        }
      ),      
      body: Container(  
            padding: const EdgeInsets.all(10.0),   
            decoration: BoxDecoration(image: DecorationImage(
                                  image: FileImage(File(fileImage!.path)),
                                  fit: BoxFit.contain), ),                  
           ),      
    );
  }
}
