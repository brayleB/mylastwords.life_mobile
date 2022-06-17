// ignore_for_file: must_be_immutable, unused_local_variable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mylastwords/Screens/DashBoard/dashboard.dart';
import 'package:mylastwords/Screens/GalleryScreen/gallery_screen.dart';
import 'package:mylastwords/Services/gallery_services.dart';
import 'package:mylastwords/Services/notes_services.dart';
import 'package:mylastwords/components/header_tab_add.dart';
import 'package:mylastwords/components/header_tab_save.dart';
import 'package:mylastwords/constants.dart';
import 'package:mylastwords/models/api_response.dart';
import 'package:mylastwords/models/gallery.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class PreviewImage extends StatelessWidget {
  final File? fileImage;

  PreviewImage({Key? key, required this.fileImage}) : super(key: key);

  void _saveImage() async {
    ApiResponse response = await uploadImage(fileImage!);
    print(response.error.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderTabAdd(
        backgroundcolor: headerBackgroundColor,
        title: "Preview",
        saveFunc: () {
          _saveImage();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return DashBoard();
              },
            ),
          );
        },       
      ),      
      body: SingleChildScrollView(
        child: Card(
            child: Column(
          children: <Widget>[Image.file(File(fileImage!.path))],
        )),
      ),
    );
  }
}
