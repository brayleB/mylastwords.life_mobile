import 'package:flutter/material.dart';
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

class RemoveAccountScreen extends StatefulWidget {
  const RemoveAccountScreen({
    Key? key,
  }) : super(key: key);

  @override
  _RemoveAccountScreenState createState() => _RemoveAccountScreenState();
}

class _RemoveAccountScreenState extends State<RemoveAccountScreen> {

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
                  Icons.delete_forever_outlined,
                  color: headerBackgroundColor,
                  size: size.height * 0.15,
                  ),   
                 SizedBox(height: size.height * 0.015),                 
                 Text(
                    'Successfully requested account removal',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: size.height*0.03),
                    textAlign: TextAlign.center,
                 ), 
                 SizedBox(height: size.height * 0.02),  
                 Text(
                    'The admin will removed your account permanently in a few days.',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: size.height*0.02),
                    textAlign: TextAlign.center,
                 ), 
                 SizedBox(height: size.height * 0.02), 
                 Text(
                    'For account recovery. Visit and contact www.mylastwords.life',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: size.height*0.02),
                    textAlign: TextAlign.center,
                 ),   
                 SizedBox(height: size.height * 0.015),                                                                                        
                  RoundedButton(
                    textColor: Colors.white,
                    bgcolor: headerBackgroundColor,
                    text: "Exit",
                    press: () async {            
                        ApiResponse response = await logoutUser();
                        if(response.error==null)
                        {
                          logout().then((value) => Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginScreen()),(route) => false));
                        }                                                              
                        else{
                          ToastMessage().toastMsgError(response.error.toString());
                        }                                                    
                    },
                  ),      
              ],
              ),
            ),
          )
          );
     
  }
}


