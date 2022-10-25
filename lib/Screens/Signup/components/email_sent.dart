// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:mylastwords/Screens/AlarmScreen/alarm_screen.dart';
import 'package:mylastwords/Screens/Login/login_screen.dart';
import 'package:mylastwords/components/rounded_button.dart';
import 'package:mylastwords/constants.dart';
import 'package:url_launcher/url_launcher.dart';

// import 'package:flutter_svg/svg.dart';

class EmailSentScreen extends StatefulWidget {
  const EmailSentScreen({
    Key? key,
  }) : super(key: key);

  @override
  _EmailSentScreenState createState() => _EmailSentScreenState();
}

class _EmailSentScreenState extends State<EmailSentScreen> {

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
                  Icons.check_circle_outline_sharp,
                  color: headerBackgroundColor,
                  size: size.height * 0.15,
                  ),   
                 SizedBox(height: size.height * 0.015),                 
                 Text(
                    'Sign-up Successful',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: size.height*0.035),
                    textAlign: TextAlign.center,
                 ), 
                 SizedBox(height: size.height * 0.02),  
                 Padding(padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                 child: Text(
                    'You are now on a inactive status',
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: size.height*0.025),
                    textAlign: TextAlign.center,
                 ),),
                 SizedBox(height: size.height * 0.01), 
                 Text(
                    'Please verify your email first.',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: size.height*0.025),
                    textAlign: TextAlign.center,
                 ),   
               
                SizedBox(height: size.height * 0.01), 
              
                 SizedBox(height: size.height * 0.015),                                                                                        
                  RoundedButton(
                    textColor: Colors.white,
                    bgcolor: headerBackgroundColor,
                    text: "Proceed to Login",
                    press: () async {            
                        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginScreen()),(route) => false);                                                   
                    },
                  ),      
              ],
              ),
            ),
          )
          );
     
  }
}


