// ignore_for_file: unnecessary_statements

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mylastwords/Services/user_service.dart';
import 'package:mylastwords/constants.dart';

class ToastMessage {
  void toastMsgDark(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: darkBackground,
        textColor: txtColorLight,
        fontSize: 15.0);
  }

  void toastMsgLight(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: lightBackground,
        textColor: txtColorDark,
        fontSize: 15.0);
  }

  void toastMsgError(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.white,
        textColor: Colors.red[900],
        fontSize: 15.0);
  }
}
