import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mylastwords/Services/user_service.dart';
import 'package:mylastwords/components/header_tab_back.dart';
import 'package:mylastwords/components/rounded_button.dart';
import 'package:mylastwords/components/rounded_input_field.dart';
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
  String userImg='';
  bool editableData = true;
  String accountType='';
  String displayUserType='';
  final TextEditingController txtEmail = TextEditingController();
  final TextEditingController txtPass = TextEditingController();
  final TextEditingController txtName = TextEditingController();
  final TextEditingController txtContactNumber = TextEditingController();
  final TextEditingController txtAddress = TextEditingController();

  @override
  void initState() {
    loadDetails();
    accountTypeState();
    super.initState();
  }

  loadDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      txtEmail.text = (prefs.getString('email') ?? '');      
      txtName.text = (prefs.getString('name') ?? '');
      txtContactNumber.text = (prefs.getString('contactNumber') ?? '');
      txtAddress.text = (prefs.getString('address') ?? '');
      userImg = (prefs.getString('userImage') ?? 'https://www.seekpng.com/png/detail/110-1100707_person-avatar-placeholder.png');     
      accountType = (prefs.getString('type') ?? ''); 
    });      
  }

  accountTypeState(){
    if(accountType=="apple"||accountType=="google"||accountType=="facebook"){
      editableData = false;
      displayUserType = "You are now currently logged in with "+accountType;
    }
    else{
      editableData = true;
      displayUserType = "You are using MyLastWords Account";
    }
  }

  updateingValidator() async {
    var errmsg = "";
    if(txtName.text=="")
    {
      errmsg="Please enter your full name";
    }  
    else if(txtContactNumber.text==""){
      errmsg="Please enter your contact number";
    }  
    else if(txtAddress.text==""){
      errmsg="Please enter your complete address";
    }
    else{
      ApiResponse response = await updateUserCall(txtName.text, txtContactNumber.text, txtAddress.text);
        if(response.error==null){
          EasyLoading.showInfo('Successfully Updated User');
          SharedPreferences prefs = await SharedPreferences.getInstance();                     
          await prefs.setString('name',txtName.text);
          await prefs.setString('contactNumber',txtContactNumber.text);
          await prefs.setString('address',txtAddress.text);  
          loadDetails();        
      }
      else{
        ToastMessage().toastMsgError(response.error.toString());
      }
    }
    if(errmsg!=""){
      EasyLoading.showError(errmsg);
    }
    else{}
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
                  Text(
                    displayUserType,
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),                                           
                SizedBox(height: size.height * 0.025),                        
                SizedBox(
                  width:200,
                  height:200,
                  child: ClipRRect(                                                      
                  borderRadius: BorderRadius.circular(150),
                  child: Stack(
                    children: [
                      Container(                                                   
                          decoration: BoxDecoration(                            
                              border: Border.all(
                                  width: 2,
                                  color: headerBackgroundColor),
                              shape: BoxShape.circle,
                              image: DecorationImage(                                
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      userImg))),
                        ), 
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: 50,
                          width: double.infinity,
                          color: Colors.grey.withOpacity(.5),
                          child: Padding(
                            padding: EdgeInsets.all(4.0),
                            child: IconButton(                              
                              onPressed: (){                                
                              }, 
                              icon: Icon(                              
                              Icons.camera_alt_outlined,
                              color:Colors.white
                            ),)
                          ),
                        ),
                        ),
                    ],
                  ),
                ),  
                ),             
                 SizedBox(height: size.height * 0.015),                        
                 RoundedInputField(
                    isEnable: false,
                    icon: Icons.email_outlined,
                    controller: txtEmail,
                    hintText: "Email",
                    onChanged: (value) {},
                  ),                       
                  RoundedInputField(
                    isEnable: editableData,
                    icon: Icons.person_outline,
                    controller: txtName,
                    hintText: "Full Name",
                    onChanged: (value) {},
                  ),
                  RoundedInputField(
                    isEnable: true,
                    icon: Icons.contact_phone_outlined,
                    controller: txtContactNumber,
                    hintText: "Contact Number",
                    onChanged: (value) {},
                  ),
                  RoundedInputField(
                    isEnable: true,
                    icon: Icons.location_on_outlined,
                    controller: txtAddress,
                    hintText: "Address",
                    onChanged: (value) {},
                  ),  
                  RoundedButton(
                    textColor: Colors.white,
                    bgcolor: headerBackgroundColor,
                    text: "Update Profile",
                    press: () {   
                      updateingValidator();                                                                                    
                    },
                  ),     
                  RoundedButton(
                    textColor: Colors.white,
                    bgcolor: headerBackgroundColor,
                    text: "Change Password",
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


