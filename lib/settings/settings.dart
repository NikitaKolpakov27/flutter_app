import 'package:flutter/material.dart';
import 'package:test_flutter/colors.dart';


void main() {
  runApp(Setting());
}


class Setting extends StatelessWidget {
  Setting({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Settings(),
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
  TextStyle selectedOption = const TextStyle(fontSize: 20.0, color: Colors.white, fontFamily: 'Courier New');
  FontStyle? selectedFontStyle = FontStyle.normal;
  FontWeight? selectedFontWeight = FontWeight.normal;

  Color selectedColor = Colors.white;
  String? selectedFont = 'Times New Roman';
  var current_style = const TextStyle(fontSize: 20.0, color: Colors.white, fontFamily: 'Courier New');


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backColor,
      appBar: AppBar(
        backgroundColor: MyColors.primaryColor,
        title: const Text(
          "Настройки приложения",
          style: TextStyle(
              fontSize: 20.0,
              color: Colors.white
          ),
        ),
      ),

      body: Center(
        child: ListView(
            scrollDirection: Axis.vertical,
            children: <Widget>[

              const Divider(
                indent: double.infinity,
              ),

              const Center(
                child: Text(
                  'Начертание:',
                  style: TextStyle(
                      fontSize: 24.0,
                      color: Colors.black,
                      fontFamily: 'Bajkal'
                  ),
                ),
              ),
              const Divider(
                indent: double.infinity,
              ),

              ListTile(
                title: const Text(
                    'Курсив', style: TextStyle(fontSize: 16.0, fontStyle: FontStyle.italic),
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
                    'Полужирный текст', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
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

              Padding(
                padding: const EdgeInsets.only(left: 64.0, right: 64.0),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(MyColors.primaryColor)
                  ),
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
              ),

              const Divider(
                indent: double.infinity,
              ),

              const Center(
                child: Text(
                  'Цвет:',
                  style: TextStyle(
                      fontSize: 24.0,
                      color: Colors.black,
                      fontFamily: 'Bajkal'
                  ),
                ),
              ),
              const Divider(
                indent: double.infinity,
              ),
              ListTile(
                title: const Text(
                    'Синий', style: TextStyle(fontSize: 18.0, color: Colors.blue),
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
                    'Черный', style: TextStyle(fontSize: 18.0, color: Colors.black),
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
                  'Белый', style: TextStyle(fontSize: 18.0, color: Colors.white),
                ),
                leading: Radio<Color>(
                  value: Colors.white,
                  groupValue: selectedColor,
                  onChanged: (Color? value) {
                    setState(() {
                      selectedColor = value!;
                    });
                  },
                ),
              ),

              const Divider(
                indent: double.infinity,
              ),

              const Center(
                child: Text(
                  'Шрифт:',
                  style: TextStyle(
                      fontSize: 24.0,
                      color: Colors.black,
                      fontFamily: 'Bajkal'
                  ),
                ),
              ),

              const Divider(
                indent: double.infinity,
              ),

              ListTile(
                title: const Text(
                  'Courier New',
                  style: TextStyle(fontSize: 18.0, fontFamily: 'Courier New'),
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
                  'Arial', style: TextStyle(fontSize: 18.0, fontFamily: 'Arial'),
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
                  'Times New Roman', style: TextStyle(fontSize: 18.0, fontFamily: 'Times New Roman'),
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

              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 72, right: 72),
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(MyColors.primaryColor)
                  ),
                  onPressed: () {
                    setState(() {
                      current_style = TextStyle(
                          fontSize: 18.0,
                          color: selectedColor,
                          fontFamily: selectedFont,
                          fontStyle: selectedFontStyle,
                          fontWeight: selectedFontWeight
                      );
                      isPressed = !isPressed;
                      Navigator.pop(context, current_style);
                    });
                  },
                  child: const Text(
                    'Применить',
                    style: TextStyle(
                      fontSize: 16
                    ),
                  ),
                ),
              ),
            ]
        )
      ),
    );
  }
}