// ignore_for_file: must_be_immutable, unused_local_variable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mylastwords/Screens/GalleryScreen/gallery_screen.dart';
import 'package:mylastwords/Screens/Welcome/components/background.dart';
import 'package:mylastwords/Services/gallery_services.dart';

import 'package:mylastwords/components/header_tab_add.dart';
import 'package:mylastwords/components/rounded_input_field.dart';
import 'package:mylastwords/components/text_field_container.dart';
import 'package:mylastwords/components/toastmessage.dart';

import 'package:mylastwords/constants.dart';
import 'package:mylastwords/models/api_response.dart';



class PreviewImage extends StatelessWidget {
  final File? fileImage;
  final TextEditingController imageTitle = TextEditingController();
  PreviewImage({Key? key, required this.fileImage}) : super(key: key);

 

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;    
    return Scaffold(
      backgroundColor: lightBackground,
      appBar: HeaderTabAdd(
        backgroundcolor: headerBackgroundColor,
        title: "Preview",
        saveFunc: () async {
          ApiResponse response = await uploadImage(fileImage!);   
          if(response.error==null){
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => GalleryScreen()),(route) => false);
          }
          else{
            ToastMessage().toastMsgError(response.error.toString());
          }
        },       
      ),    
      body:   SingleChildScrollView(
            child: Container(                       
            margin: EdgeInsets.only(top:size.height*0.025),
            alignment: Alignment.center,
            child: Column(   
              crossAxisAlignment: CrossAxisAlignment.center,          
              children: <Widget>[  
                  Text(
                    'Image Preview',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                        SizedBox(height: size.height * 0.025),
                         Container(  
             height: size.height *.5,     
            decoration: BoxDecoration(image: DecorationImage(
                                  image: FileImage(File(fileImage!.path)),
                                  fit: BoxFit.contain), ),                  
           ),  
            SizedBox(height: size.height * 0.025),  
          TextFieldContainer(
      child: TextField(
       
       style: TextStyle(fontSize: 13.0, color: Colors.black),
       
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
         
          hintText: 'Name this photo',
          border: InputBorder.none,
        ),
      ),
    )
           
                   ]
            ),  
            ),
            )           
      //Container(  
      //       padding: const EdgeInsets.all(10.0),   
      //       decoration: BoxDecoration(image: DecorationImage(
      //                             image: FileImage(File(fileImage!.path)),
      //                             fit: BoxFit.contain), ),                  
      //      ),      
    );
  }
}
