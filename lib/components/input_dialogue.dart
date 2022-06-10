// ignore_for_file: unnecessary_statements

import 'package:flutter/material.dart';
import 'package:mylastwords/Services/user_service.dart';
import 'package:mylastwords/constants.dart';

class InputDialogue extends StatelessWidget
    implements PreferredSizeWidget {
  final String? title;  
  final Function() press;
  final TextEditingController controller;

  const InputDialogue({
    Key? key,
    required this.controller,
    this.title,    
    required this.press,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(60.0);

  @override
  Widget build(BuildContext context) {    
    return AlertDialog(
       title: Text(title!),
          content: TextField(
            onChanged: (value) {     
            },
            controller: controller,
            decoration: InputDecoration(hintText: "Enter here"),
          ),
           actions: <Widget>[
        TextButton(
          onPressed: () {
            press;
          },
          child: Text(
            'Ok',
            style: TextStyle(color: txtColorDark, fontSize: 15),
          ),
        ),
    
      ],
    );
  }
}
