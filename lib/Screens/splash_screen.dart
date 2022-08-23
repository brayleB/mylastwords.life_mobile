import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mylastwords/Screens/AlarmScreen/alarm_screen.dart';
import 'package:mylastwords/Screens/DashBoard/dashboard.dart';
import 'package:mylastwords/Screens/Login/login_screen.dart';
import 'package:mylastwords/Screens/Welcome/welcome_screen.dart';
import 'package:mylastwords/Services/user_service.dart';
import 'package:mylastwords/components/toastmessage.dart';
import 'package:mylastwords/models/api_response.dart';
import 'package:mylastwords/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:new_version/new_version.dart';
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
      ApiResponse response = await getuserDetails();
      if(response.error==null){
        _saveAndRedirectToHome(response.data as User);
      }  
      else if(response.error=="Unauthorized")      
      {
         Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => WelcomeScreen()),(route) => false);
      }
      else{
        ToastMessage().toastMsgError(response.error.toString());
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => WelcomeScreen()),(route) => false);
      }
    } 
    else{
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => WelcomeScreen()),(route) => false);
    }   
  }

  void _saveAndRedirectToHome(User user) async {        
    if(user.status==0)
    {
      EasyLoading.showInfo("This account is deactivated. Visit mylastwords.life for inquiries.");
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginScreen()),(route) => false);
    }
    else if(user.status==2){
      EasyLoading.showInfo("This account is previously removed. Contact mylastwords.life for account recovery");
    }
    else{
      SharedPreferences pref = await SharedPreferences.getInstance();
      await pref.setString('name', user.name ?? '');    
      await pref.setString('email', user.email ?? '');
      await pref.setString('contactNumber', user.contact ?? ''); 
      await pref.setString('address', user.address ?? '');     
      await pref.setString('userImage', user.userImage ?? '');
      await pref.setInt('userId', user.id ?? 0);
      await pref.setString('type', user.type ?? '');
      await pref.setBool('isLoggedIn', true);
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => AlarmScreen()),(route) => false);
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
