import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_flutter/character/personality.dart';
import 'dart:convert';

import 'new_character.dart';

class JsonChar extends StatefulWidget {
  const JsonChar({Key? key}) : super(key: key);

  @override
  State<JsonChar> createState() => _JsonHomeState();
}

class _JsonHomeState extends State<JsonChar> {
  List _chars = [];

  // Fetch content from the json file
  Future<void> readJsonFile() async {
    final String response = await rootBundle.loadString('assets/perses.json');
    final data = await jsonDecode(response);
    setState(() {
      _chars = data["perses"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Созданные Персонажи',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: readJsonFile,
              child: const Text('Загрузить созданных персонажей'),
            ),
            // Display the data loaded from movies.json
            _chars.isNotEmpty
                ? Expanded(
              child: ListView.builder(
                  itemCount: _chars.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CharacterView(
                                _chars[index]["id"],
                                _chars[index]["name"],
                                _chars[index]["lastname"],
                                _chars[index]["patronymic"],
                                _chars[index]["sex"],
                                _chars[index]["age"],
                                Personality(_chars[index]["id"],
                                    _chars[index]["personality"][0]["mbti"],
                                    _chars[index]["personality"][0]["temper"])
                            ),
                          ),
                        );
                      },
                      child: Card(
                        margin: const EdgeInsets.all(10),
                        child: ListTile(
                          leading: Text(_chars[index]["id"].toString()),
                          title: Text(_chars[index]["name"] + " " + _chars[index]["lastname"] + " " + _chars[index]["patronymic"]),
                          subtitle: Text("Age: ${_chars[index]["age"]}"),
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