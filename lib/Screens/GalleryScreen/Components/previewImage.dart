// ignore_for_file: must_be_immutable, unused_local_variable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mylastwords/Screens/DashBoard/dashboard.dart';
import 'package:mylastwords/components/header_tab_save.dart';
import 'package:mylastwords/constants.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class PreviewImage extends StatelessWidget {
  File? fileImage;

  PreviewImage({Key? key, required this.fileImage}) : super(key: key);

  void _saveImage() async {
    final Directory path = await getApplicationDocumentsDirectory();
    String dirPath = path.path;
    final fileName = basename(fileImage!.path);
    final File localImage = await fileImage!.copy('$dirPath/$fileName');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderTabSave(
        backgroundcolor: headerBackgroundColor,
        title: "Preview",
        press: () {
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
