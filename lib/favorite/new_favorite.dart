import 'package:flutter/material.dart';
import '../adding/add_entity.dart';

class FavoriteSetter extends StatelessWidget {
  const FavoriteSetter({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
              "Добавление в избранное",
              style: TextStyle(fontSize: 25.0),
          ),
        ),

        body: Column(
          children: [
            const Text(
                'Объект был успешно добавлен в раздел Избранное!',
                style: TextStyle(fontSize: 20.0),
            ),
            const Divider(),
            const Divider(),

            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddMenu(),
                    ),
                  );
                },
                child: const Text('ОК')
            ),
            const Divider(),
          ],
        )
    );
  }
}