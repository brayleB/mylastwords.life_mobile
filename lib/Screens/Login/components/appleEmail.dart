import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mylastwords/Screens/AlarmScreen/alarm_screen.dart';
import 'package:mylastwords/Services/user_service.dart';

import 'package:mylastwords/components/header_tab_back.dart';
import 'package:mylastwords/components/rounded_button.dart';
import 'package:mylastwords/components/rounded_input_field.dart';
import 'package:mylastwords/components/toastmessage.dart';
import 'package:mylastwords/constants.dart';
import 'package:mylastwords/models/api_response.dart';
import 'package:mylastwords/models/apple.dart';
import 'package:mylastwords/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';



// import 'package:flutter_svg/svg.dart';

class AppleEmailScreen extends StatefulWidget {
  final String appleID;
  const AppleEmailScreen({
    Key? key, required this.appleID,
  }) : super(key: key, );

  @override
  _AppleEmailScreenState createState() => _AppleEmailScreenState();
}

class _AppleEmailScreenState extends State<AppleEmailScreen> {
  final TextEditingController txtEmail = TextEditingController();

  @override
  void initState() {
   
    super.initState();
  }

    void _saveAndRedirectToHome(User user) async {    
    if(user.status.toString()=="deactivated")
    {
      EasyLoading.showInfo("User is deactivated. Please contact administrator");
    }
    else{
      SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('name', user.name ?? '');
    await pref.setString('token', user.token ?? '');
    await pref.setString('email', user.email ?? '');
    await pref.setString('contactNumber', user.contact ?? ''); 
    await pref.setString('address', user.address ?? '');     
    await pref.setString('userImage', user.userImage ?? '');
    await pref.setInt('userId', user.id ?? 0);
    await pref.setString('type', user.type ?? '');
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => AlarmScreen()),(route) => false);    
    }    
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: HeaderTabBack(
        backgroundcolor: headerBackgroundColor),
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
                  Icons.apple_outlined,
                  color: headerBackgroundColor,
                  size: size.height * 0.15,
                  ),                                                                                                                  
                 SizedBox(height: size.height * 0.015),    
                 Text(
                    'Please enter an Email to provide for this Apple Account',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                    textAlign: TextAlign.center,
                 ),  
                 SizedBox(height: size.height * 0.015),                        
                 RoundedInputField(
                    isEnable: true,
                    icon: Icons.email_outlined,
                    controller: txtEmail,
                    hintText: "Email",
                    onChanged: (value) {},
                  ),                                                                                           
                  RoundedButton(
                    textColor: Colors.white,
                    bgcolor: headerBackgroundColor,
                    text: "Submit",
                    press: () async {            
                      if(txtEmail.text!=""){
                        ApiResponse updateEmailResp = await updateAppleAccountEmail(widget.appleID, txtEmail.text);
                        if(updateEmailResp.error==null){
                          ApiResponse signUpResp = await register("Hello User", txtEmail.text, widget.appleID, "https://www.seekpng.com/png/detail/110-1100707_person-avatar-placeholder.png", "", "", "apple");
                          if(signUpResp.error==null){
                            _saveAndRedirectToHome(signUpResp.data as User);
                          }                          
                        }
                      }else{
                        EasyLoading.showInfo("Please enter email");
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


