import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mylastwords/Screens/AlarmScreen/alarm_screen.dart';
import 'package:mylastwords/Screens/Login/login_screen.dart';
import 'package:mylastwords/Services/user_service.dart';
import 'package:mylastwords/components/header_tab_back.dart';
import 'package:mylastwords/components/rounded_button.dart';
import 'package:mylastwords/components/rounded_input_field.dart';
import 'package:mylastwords/components/rounded_password_field.dart';
import 'package:mylastwords/components/toastmessage.dart';
import 'package:mylastwords/constants.dart';
import 'package:mylastwords/models/api_response.dart';

// import 'package:flutter_svg/svg.dart';

class AdvisoryScreen extends StatefulWidget {
  const AdvisoryScreen({
    Key? key,
  }) : super(key: key);

  @override
  AdvisoryScreenState createState() => AdvisoryScreenState();
}

class AdvisoryScreenState extends State<AdvisoryScreen>{
  @override
  void initState() {   
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(    
        backgroundColor: lightBackground,
      body: 
          SingleChildScrollView(
            child: Container(                       
            margin: EdgeInsets.only(top:size.height*0.025),
            alignment: Alignment.center,
            child: Column(   
              crossAxisAlignment: CrossAxisAlignment.center,          
              children: <Widget>[                                                                                                                           
                 SizedBox(height: size.height * 0.1),     
                  Image.asset(
                    "assets/images/logo.png",
                    height: size.height * 0.2,
                  ),       
                 SizedBox(height: size.height * 0.06),                 
                 Text(
                    'My Last Words advisory',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: size.height*0.03),
                    textAlign: TextAlign.center,
                 ), 
                 SizedBox(height: size.height * 0.02),  
                 Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width*0.05),
                  child: Text(
                    'The mylastwords.life is temporarily unavailable. We are working hard to restore your data and we apologize for the inconvenience.',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: size.height*0.022),
                    textAlign: TextAlign.center,
                   ), 
                 ),                                
                 SizedBox(height: size.height * 0.02), 
                 Text(
                    'Thank you for understanding.',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: size.height*0.022),
                    textAlign: TextAlign.center,
                 ),   
                 SizedBox(height: size.height * 0.05),                                                                                        
                  RoundedButton(
                    textColor: Colors.white,
                    bgcolor: headerBackgroundColor,
                    text: "Visit Alarm",
                    press: () async {          
                       Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => AlarmScreen()),(route) => false);                                                                   
                    },
                  ),      
              ],
              ),
            ),
          )
          );
     
  }
}


