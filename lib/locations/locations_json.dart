import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

import 'package:test_flutter/locations/new_location.dart';

class JsonLocation extends StatefulWidget {
  const JsonLocation({Key? key}) : super(key: key);

  @override
  State<JsonLocation> createState() => _JsonHomeState();
}

class _JsonHomeState extends State<JsonLocation> {
  List _locations = [];

  // Fetch content from the json file
  Future<void> readJsonFile() async {
    final String response = await rootBundle.loadString('assets/locations.json');
    final data = await jsonDecode(response);
    setState(() {
      _locations = data["locations"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Локации',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: readJsonFile,
              child: const Text('Загрузить локации'),
            ),
            // Display the data loaded from movies.json
            _locations.isNotEmpty
                ? Expanded(
              child: ListView.builder(
                  itemCount: _locations.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LocationView(
                                _locations[index]["id"],
                                _locations[index]["location_name"],
                                _locations[index]["description"]
                            ),
                          ),
                        );
                      },
                      child: Card(
                        margin: const EdgeInsets.all(10),
                        child: ListTile(
                          leading: Text(_locations[index]["id"].toString()),
                          title: Text(_locations[index]["location_name"]),
                          subtitle: Text(_locations[index]["description"]),
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