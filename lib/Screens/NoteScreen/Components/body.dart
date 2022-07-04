import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:mylastwords/Screens/DashBoard/dashboard.dart';
import 'package:mylastwords/Screens/GalleryScreen/Components/previewImage.dart';
import 'package:mylastwords/Screens/NoteScreen/Components/addNote.dart';
import 'package:mylastwords/Screens/NoteScreen/Components/previewEditNote.dart';
import 'package:mylastwords/Services/notes_services.dart';
import 'package:mylastwords/components/confirmation_dialogue.dart';
import 'package:mylastwords/constants.dart';
import 'package:mylastwords/components/header_tab.dart';
import 'package:mylastwords/data.dart';
import 'package:mylastwords/models/api_response.dart';
import 'package:mylastwords/models/note.dart';

// import 'package:flutter_svg/svg.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    super.initState();
  }

  ListView _notesListView(data) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return _tile(
              data[index].id,
              data[index].title.toString(),
              data[index].body.toString(),
              DateFormat('MMM dd, yyyy   hh:mm aa')
                  .format(data[index].dateUpdated));
        });
  }

  ListTile _tile(int id, String title, String body, String dateUpdated) =>
      ListTile(
        onTap: (){  Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PreviewEditNote(
                            id: id,
                            keyTitle: title,
                            keyNote: body,
                          )));},
        leading: Icon(
              Icons.notes_outlined,
              color: txtColorLight,
              size: 28,
            ),                        
        title: Text(title,
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20,
                color: txtColorLight)),
        subtitle: Text(dateUpdated, style: TextStyle(color: txtColorLight)),
        
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderTab(
          backgroundcolor: headerBackgroundColor,
          title: 'Notes',
          iconbtn: Icons.note_add_outlined,
          press: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return AddNote();
                },
              ),
            );
          }),
      backgroundColor: darkBackground,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 25),
          Expanded(
            child: FutureBuilder<List<NotesModel>>(
              future: fetchNotes(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<NotesModel>? data = snapshot.data;
                  if(snapshot.data!.length<=0){
                    return Center(
                      child: Center(
                        child:  Text(
                                'Notes empty',
                                style: TextStyle(
                                  color: txtColorLight,
                                  fontSize: 30,
                                ),
                              ),
                      ),
                    );
                  }
                  else{
                    return _notesListView(data);
                  }
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return Center(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
