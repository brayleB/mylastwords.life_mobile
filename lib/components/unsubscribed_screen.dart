// ignore_for_file: deprecated_member_use

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
import 'package:url_launcher/url_launcher.dart';

// import 'package:flutter_svg/svg.dart';

class UnsubscribedScreen extends StatefulWidget {
  const UnsubscribedScreen({
    Key? key,
  }) : super(key: key);

  @override
  _UnsubscribedScreenScreenState createState() => _UnsubscribedScreenScreenState();
}

class _UnsubscribedScreenScreenState extends State<UnsubscribedScreen> {

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
                 Icon(                              
                  Icons.health_and_safety,
                  color: headerBackgroundColor,
                  size: size.height * 0.15,
                  ),   
                 SizedBox(height: size.height * 0.015),                 
                 Text(
                    'You are officially subscribed',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: size.height*0.03),
                    textAlign: TextAlign.center,
                 ),                 
                 SizedBox(height: size.height * 0.01), 
                 Text(
                    'For more info. Visit our official website',
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: size.height*0.02),
                    textAlign: TextAlign.center,
                 ),   
                  GestureDetector(
                  onTap: () async { final Uri url = Uri(
                          scheme: 'https',
                          host:'mylastwords.life',                                               
                        );
                        await launchUrl(url); },
                  child: Text(
                    "www.mylastwords.life",
                    style: TextStyle(
                      color: txtColorDark,
                      fontWeight: FontWeight.bold,
                      fontSize: 16
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.01), 
                Text(
                    'Or contact us at whats@mylastwords.life',
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: size.height*0.02),
                    textAlign: TextAlign.center,
                 ),
                 SizedBox(height: size.height * 0.015),                                                                                        
                  RoundedButton(
                    textColor: Colors.white,
                    bgcolor: headerBackgroundColor,
                    text: "Exit",
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


