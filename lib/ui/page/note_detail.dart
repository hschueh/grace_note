import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:grace_note/db/model/note.dart';
import 'package:grace_note/ui/component/note_video_view.dart';
import 'package:video_player/video_player.dart';

class NoteDetailPage extends StatefulWidget {
  const NoteDetailPage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<NoteDetailPage> createState() => _NoteDetailPageState();
}

class _NoteDetailPageState extends State<NoteDetailPage> {
  Note note = Note(
      NoteType.video,
      "A\nB\n測試\n測試\n測試\n測試\n測試\n測試\nC\n測試\nD\n測試\n測試\n測試\n測試\n測試\nR\n測試\n測試\n測試\n測試\nGGGGGG\nE\n測試\n",
      "assets/ignore/sample.MOV");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          (note.type == NoteType.video)
              ? NoteVideoView(path: note.coverPath!)
              : Text(note.content),
          Expanded(
            child: SingleChildScrollView(
              child: SizedBox(
                width: double.infinity,
                child: Text(note.content, textAlign: TextAlign.start),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
