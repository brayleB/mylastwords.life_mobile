import 'package:flutter/material.dart';
import 'package:mylastwords/Screens/DashBoard/dashboard.dart';
import 'package:mylastwords/Screens/Login/login_screen.dart';
import 'package:mylastwords/Screens/AlarmScreen/alarm_screen.dart';
import 'package:mylastwords/Screens/Signup/signup_screen.dart';
import 'package:mylastwords/Screens/Welcome/components/background.dart';
import 'package:mylastwords/Screens/Welcome/welcome_screen.dart';
import 'package:mylastwords/components/rounded_button.dart';
import 'package:mylastwords/constants.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter_svg/svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    Key? key,
  }) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
 String token = '';

  @override
  void initState() {
    checkToken();
    super.initState();
  }

  checkToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = (prefs.getString('token') ?? '');
    });
    if (token != "") {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return DashBoard();
          },
        ),
      );
    }
    else if (token==""){
        Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return WelcomeScreen();
          },
        ),
      );
    }
  }

    @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: double.infinity,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/welcomeBackground.jpg"),
              fit: BoxFit.cover)),     
    );
  }
}
