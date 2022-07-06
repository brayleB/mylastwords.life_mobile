import 'package:flutter/material.dart';
import 'package:mylastwords/components/header_tab_back.dart';
import 'package:mylastwords/components/rounded_button.dart';
import 'package:mylastwords/components/rounded_input_field.dart';
import 'package:mylastwords/components/rounded_password_field.dart';
import 'package:mylastwords/components/toastmessage.dart';
import 'package:mylastwords/constants.dart';

// import 'package:flutter_svg/svg.dart';

class ChangePassScreen extends StatefulWidget {
  const ChangePassScreen({
    Key? key,
  }) : super(key: key);

  @override
  _ChangePassScreenState createState() => _ChangePassScreenState();
}

class _ChangePassScreenState extends State<ChangePassScreen> {
  final TextEditingController txtOldPass = TextEditingController();
  final TextEditingController txtNewPass = TextEditingController();
  final TextEditingController txtConfirmPass = TextEditingController();

  @override
  void initState() {
   
    super.initState();
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
            alignment: Alignment.center,
            child: Column(   
              crossAxisAlignment: CrossAxisAlignment.center,          
              children: <Widget>[                                                                                                                           
                 SizedBox(height: size.height * 0.010),     
                 Icon(                              
                  Icons.lock_person_outlined,
                  color: headerBackgroundColor,
                  size: size.height * 0.15,
                  ),   
                 SizedBox(height: size.height * 0.015),                 
                 Text(
                    'Change Password',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: size.height*0.03),
                    textAlign: TextAlign.center,
                 ),  
                 SizedBox(height: size.height * 0.015),                         
                  RoundedPasswordField(                 
                    controller: txtOldPass,
                    hintText: "Old Password",
                    onChanged: (value) {},
                  ),                       
                  RoundedPasswordField(                 
                    controller: txtNewPass,
                    hintText: "New Password",
                    onChanged: (value) {},
                  ), 
                 RoundedPasswordField(                 
                    controller: txtConfirmPass,
                    hintText: "Confirm Password",
                    onChanged: (value) {},
                  ),                                                   
                  RoundedButton(
                    textColor: Colors.white,
                    bgcolor: headerBackgroundColor,
                    text: "Update Password",
                    press: () {            
                      ToastMessage().toastMsgError('Not yet implemented');                                   
                    },
                  ),      
              ],
              ),
            ),
          )
          );
     
  }
}


