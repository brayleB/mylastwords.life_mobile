// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mylastwords/Screens/DashBoard/dashboard.dart';
import 'package:mylastwords/Screens/NoteScreen/note_screen.dart';
import 'package:mylastwords/Services/notes_services.dart';
import 'package:mylastwords/Services/user_service.dart';
import 'package:mylastwords/components/header_tab_save.dart';
import 'package:mylastwords/components/toastmessage.dart';
import 'package:mylastwords/constants.dart';
import 'package:mylastwords/components/header_tab.dart';
import 'package:mylastwords/data.dart';
import 'package:mylastwords/models/api_response.dart';
import 'package:mylastwords/models/note.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter_svg/svg.dart';

class PreviewEditNote extends StatefulWidget {
  final int id;
  final String keyTitle;
  final String keyNote;
  final String keyInstruct;
  final String keyContact;
  const PreviewEditNote(
      {Key? key, required this.id, required this.keyTitle, required this.keyNote, required this.keyInstruct, required this.keyContact})
      : super(
          key: key,
        );

  @override
  _PreviewEditNoteState createState() => _PreviewEditNoteState();
}

class _PreviewEditNoteState extends State<PreviewEditNote> {
  final TextEditingController txtBody = TextEditingController();
  final TextEditingController txtTitle = TextEditingController();
  final TextEditingController txtInstruct = TextEditingController();
  final TextEditingController txtContact = TextEditingController();
  void _validateAddNote() async {
    var errmsg = "";
    String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(patttern);
    if (txtBody.text == "") {
      errmsg = "Please enter a note";
    }
    else if (txtTitle.text == "") {
      errmsg = "Please enter a Title";
    }  
    else if (txtInstruct.text == "") {
      errmsg = "Please enter a instruction";
    } 
    else if (txtContact.text == "") {
      errmsg = "Please enter contact number";      
    } 
    else if (!regExp.hasMatch(txtContact.text)) {
      errmsg = "Contact number invalid";
    }   
    else {
          ApiResponse response = await updateNote(widget.id, txtTitle.text, txtBody.text, txtInstruct.text, txtContact.text);
          if(response.error==null){
            ToastMessage().toastMsgDark('Note updated');    
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => NoteScreen()),(route) => false);                    
          }
          else{
            ToastMessage().toastMsgError('Note updating error');
          }
    }
    if (errmsg != "") {
      ToastMessage().toastMsgLight(errmsg);
    }
  }

  @override
  void initState() {
    txtTitle.text = widget.keyTitle;
    txtBody.text = widget.keyNote;
    txtInstruct.text = widget.keyInstruct;
    txtContact.text = widget.keyContact;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: HeaderTabSave(
        backgroundcolor: headerBackgroundColor,
        title: '',
        saveFunc: () {
          _validateAddNote();
        },
        delFunc: () {
          showDialog(                            
              context: context,
              barrierDismissible: false,
              barrierColor: Colors.black.withOpacity(.4),
              builder: (context) {
                return AlertDialog(
                        title: Text('Are you sure you want to remove this note?'),                                      
                        actions: <Widget>[
                          TextButton(
                            onPressed: () async {
                                  ApiResponse apiResponse = await deleteNote(widget.id);
                                  if(apiResponse.error==null){
                                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => NoteScreen()),(route) => false);
                                  }  
                            },
                            child: Text(
                              'Yes',
                              style: TextStyle(color: txtColorDark, fontSize: 15),
                            ),
                          ),
                          TextButton(
                            onPressed: () async {
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Cancel',
                              style: TextStyle(color: txtColorDark, fontSize: 15),
                            ),
                          ),
                        ],
                      );
              },
            );            
      },
      ),
      backgroundColor: darkBackground,
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.only(top: 10, left: 15, right: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            ),
            color: txtColorLight,
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: TextField(
                controller: txtTitle,
                maxLines: 1,
                maxLength: 100,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration.collapsed(hintText: "Title..."),
                style: TextStyle(
                    color: txtColorDark,
                    fontSize: 18,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ),
          //special instructions        
            Card(
              margin: EdgeInsets.only(top: 2, left: 15, right: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(1))),            
              color: txtColorLight,
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: TextField(
                  controller: txtInstruct,
                  maxLines: 2,
                  maxLength: 150,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration.collapsed(hintText: "Special Instructions..."),
                  style: TextStyle(
                      color: txtColorDark,
                      fontSize: 18,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
  //contact info       
            Card(
              margin: EdgeInsets.only(top: 2, left: 15, right: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(1))),            
              color: txtColorLight,
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: TextField(
                  controller: txtContact,
                  maxLines: 1,
                  maxLength: 50,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration.collapsed(hintText: "Contact Information..."),
                  style: TextStyle(
                      color: txtColorDark,
                      fontSize: 18,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),   
          Card(
            margin: EdgeInsets.only(top: 2, left: 15, right: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
            ),
            color: txtColorLight,
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: TextField(
                controller: txtBody,
                maxLines: 20,
                maxLength: 1000,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration.collapsed(hintText: "Body..."),
                style: TextStyle(
                    color: txtColorDark,
                    fontSize: 17,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
