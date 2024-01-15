import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

class JsonStory extends StatefulWidget {
  const JsonStory({Key? key}) : super(key: key);

  @override
  State<JsonStory> createState() => _JsonHomeState();
}

class _JsonHomeState extends State<JsonStory> {
  List _stories = [];

  // Fetch content from the json file
  Future<void> readJsonFile() async {
    final String response = await rootBundle.loadString('assets/stories.json');
    final data = await jsonDecode(response);
    setState(() {
      _stories = data["stories"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Истории',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: readJsonFile,
              child: const Text('Загрузить истории'),
            ),
            // Display the data loaded from movies.json
            _stories.isNotEmpty
                ? Expanded(
              child: ListView.builder(
                  itemCount: _stories.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: const EdgeInsets.all(10),
                      child: ListTile(
                        leading: Text(_stories[index]["id"].toString()),
                        title: Text(_stories[index]["title"]),
                        subtitle: Text(_stories[index]["genre"]),
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