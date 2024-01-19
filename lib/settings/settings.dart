import 'dart:ui';
import 'package:flutter/material.dart';


void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: const Settings(),
      debugShowCheckedModeBanner: false,
    );
  }
}


class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}


class _SettingsState extends State<Settings> {
  bool isPressed = false;

  // Параметры для настройки
  TextStyle selectedOption = TextStyle(fontSize: 20.0, color: Colors.white, fontFamily: 'Courier New');
  FontStyle? selectedFontStyle = FontStyle.normal;
  FontWeight? selectedFontWeight = FontWeight.normal;

  Color selectedColor = Colors.white;

  String? selectedFont = 'Times New Roman';

  var current_style = TextStyle(fontSize: 20.0, color: Colors.white, fontFamily: 'Courier New');


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(

        child: Column(
            children: <Widget>[
              const Center(
                child: Text(
                  'Начертание:',
                  style: TextStyle(fontSize: 20.0, color: Colors.black),
                ),
              ),
              const Divider(),
              ListTile(
                title: const Text(
                    'Курсив', style: TextStyle(fontSize: 20.0, fontStyle: FontStyle.italic),
                ),
                leading: Radio<FontStyle>(
                  value: FontStyle.italic,
                  groupValue: selectedFontStyle,
                  onChanged: (FontStyle? value) {
                    setState(() {
                      selectedFontStyle = value!;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text(
                    'Полужирный текст', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                leading: Radio<FontWeight>(
                  value: FontWeight.bold,
                  groupValue: selectedFontWeight,
                  onChanged: (FontWeight? value) {
                    setState(() {
                      selectedFontWeight = value!;
                    });
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    selectedFontWeight = null;
                    selectedFontStyle = null;
                  });
                },
                child: const Text(
                  'Очистить выбор',
                ),
              ),
              const Divider(),
              const Center(
                child: Text(
                  'Цвет:',
                  style: TextStyle(fontSize: 20.0, color: Colors.black),
                ),
              ),
              const Divider(),
              ListTile(
                title: const Text(
                    'Синий', style: TextStyle(fontSize: 20.0, color: Colors.blue),
                ),
                leading: Radio<Color>(
                  value: Colors.blue,
                  groupValue: selectedColor,
                  onChanged: (Color? value) {
                    setState(() {
                      selectedColor = value!;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text(
                    'Черный', style: TextStyle(fontSize: 20.0, color: Colors.black),
                ),
                leading: Radio<Color>(
                  value: Colors.black,
                  groupValue: selectedColor,
                  onChanged: (Color? value) {
                    setState(() {
                      selectedColor = value!;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text(
                  'Желтый', style: TextStyle(fontSize: 20.0, color: Colors.yellow),
                ),
                leading: Radio<Color>(
                  value: Colors.yellow,
                  groupValue: selectedColor,
                  onChanged: (Color? value) {
                    setState(() {
                      selectedColor = value!;
                    });
                  },
                ),
              ),

              const Divider(),
              const Center(
                child: Text(
                  'Шрифт:',
                  style: TextStyle(fontSize: 20.0, color: Colors.black),
                ),
              ),
              const Divider(),
              ListTile(
                title: const Text(
                  'Courier New', style: TextStyle(fontSize: 20.0),
                ),
                leading: Radio<String>(
                  value: 'Courier New',
                  groupValue: selectedFont,
                  onChanged: (String? value) {
                    setState(() {
                      selectedFont = value!;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text(
                  'Arial', style: TextStyle(fontSize: 20.0),
                ),
                leading: Radio<String>(
                  value: 'Arial',
                  groupValue: selectedFont,
                  onChanged: (String? value) {
                    setState(() {
                      selectedFont = value!;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text(
                  'Times New Roman', style: TextStyle(fontSize: 20.0),
                ),
                leading: Radio<String>(
                  value: 'Times New Roman',
                  groupValue: selectedFont,
                  onChanged: (String? value) {
                    setState(() {
                      selectedFont = value!;
                    });
                  },
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(textStyle: current_style),
                onPressed: () {
                  setState(() {
                    current_style = TextStyle(
                        fontSize: 20.0,
                        color: selectedColor,
                        fontFamily: selectedFont,
                        fontStyle: selectedFontStyle,
                        fontWeight: selectedFontWeight
                    );
                    isPressed = !isPressed;
                  });
                },
                child: Text(
                  'Press Here',
                  style: current_style,
                ),
              ),
            ]
        )
      ),
    );
  }
}