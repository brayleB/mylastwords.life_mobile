class Note {
  int? id;
  int? userId;
  String? title;
  String? body;

  Note({
    this.id,
    this.userId,
    this.title,
    this.body,
  });

  //function to convrt json data to notes model
  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['notes']['id'],
      userId: json['notes']['userId'],
      title: json['notes']['title'],
      body: json['notes']['body'],
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

  NoteList({
    this.id,
    this.userId,
    this.title,
    this.body,
  });

  //function to convrt json data to notes model
  factory NoteList.fromJson(Map<String, dynamic> json) {
    return NoteList(
      id: json["id"],
      userId: json["userId"],
      title: json["title"],
      body: json["body"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "userId": userId,
      "title": title,
      "body": body,
    };
  }
}

class NotesModel {
  final int? id;
  final String? title;
  final String? body;
  final DateTime? dateUpdated;
  final List<NoteList> notelist;

  NotesModel(
      {required this.notelist,
      required this.id,
      required this.title,
      required this.body,
      required this.dateUpdated});

  factory NotesModel.fromJson(Map<String, dynamic> data) {
    // cast to a nullable list as the reviews may be missing
    final notesdata = data['notes'] as List<dynamic>?;
    // if the reviews are not missing
    final notelist = notesdata != null
        // map each review to a Review object
        ? notesdata
            .map((notesdata) => NoteList.fromJson(notesdata))
            // map() returns an Iterable so we convert it to a List
            .toList()
        // use an empty list as fallback value
        : <NoteList>[];
    // return result passing all the arguments
    return NotesModel(
        notelist: notelist,
        id: data['id'],
        title: data['title'],
        body: data['body'],
        dateUpdated: DateTime.parse(data["updated_at"]));
  }
}

class Job {
  final int id;
  final String position;
  final String company;
  final String description;

  Job(
      {required this.id,
      required this.position,
      required this.company,
      required this.description});

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      id: json['id'],
      position: json['position'],
      company: json['company'],
      description: json['description'],
    );
  }
}
