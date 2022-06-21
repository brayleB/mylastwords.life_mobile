import 'package:flutter/material.dart';
import 'package:mylastwords/Screens/GalleryScreen/Components/viewImage.dart';
import 'package:mylastwords/Services/user_service.dart';
import 'package:mylastwords/components/header_tab_add.dart';
import 'package:mylastwords/components/header_tab_back.dart';
import 'package:mylastwords/components/header_tab_save.dart';
import 'package:mylastwords/components/rounded_input_field.dart';
import 'package:mylastwords/constants.dart';
import 'package:mylastwords/components/header_tab.dart';
import 'package:mylastwords/data.dart';
import 'package:mylastwords/models/gallery.dart';
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
  String? userImg;
  bool lockInBackground = true;
  final TextEditingController txtEmail = TextEditingController();
  final TextEditingController txtPass = TextEditingController();
  final TextEditingController txtName = TextEditingController();
  final TextEditingController txtContactNumber = TextEditingController();
  final TextEditingController txtAddress = TextEditingController();

  @override
  void initState() {
    loadDetails();
    super.initState();
  }

  loadDetails()async{
      txtName.text = await getName();    
      txtEmail.text = await getEmail();
      userImg = await getUserImgURL();  
      print('this: ' + userImg.toString());
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Orientation orientation = MediaQuery.of(context).orientation;
    return Scaffold(
        appBar: HeaderTabAdd(
            backgroundcolor: headerBackgroundColor,
            title: 'Profile',
            saveFunc: () {}),
        backgroundColor: darkBackground,
        body: Container(
          child: Column(
            children: [
              Expanded(
                flex: 4,
                child: Container(
                  
                  child: OrientationBuilder(
                    builder: (context, orientation) => Center(
                        child: Stack(
                      children: [
                        Container(                          
                          height: size.height * 0.20,
                          width: size.width * 0.40,
                          decoration: BoxDecoration(                            
                              border: Border.all(
                                  width: 5,
                                  color: Theme.of(context)
                                      .scaffoldBackgroundColor),
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  fit: BoxFit.contain,
                                  image: AssetImage(
                                      'assets/images/placeholder.png'))),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            height: size.height * 0.07,
                            width: size.height * 0.07,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    width: 2,
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor),
                                color: lightBackground),
                            child: Icon(Icons.edit, color: darkBackground),
                          ),
                        ),
                      ],
                    )),
                  ),
                ),
              ),
              Expanded(
                flex: 8,
                child: OrientationBuilder(
                  builder: (context, orientation) => Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        RoundedInputField(
                          icon: Icons.email_outlined,
                          controller: txtEmail,
                          hintText: "Email",
                          onChanged: (value) {},
                        ),
                        RoundedInputField(
                          icon: Icons.lock_outline,
                          controller: txtPass,
                          hintText: "Password",
                          onChanged: (value) {},
                        ),
                        RoundedInputField(
                          icon: Icons.person_outline,
                          controller: txtName,
                          hintText: "Full Name",
                          onChanged: (value) {},
                        ),
                        RoundedInputField(
                          icon: Icons.contact_phone_outlined,
                          controller: txtContactNumber,
                          hintText: "Contact Number",
                          onChanged: (value) {},
                        ),
                        RoundedInputField(
                          icon: Icons.location_on_outlined,
                          controller: txtAddress,
                          hintText: "Address",
                          onChanged: (value) {},
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
