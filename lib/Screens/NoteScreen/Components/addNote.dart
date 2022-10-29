import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mylastwords/Screens/NoteScreen/note_screen.dart';
import 'package:mylastwords/Services/notes_services.dart';
import 'package:mylastwords/Services/user_service.dart';
import 'package:mylastwords/components/header_tab_add.dart';
import 'package:mylastwords/components/header_tab_save.dart';
import 'package:mylastwords/components/toastmessage.dart';
import 'package:mylastwords/constants.dart';
import 'package:mylastwords/components/header_tab.dart';
import 'package:mylastwords/data.dart';
import 'package:mylastwords/models/api_response.dart';
import 'package:mylastwords/models/note.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter_svg/svg.dart';

class AddNote extends StatefulWidget {
  const AddNote({
    Key? key,
  }) : super(key: key);

  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  final TextEditingController txtNote = TextEditingController();
  final TextEditingController txtTitle = TextEditingController();
  final TextEditingController txtSpecialIns = TextEditingController();
  final TextEditingController txtContactInfo = TextEditingController();

  void _validateAddNote() async {
    var errmsg = "";    
    if (txtNote.text == "") {
      errmsg = "Please enter a Note";
    }
    else if (txtTitle.text == "") {
      errmsg = "Please enter a Title";
    }
    else if (txtSpecialIns.text == "") {
      errmsg = "Please enter a instruction";
    } 
    else if (txtContactInfo.text == "") {
      errmsg = "Please enter contact number";
    } 
    else {
      ApiResponse response = await addNote(txtTitle.text, txtNote.text, txtSpecialIns.text, txtContactInfo.text);
      if (response.error == null) {
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => NoteScreen()),(route) => false);       
      } else {
        ToastMessage().toastMsgDark('${response.error}');
      }
    }
    if (errmsg != "") {
      ToastMessage().toastMsgDark(errmsg);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: HeaderTabAdd(
        backgroundcolor: headerBackgroundColor,
        title: 'Add Note',
        saveFunc: () {
          _validateAddNote();
        },
      ),
      backgroundColor: darkBackground,
      body: SingleChildScrollView(child: 
          Column(
           children: <Widget>[
//title/to whom          
            Card(
              margin: EdgeInsets.only(top: 10, left: 15, right: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              ),
              color: txtColorLight,
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: TextField( 
                  textCapitalization: TextCapitalization.sentences,                
                  controller: txtTitle,
                  maxLines: 1,
                  maxLength: 100,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration.collapsed(hintText: "To whom / Title"),
                  style: TextStyle(
                      color: txtColorDark,
                      fontSize: 16,
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
                 padding: EdgeInsets.all(10.0),
                child: TextField(
                   textCapitalization: TextCapitalization.sentences, 
                  controller: txtSpecialIns,
                  maxLines: 2,
                  maxLength: 150,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration.collapsed(hintText: "Special Instruction"),
                  style: TextStyle(
                      color: txtColorDark,
                      fontSize: 16,
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
                 padding: EdgeInsets.all(10.0),
                child: TextField(
                  controller: txtContactInfo,
                  maxLines: 1,
                  maxLength: 50,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration.collapsed(hintText: "Email or Phone No."),
                  style: TextStyle(
                      color: txtColorDark,
                     fontSize: 16,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),          
  //body          
            Card(
              margin: EdgeInsets.only(top: 2, left: 15, right: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
              ),
              color: txtColorLight,
              child: Padding(
                  padding: EdgeInsets.all(10.0),
                child: TextField(                             
                  textCapitalization: TextCapitalization.sentences,
                  controller: txtNote,
                  maxLines: 30,
                  maxLength: 1000,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration.collapsed(hintText: "Body..."),
                  style: TextStyle(
                      color: txtColorDark,
                    fontSize: 15,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
