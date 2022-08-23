class Note {
  int? id;
  int? userId;
  String? title;
  String? body;
  String? instructions;
  String? contact;


  Note({
    this.id,
    this.userId,
    this.title,
    this.body,
    this.instructions,
    this.contact
  });

  //function to convrt json data to notes model
  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['notes']['id'],
      userId: json['notes']['userId'],
      title: json['notes']['title'],
      body: json['notes']['body'],
      instructions: json['notes']['instructions'],
      contact: json['notes']['contact']
    );
  }

  // Map<String, dynamic> toMap() => {
  //       "id": id,
  //       "userId": userId,
  //       "title": title,
  //       "body":body,
  //       "dateTime": dateTime?.toIso8601String(),
  //     };
}

class NoteList {
  final int? id;
  final int? userId;
  final String? title;
  final String? body;
  final String? instructions;
  final String? contact;

  NoteList({
    this.id,
    this.userId,
    this.title,
    this.body,
    this.instructions,
    this.contact
  });

  //function to convrt json data to notes model
  factory NoteList.fromJson(Map<String, dynamic> json) {
    return NoteList(
      id: json["id"],
      userId: json["userId"],
      title: json["title"],
      body: json["body"],
      instructions: json["instructions"],
      contact: json["contact"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "userId": userId,
      "title": title,
      "body": body,
      "instructions":instructions,
      "contact":contact
    };
  }
}

class NotesModel {
  final int? id;
  final String? title;
  final String? body;
  final String? instructions;
  final String? contact;
  final DateTime? dateUpdated;
  final List<NoteList> notelist;

  NotesModel(
      {required this.notelist,
      required this.id,
      required this.title,
      required this.body,
      required this.instructions,
      required this.contact,
      required this.dateUpdated});

  factory NotesModel.fromJson(Map<String, dynamic> data) {    
    final notesdata = data['notes'] as List<dynamic>?;   
    final notelist = notesdata != null      
        ? notesdata
            .map((notesdata) => NoteList.fromJson(notesdata))         
            .toList()        
        : <NoteList>[];  
    return NotesModel(
        notelist: notelist,
        id: data['id'],
        title: data['title'],
        body: data['body'],
        instructions: data['instructions'],
        contact: data['contact'],
        dateUpdated: DateTime.parse(data["updated_at"]));
  }
}

