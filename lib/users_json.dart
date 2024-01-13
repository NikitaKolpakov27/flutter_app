import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

class JsonUser extends StatefulWidget {
  const JsonUser({Key? key}) : super(key: key);

  @override
  State<JsonUser> createState() => _JsonHomeState();
}

class _JsonHomeState extends State<JsonUser> {
  List _users = [];

  // Fetch content from the json file
  Future<void> readJsonFile() async {
    final String response = await rootBundle.loadString('assets/users.json');
    final data = await jsonDecode(response);
    setState(() {
      _users = data["users"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Пользователи Приложения',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: readJsonFile,
              child: const Text('Load Json data'),
            ),
            // Display the data loaded from movies.json
            _users.isNotEmpty
                ? Expanded(
              child: ListView.builder(
                  itemCount: _users.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: const EdgeInsets.all(10),
                      child: ListTile(
                        leading: Text(_users[index]["id"].toString()),
                        title: Text(_users[index]["login"]),
                        subtitle: Text(_users[index]["email"]),
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