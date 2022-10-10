import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mylastwords/Screens/Login/login_screen.dart';
import 'package:mylastwords/Services/user_service.dart';
import 'package:mylastwords/components/header_tab.dart';
import 'package:mylastwords/components/header_tab_back.dart';
import 'package:mylastwords/components/rounded_button.dart';
import 'package:mylastwords/components/rounded_input_field.dart';
import 'package:mylastwords/components/toastmessage.dart';
import 'package:mylastwords/constants.dart';
import 'package:mylastwords/models/api_response.dart';


// import 'package:flutter_svg/svg.dart';

class ForgotPassScreen extends StatefulWidget {
  const ForgotPassScreen({
    Key? key,
  }) : super(key: key);

  @override
  _ForgotPassScreenState createState() => _ForgotPassScreenState();
}

class _ForgotPassScreenState extends State<ForgotPassScreen> {
  final TextEditingController txtEmail = TextEditingController();
  bool isSent = false;

  @override
  void initState() {   
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(backgroundColor: headerBackgroundColor),
        backgroundColor: lightBackground,
      body: 
          SingleChildScrollView(
            child: Container(                       
            margin: EdgeInsets.only(top:size.height*0.025),
            padding: EdgeInsets.all(size.height*0.025), 
            alignment: Alignment.center,
            child: Column(   
              crossAxisAlignment: CrossAxisAlignment.center,          
              children: <Widget>[ 
                 SizedBox(height: size.height * 0.010),     
                 Icon(                              
                  Icons.lock_reset,
                  color: headerBackgroundColor,
                  size: size.height * 0.15,
                  ),                                                                                                                  
                 SizedBox(height: size.height * 0.015),                      
                 Text(
                    isSent ? 'Email has been sent to '+ txtEmail.text : 'Provide your account`s Email for your Password Recovery',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                    textAlign: TextAlign.center,
                 ) ,  
                 SizedBox(height: size.height * 0.015),  
                 isSent ?   
                 SizedBox(height: size.height * 0.01) 
                 :                     
                 RoundedInputField(
                    isEnable: true,
                    icon: Icons.email_outlined,
                    controller: txtEmail,
                    hintText: "Email",
                    onChanged: (value) {},
                  ),   
                  isSent ? 
                  RoundedButton(
                    textColor: Colors.white,
                    bgcolor: headerBackgroundColor,
                    text: "Exit",
                    press: () async {       
                      setState(() {
                        isSent = false;
                      });     
                      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginScreen()),(route) => false);  },
                  ) :                
                  RoundedButton(
                    textColor: Colors.white,
                    bgcolor: headerBackgroundColor,
                    text: "Submit",
                    press: () async {            
                      ApiResponse response = await forgotPassword(txtEmail.text);   
                      if(response.error==null){                        
                        setState(() {
                          isSent = true;
                        });
                      }  
                      else{
                        ToastMessage().toastMsgLight(response.error.toString());
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


