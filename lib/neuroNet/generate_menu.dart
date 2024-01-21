import 'package:flutter/material.dart';
import '../character/new_character.dart';
import '../locations/new_location.dart';
import '../story/new_story.dart';

class GenerateMenu extends StatelessWidget {
  String _name = '';
  String _password = '';
  final _sizeTextBlack = const TextStyle(fontSize: 20.0, color: Colors.black);
  final _sizeTitleDrawer = const TextStyle(fontSize: 30.0, fontStyle: FontStyle.italic, color: Colors.lightBlue);

  GenerateMenu(String name, String password) {
    _name = name;
    _password = password;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Приложение для писателей",
            style: TextStyle(
                fontSize: 22.0,
                fontStyle: FontStyle.italic,
                color: Colors.white
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.add),
                label: "Создание"
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_tree),
                label: "Генерация"
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.star),
                label: "Избранное"
            )
          ],
        ),
        drawer: Drawer(
          child: Column(
            children: [
              Text(
                  "Приложение для писателей",
                  style: _sizeTitleDrawer,
                  textAlign: TextAlign.left
              ),
              const Divider(),
              const Text(
                "Сгенерировать описание персонажа",
                style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black
                ),
              ),
              const Divider(),
              const Text(
                "Сгенерировать локацию",
                style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black
                ),
              ),
              const Divider(),
              const Text(
                "Сгенерировать историю",
                style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black
                ),
              )
            ],
          ),
        ),
        body: SizedBox(
            height: 500,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                children: [
                  Text("Здравствуйте, $_name", textAlign: TextAlign.center,),
                  const SizedBox(height: 20,),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreateNewCharacter(),
                        ),
                      );
                    },
                    child: SizedBox(
                      height: 150,
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 100,
                            width: 300,
                            margin: const EdgeInsets.all(20),
                            color: Colors.blue,
                            child: const Center(child: Text('Сгенерировать описание персонажа'),),
                          ),
                        ],
                      ),
                    ),
                  ),


                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const NewLocation(),
                        ),
                      );
                    },
                    child: SizedBox(
                      height: 150,
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 100,
                            width: 300,
                            margin: const EdgeInsets.all(20),
                            color: Colors.blue,
                            child: const Center(child: Text('Сгенерировать локацию'),),
                          ),
                        ],
                      ),
                    ),
                  ),


                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreateNewStory(_name),
                        ),
                      );
                    },
                    child: SizedBox(
                      height: 150,
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 100,
                            width: 300,
                            margin: const EdgeInsets.all(20),
                            color: Colors.blue,
                            child: const Center(child: Text('Сгенерировать историю'),),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
        ));
  }
}