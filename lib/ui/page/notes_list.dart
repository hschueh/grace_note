import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:grace_note/db/model/note.dart';
import 'package:grace_note/ui/component/note_grid_view.dart';
import 'package:grace_note/ui/page/note_detail.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class NotesListPage extends StatefulWidget {
  const NotesListPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<NotesListPage> createState() => _NotesListPageState();
}

class _NotesListPageState extends State<NotesListPage> {
  List<Note> _notes = <Note>[];

  _NotesListPageState() {
    retrieveVocabularyList();
  }

  void retrieveVocabularyList() async {
    List<Note> list = List.empty(growable: true);
    String contents = await rootBundle.loadString("assets/ignore/list.json");
    list.insertAll(
        0,
        json
            .decode(contents)
            .map<Note>((json) => Note.fromJson(json))
            .toList());
    setState(() {
      _notes = list;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 3,
        children: _notes
            .map((note) => GestureDetector(
                  child: NoteGridView(note: note),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NoteDetailPage(
                          title: "Title",
                          note: note,
                        ),
                      ),
                    );
                  },
                ))
            .toList(),
      ),
    );
  }
}
