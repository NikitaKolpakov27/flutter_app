import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CreateNewLocation extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text(
          "Создание локации",
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
