import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:grace_note/db/model/note.dart';
import 'package:grace_note/ui/component/note_video_view.dart';

class NoteDetailPage extends StatelessWidget {
  NoteDetailPage({Key? key, required this.title, required this.note}) : super(key: key);

  final String title;
  final Note note;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
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
                child: Text(
                  note.content,
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
