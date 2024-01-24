import 'package:flutter/material.dart';
import '../adding/add_entity.dart';

class FavoriteSetter extends StatelessWidget {
  const FavoriteSetter({super.key});

  static const Color primaryColor = Color(0xffe36b44);
  static const Color backColor =  Color(0xffffe5b9);
  static const Color contrastColor = Color(0xff5191CA);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: backColor,
          appBar: AppBar(
            backgroundColor: primaryColor,
            title: const Text(
                "Добавление в избранное",
                style: TextStyle(fontSize: 25.0),
            ),
          ),

          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 8.0, bottom: 16),
                child: Text(
                    'Объект был успешно добавлен в раздел Избранное!',
                    style: TextStyle(
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Bajkal',
                        color: primaryColor,
                    ),
                    textAlign: TextAlign.center,
                ),
              ),
              const Divider(
                indent: double.infinity,
              ),

              MaterialButton(
                  splashColor: contrastColor,
                  color: primaryColor,
                  height: 50.0,
                  minWidth: 80.0,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddMenu(),
                      ),
                    );
                  },
                  child: const Text(
                      'ОК',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xffffffff)
                      ),
                  )
              ),
            ],
          )
      ),
    );
  }
}