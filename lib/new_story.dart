import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CreateNewStory extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text(
          "Создание истории",
          style: TextStyle(
              fontSize: 20.0,
              fontStyle: FontStyle.italic,
              color: Colors.white
          ),
        ),
      ),


    );
  }
}
