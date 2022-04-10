import 'package:flutter/foundation.dart';

class Note {
  String? coverPath;
  String? thumbnail;
  NoteType type;
  String content;
  String? date;

  Note(this.type, this.content, this.coverPath, this.thumbnail, this.date);

  Note.fromJson(Map<String, dynamic> map):
      type = NoteType.values.firstWhere((element) => describeEnum(element) == map["type"]),
      content = map["content"],
      coverPath = map["coverPath"],
      thumbnail = map["thumbnail"],
      date = map["date"];
}

enum NoteType {
  video,
  audio,
  image,
  none
}