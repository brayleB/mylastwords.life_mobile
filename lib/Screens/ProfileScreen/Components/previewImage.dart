// ignore_for_file: must_be_immutable, unused_local_variable

import 'dart:io';

import 'package:flutter/material.dart';

import 'package:mylastwords/Services/gallery_services.dart';

import 'package:mylastwords/components/header_tab_add.dart';
import 'package:mylastwords/components/toastmessage.dart';

import 'package:mylastwords/constants.dart';
import 'package:mylastwords/models/api_response.dart';



class PreviewImage extends StatelessWidget {
  final File? fileImage;

  PreviewImage({Key? key, required this.fileImage}) : super(key: key);

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderTabAdd(
        backgroundcolor: headerBackgroundColor,
        title: "Preview",
        saveFunc: () async {
        }
      ),      
      body: Container(  
            padding: const EdgeInsets.all(10.0),   
            decoration: BoxDecoration(image: DecorationImage(
                                  image: FileImage(File(fileImage!.path)),
                                  fit: BoxFit.contain), ),                  
           ),      
    );
  }
}
