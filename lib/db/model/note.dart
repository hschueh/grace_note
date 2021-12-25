class Note {
  String? coverPath;
  NoteType type;
  String content;

  Note(this.type, this.content, this.coverPath);
}

enum NoteType {
  video,
  audio,
  image,
  none
}