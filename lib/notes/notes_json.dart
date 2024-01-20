import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

import 'package:test_flutter/notes/new_note.dart';

class JsonNote extends StatefulWidget {
  const JsonNote({Key? key}) : super(key: key);

  @override
  State<JsonNote> createState() => _JsonHomeState();
}

class _JsonHomeState extends State<JsonNote> {
  List _notes = [];

  // Fetch content from the json file
  Future<void> readJsonFile() async {
    final String response = await rootBundle.loadString('assets/notes.json');
    final data = await jsonDecode(response);
    setState(() {
      _notes = data["notes"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Заметки',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: readJsonFile,
              child: const Text('Загрузить заметки'),
            ),
            // Display the data loaded from movies.json
            _notes.isNotEmpty
                ? Expanded(
              child: ListView.builder(
                  itemCount: _notes.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NoteView(
                                _notes[index]["id"],
                                _notes[index]["note_title"],
                                _notes[index]["note_text"]
                            ),
                          ),
                        );
                      },
                      child: Card(
                        margin: const EdgeInsets.all(10),
                        child: ListTile(
                          leading: Text(_notes[index]["id"].toString()),
                          title: Text(_notes[index]["note_title"]),
                        ),
                      ),
                    );
                  }),
            )
                : Container(),
          ],
        ),
      ),
    );
  }
}