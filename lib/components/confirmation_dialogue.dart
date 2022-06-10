// ignore_for_file: unnecessary_statements

import 'package:flutter/material.dart';
import 'package:mylastwords/Services/user_service.dart';
import 'package:mylastwords/constants.dart';

class ConfirmationDialogue extends StatelessWidget
    implements PreferredSizeWidget {
  final String? title;
  final String? subtitle;
  final void Function() press;

  const ConfirmationDialogue({
    Key? key,
    this.title,
    this.subtitle,
    required this.press,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(60.0);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title!),
      content: Text(subtitle!),
      backgroundColor: lightBackground,
      actions: <Widget>[
        TextButton(
          onPressed: () {
            press;
          },
          child: Text(
            'Yes',
            style: TextStyle(color: txtColorDark, fontSize: 17),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context, rootNavigator: true)
                .pop(false); // dismisses only the dialog and returns false
          },
          child: Text(
            'No',
            style: TextStyle(color: txtColorDark, fontSize: 15),
          ),
        ),
      ],
    );
  }
}
