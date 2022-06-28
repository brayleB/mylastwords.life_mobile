import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mylastwords/Screens/Login/components/background.dart';
import 'package:mylastwords/Screens/Signup/signup_screen.dart';
import 'package:mylastwords/Services/user_service.dart';
import 'package:mylastwords/components/already_have_an_account_acheck.dart';
import 'package:mylastwords/components/loader.dart';
import 'package:mylastwords/components/rounded_button.dart';
import 'package:mylastwords/components/rounded_input_field.dart';
import 'package:mylastwords/components/rounded_password_field.dart';
import 'package:mylastwords/components/toastmessage.dart';
import 'package:mylastwords/constants.dart';
import 'package:mylastwords/Screens/DashBoard/dashboard.dart';
import 'package:mylastwords/models/api_response.dart';
import 'package:mylastwords/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:http/http.dart' as http;


import 'or_divider.dart';
import 'social_icon.dart';
// import 'package:flutter_svg/svg.dart';

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email']
  );
class Body extends StatefulWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}
class _BodyState extends State<Body> {
  String _contactText = '';
  String? loginType;
  AccessToken? fbToken;   
  GoogleSignInAccount? _gmailUser;
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final TextEditingController txtEmail = TextEditingController();
  final TextEditingController txtPass = TextEditingController();


  @override
  void initState() {  
    _googleSignIn.onCurrentUserChanged.listen((account) {
      setState(() {
        _gmailUser = account;
      });   
      _googleSignIn.signInSilently();
     });
    super.initState();
  }

  void gmailSignIn() async {
    EasyLoading.show();
    try {
    _gmailUser = await _googleSignIn.signIn();    
      if(_gmailUser!=null){
      ApiResponse loginResp = await login(_gmailUser!.email, _gmailUser!.id);           
      if(loginResp.error==null){
        _saveAndRedirectToHome(loginResp.data as User);
      }
      else if(loginResp.error=="invalid credentials"){
        ApiResponse signupResp = await register(_gmailUser!.displayName!, _gmailUser!.email, _gmailUser!.id,_gmailUser!.photoUrl!, '', '' ,'google' );
        if(signupResp.error==null){
          _saveAndRedirectToHome(signupResp.data as User);
        }
        else{
          EasyLoading.showError(signupResp.error.toString());
        }
      }
      else{
        EasyLoading.showError(loginResp.error.toString());
      }
    }
  } catch (e) {
    ToastMessage().toastMsgDark(e.toString());
  }            
    EasyLoading.dismiss();
  }

  

  void appleSignIn() async { 
    EasyLoading.show(status: 'Apple Signing in...');  
    try{
      final appleUser = await SignInWithApple.getAppleIDCredential(scopes: 
      [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,                       
      ],
    );        
    if(appleUser.email!=null)
    {
      ApiResponse resLogin = await login(appleUser.email.toString(), appleUser.userIdentifier.toString());
      if(resLogin.error==null){
        _saveAndRedirectToHome(resLogin.data as User);
      }
      else if(resLogin.error=="invalid credentials")
      {
        ApiResponse resSignUp = await register(appleUser.givenName.toString() + ' ' +appleUser.familyName.toString(), appleUser.email.toString(), appleUser.userIdentifier.toString(),'', '', '', 'apple');
        if(resSignUp.error==null){
          _saveAndRedirectToHome(resSignUp.data as User);
        }
        else{
          ToastMessage().toastMsgError(resSignUp.error.toString());
        }
      }
      else{
        ToastMessage().toastMsgError(resLogin.error.toString());
      }            
    }
    else{
      EasyLoading.showInfo('This apple account still already connected to this app, please remove it first via Settings.');
    }
    print(appleUser);
    } 
    catch(e){
      ToastMessage().toastMsgDark(e.toString());
    }      
    EasyLoading.dismiss();
  }
  
  



  void _loginValidate() async {
    bool isEmailvalid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(txtEmail.text);
    var errmsg = "";
    if (txtEmail.text == "") {
      errmsg = "Please enter email";
    } else if (isEmailvalid == false) {
      errmsg = "Please enter valid email";
    } else if (txtPass.text == "") {
      errmsg = "Pelase enter password";
    } else {
      ApiResponse response = await login(txtEmail.text, txtPass.text);
      print("Reponse Data: " +
          '${response.data}' +
          " Reponse Error: " +
          '${response.error}');
      if (response.error == null) {
        _saveAndRedirectToHome(response.data as User);
      } else {
        ToastMessage().toastMsgDark('${response.error}');
      }
    }
    if (errmsg != "") {
      EasyLoading.showError(errmsg);
    }
  }
  

  void _loginValidateFacebook() async { 
    EasyLoading.show();
    try{
      final LoginResult res = await FacebookAuth.instance.login(
      permissions: ['public_profile','email']
        );
        if(res.status == LoginStatus.success){      
          final reqData = await FacebookAuth.instance.getUserData(
            fields:"email, name, picture",        
          );  
          var img1 = reqData['picture'];
          var img2 = img1['data'];
          ApiResponse respLogin = await login(reqData['email'], reqData['id']);
          if(respLogin.error==null){        
            _saveAndRedirectToHome(respLogin.data as User);        
          }
          else if(respLogin.error=="invalid credentials"){               
            ApiResponse resSignUp = await register(reqData['name'],reqData['email'], reqData['id'] ,img2['url'], '0123456789', 'Address', 'facebook');
            if(resSignUp.error==null){                  
            _saveAndRedirectToHome(resSignUp.data as User);
            }  
            else{
              EasyLoading.showError(resSignUp.error.toString());
            }
          } 
          else{
            EasyLoading.showError(respLogin.error.toString());
          }                 
        }   
    }catch(e){  
      ToastMessage().toastMsgDark(e.toString());   
    }
    
    EasyLoading.dismiss();      
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
    await pref.setString('userImage', user.userImage ?? '');
    await pref.setInt('userId', user.id ?? 0);
    await pref.setString('type', user.type ?? '');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return DashBoard();
        },
      ),
    );
    }
    
  }
  

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "LOGIN",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: size.height * 0.03),
            Image.asset(
              "assets/images/logo.png",
              height: size.height * 0.2,
            ),
            SizedBox(height: size.height * 0.03),
            Text(
              "Sign in to your account to access your profile, history, \nand any private pages you've been granted access to.",
              style: TextStyle(color: txtColorDark, fontSize: 13),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              isEnable: true,
              controller: txtEmail,
              hintText: "Your Email",
              onChanged: (value) {},
            ),
            RoundedPasswordField(           
              hintText: "Password",
              controller: txtPass,
              onChanged: (value) {},
            ),
            RoundedButton(
                textColor: txtColorLight,
              bgcolor: txtColorDark,
              text: "LOGIN",
              press: () {                   
                _loginValidate();
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
                    },
                  ),
                );
              },
            ),
              OrDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Material(elevation: 5.0, color: Colors.red),
                SocalIcon(
                  iconSrc: "assets/icons/facebook.svg",
                  press: () {
                    _loginValidateFacebook();
                  },
                ),
                SocalIcon(
                  iconSrc: "assets/icons/gmail.svg",
                  press: () {
                    gmailSignIn(); 
                  },
                ),
                 SocalIcon(
                  iconSrc: "assets/icons/apple.svg",
                  press: () { if(Platform.isIOS){
                     appleSignIn();
                  }
                  else{
                    EasyLoading.showInfo('For IOS device only');
                  }
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
 
}
