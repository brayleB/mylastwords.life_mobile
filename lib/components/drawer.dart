// ignore_for_file: non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mylastwords/Background/tracker.dart';
import 'package:mylastwords/Screens/AboutScreen/about_screen.dart';
import 'package:mylastwords/Screens/GalleryScreen/gallery_screen.dart';
import 'package:mylastwords/Screens/Login/login_screen.dart';
import 'package:mylastwords/Screens/NoteScreen/note_screen.dart';
import 'package:mylastwords/Screens/ProfileScreen/profile_screen.dart';
import 'package:mylastwords/Screens/paywall.dart';
import 'package:mylastwords/Screens/singletons_data.dart';
import 'package:mylastwords/Services/user_service.dart';
import 'package:mylastwords/components/rounded_button.dart';
import 'package:mylastwords/components/subscribed_screen.dart';
import 'package:mylastwords/components/toastmessage.dart';
import 'package:mylastwords/components/unsubscribed_screen.dart';
import 'package:mylastwords/constants.dart';
import 'package:mylastwords/models/api_response.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:purchases_flutter/models/offerings_wrapper.dart';

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
  String subscription = '';
  
  @override
  void initState() {    
    loadData();
    super.initState();
  }
  

    void payWall(int path) async {
     if(isLoggedIn==true){                         
               CustomerInfo customerInfo = await Purchases.getCustomerInfo();   
                if (customerInfo.entitlements.all[entitlementID] != null &&
                  customerInfo.entitlements.all[entitlementID]!.isActive == true) {                       
                    print(customerInfo)               ;
                    if(path==1){
                      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => NoteScreen()),(route) => false);
                    }    
                    else if(path==2){
                      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => GalleryScreen()),(route) => false);
                    }     
                    else if(path==3){
                     Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => SubscriptionScreen()),(route) => false);
                    }                             
                  }
                  else{                                
                    Offerings? offerings;
                    try {
                        offerings = await Purchases.getOfferings();                  
                      } on PlatformException catch (e) {          
                        print(e.message);
                      }
                      if (offerings == null || offerings.current == null) {
                        EasyLoading.showInfo('Offerings are empty');
                      }
                    else{                    
                      await showModalBottomSheet(
                        useRootNavigator: true,
                        isDismissible: true,
                        isScrollControlled: true,      
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
                        ),
                        context: context,
                        builder: (BuildContext context) {
                          return StatefulBuilder(
                              builder: (BuildContext context, StateSetter setModalState) {
                        
                            return Paywall(
                              offering: offerings!.current!,
                            );
                          });
                        },
                      );
                    }
              
              } 
            } 
          }


  loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = (prefs.getString('name') ?? '');
      userImage = (prefs.getString('userImage') ?? '');  
      isLoggedIn = (prefs.getBool('isLoggedIn') ?? false);    
      userEmail = (prefs.getString('email') ?? '');
      subscription = (prefs.getString('subcription')??'');
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
            payWall(3)    ;        
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
          onTap: () => payWall(1)
        ),
        ListTile(
          leading: Icon(
            Icons.photo,
          ),
          title: const Text('Last Photos'),
          onTap: ()  => payWall(2)          
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
            var url = Uri.parse("https://mylastwords.life/helpline-and-support");
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