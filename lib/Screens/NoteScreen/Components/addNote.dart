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

  void _validateAddNote() async {
    var errmsg = "";
    if (txtNote.text == "") {
      errmsg = "Please enter a note";
    }
    if (txtTitle.text == "") {
      errmsg = "Please enter a Title";
    } else {
      ApiResponse response = await addNote(txtTitle.text, txtNote.text);
      if (response.error == null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return DashBoard();
            },
          ),
        );
        ToastMessage().toastMsgDark('Added Successful');
      } else {
        ToastMessage().toastMsgDark('${response.error}');
      }
    }
    if (errmsg == "") {}
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
      appBar: HeaderTabSave(
        backgroundcolor: headerBackgroundColor,
        title: 'Add Note',
        press: () {
          _validateAddNote();
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
                controller: txtNote,
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
