import 'package:flutter/material.dart';
import 'package:test_flutter/navigation/main_menu.dart';

class EditorView extends StatefulWidget {
  const EditorView({super.key});


  @override
  State<EditorView> createState() => _EditorView();
}

class _EditorView extends State<EditorView> {
  static const Color primaryColor = Color(0xffe36b44);
  static const Color backColor =  Color(0xffffe5b9);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backColor,
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: const Text(
            "Обновление данных",
            style: TextStyle(fontSize: 25.0),
          ),
        ),

        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            const Divider(
              indent: double.infinity,
            ),

            const Text(
              'Объект был успешно изменен!',
              style: TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Bajkal',
                  color: primaryColor
              ),
            ),
            const Divider(
              indent: double.infinity,
            ),

            Padding(
              padding: const EdgeInsets.only(left: 24.0, top: 24.0, right: 16),
              child: MaterialButton(
                color: primaryColor,
                height: 50.0,
                minWidth: 150.0,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MainMenu(),
                    ),
                  );
                },
                child: const Text(
                  "ОК",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0
                  ),
                ),
              ),
            ),
          ],
        )
    );
  }
}