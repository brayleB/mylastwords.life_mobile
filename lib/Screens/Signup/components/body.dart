import 'package:flutter/material.dart';
import 'package:mylastwords/Screens/Login/login_screen.dart';
import 'package:mylastwords/Screens/Signup/components/background.dart';
import 'package:mylastwords/Screens/Login/components/or_divider.dart';
import 'package:mylastwords/Screens/Login/components/social_icon.dart';
import 'package:mylastwords/Services/user_service.dart';
import 'package:mylastwords/components/already_have_an_account_acheck.dart';
import 'package:mylastwords/components/rounded_button.dart';
import 'package:mylastwords/components/rounded_input_field.dart';
import 'package:mylastwords/components/rounded_password_field.dart';
import 'package:mylastwords/components/toastmessage.dart';
import 'package:mylastwords/constants.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mylastwords/models/api_response.dart';
// import 'package:flutter_svg/svg.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final TextEditingController txtEmail = TextEditingController();
  final TextEditingController txtPass = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void validateSignup() async {
    var errmsg = "";
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(txtEmail.text);
    bool passValid =
        RegExp(r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\.$&*~_]).{8,}$")
            .hasMatch(txtPass.text);
    if (txtEmail.text == "") {
      errmsg = "Please enter Email";
    } else if (emailValid == false) {
      errmsg = "Please enter valid Email";
    } else if (txtPass.text == "") {
      errmsg = "Please enter Password";
    } else if (passValid == false) {
      errmsg =
          "Password must contain atleast 1 uppercase, lowercase, number and a special character";
    } else {
      ApiResponse response = await register(txtEmail.text, txtPass.text);
      print("Reponse Data: " +
          '${response.data}' +
          " Reponse Error: " +
          '${response.error}');
      if (response.error == null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return LoginScreen();
            },
          ),
        );
        ToastMessage().toastMsgDark('Registration Successfull');
      } else {
        ToastMessage().toastMsgDark('${response.error}');
      }
    }
    if (errmsg != "") {
      ToastMessage().toastMsgDark(errmsg);
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
            SizedBox(height: size.height * 0.05),
            Text(
              "SIGN UP",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: size.height * 0.01),
            Image.asset(
              "assets/images/logo.png",
              height: size.height * 0.2,
            ),
            SizedBox(height: size.height * 0.01),
            Text(
              "By creating an account,\nYou may receive newsletters or promotions",
              style: TextStyle(color: txtColorDark, fontSize: 13),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
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
              text: "SIGNUP",
              press: () {
                validateSignup();
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),            
          ],
        ),
      ),
    );
  }
}
