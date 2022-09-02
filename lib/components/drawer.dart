// ignore_for_file: non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mylastwords/Screens/AboutScreen/about_screen.dart';
import 'package:mylastwords/Screens/GalleryScreen/gallery_screen.dart';
import 'package:mylastwords/Screens/Login/login_screen.dart';
import 'package:mylastwords/Screens/NoteScreen/note_screen.dart';
import 'package:mylastwords/Screens/ProfileScreen/profile_screen.dart';
import 'package:mylastwords/Services/user_service.dart';
import 'package:mylastwords/components/rounded_button.dart';
import 'package:mylastwords/components/subscription.dart';
import 'package:mylastwords/components/toastmessage.dart';
import 'package:mylastwords/constants.dart';
import 'package:mylastwords/models/api_response.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({
    Key? key,
  }) : super(key: key);

  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  String userName = '';
  String userImage = '';
  String userEmail = '';
  bool? isLoggedIn;
  
  @override
  void initState() {
    loadData();
    super.initState();
  }

  loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = (prefs.getString('name') ?? '');
      userImage = (prefs.getString('userImage') ?? '');  
      isLoggedIn = (prefs.getBool('isLoggedIn') ?? false);    
      userEmail = (prefs.getString('email') ?? '');
    });    
  }
   @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Drawer(
    backgroundColor: lightBackground,
    child: ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: [
        UserAccountsDrawerHeader( 
          decoration: BoxDecoration(color: headerBackgroundColor),
          accountName: Text(
            userName,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),          
          accountEmail: Text(
            userEmail,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),         
          currentAccountPicture: CircleAvatar(                          
                          backgroundColor: Colors.transparent,
                          backgroundImage: NetworkImage(
                              userImage),
                        ),                        
        ),
        ListTile(
          leading: Icon(
            Icons.subscriptions,
          ),
          title: const Text('Subscription'),
          onTap: () {
            if(isLoggedIn==true){
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => SubscriptionScreen()),(route) => false);
            }            
          },
        ),
        ListTile(
          leading: Icon(
            Icons.person,
          ),
          title: const Text('Profile'),
          onTap: () {
            if(isLoggedIn==true){
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => ProfileScreen()),(route) => false);
            }            
          },
        ),
        ListTile(
          leading: Icon(
            Icons.note_alt_rounded,
          ),
          title: const Text('Last Words'),
          onTap: () {
            if(isLoggedIn==true){
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => NoteScreen()),(route) => false);
            } 
          },
        ),
        ListTile(
          leading: Icon(
            Icons.photo,
          ),
          title: const Text('Photos'),
          onTap: () {
            if(isLoggedIn==true){
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => GalleryScreen()),(route) => false);
            }
          },
        ),
        ListTile(
          leading: Icon(
            Icons.info
          ),
          title: const Text('About'),
          onTap: () {
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => AboutScreen()),(route) => false);
          },
        ),
        ListTile(
          leading: Icon(
            Icons.contact_phone
          ),
          title: const Text('Contact Us'),
          onTap: () async {
            final Uri url = Uri(
                      scheme: 'https',
                      host:'mylastwords.life',
                      path: '/contact-us',                      
                    );
                    await launchUrl(url);
          },
        ),
        ListTile(
          leading: Icon(
            Icons.logout
          ),
          title: const Text('Log-out'),
          onTap: () async {
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
        ),
      ],
     ),
    );
  }
}