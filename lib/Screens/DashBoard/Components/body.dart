import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:mylastwords/Background/tracker.dart';
import 'package:mylastwords/Screens/DashBoard/components/griddashboard.dart';
import 'package:mylastwords/Screens/Login/login_screen.dart';
import 'package:mylastwords/Services/user_service.dart';
import 'package:mylastwords/components/rounded_button.dart';
import 'package:mylastwords/components/toastmessage.dart';
import 'package:mylastwords/constants.dart';
import 'package:mylastwords/models/api_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import 'package:flutter_svg/svg.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String accountType = '';
  String userName = '';
  String userImage = '';

  @override
  void initState() {
    loadData();
    loadDetails();  
    UserTracker().sendUserLogData();
    super.initState();
  }

  loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = (prefs.getString('name') ?? '');
      userImage = (prefs.getString('userImage') ?? '');      
    });    
  }

  loadDetails() async {
    int id = await getuserId();
    String token = await getToken();    
    print('User Id : ' + id.toString() + ' Token : ' + token);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: darkBackground,
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/mainBackground.jpg"),
                  fit: BoxFit.cover)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 70),
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                              userImage),
                        ),
                        SizedBox(width: 10),
                        Text(
                          '$userName',
                          style: TextStyle(color: txtColorLight, fontSize: 25),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    IconButton(
                      alignment: Alignment.topCenter,
                      icon: Image.asset(
                        "assets/icons/logout.png",
                        width: size.width * 0.2,
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Confirmation'),
                              content: Text('Do you really want to Logout?'),
                              backgroundColor: lightBackground,
                              actions: <Widget>[
                                new TextButton(
                                  onPressed: () async {  
                                    ApiResponse response = await logoutUser();
                                    if(response.error==null)
                                    {
                                      logout().then((value) => Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginScreen()),(route) => false));
                                    }                                                              
                                    else{
                                      ToastMessage().toastMsgError(response.error.toString());
                                    }
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    'Yes',
                                    style: TextStyle(
                                        color: txtColorDark, fontSize: 17),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context, rootNavigator: true).pop(
                                        false); // dismisses only the dialog and returns false
                                  },
                                  child: Text(
                                    'No',
                                    style: TextStyle(
                                        color: txtColorDark, fontSize: 15),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    )
                  ],
                ),
              ),
              SizedBox(height: 30),
              GridDashBoard(),             
            ],
          ),
        ));
  }
}
