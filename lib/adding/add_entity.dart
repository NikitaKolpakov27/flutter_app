import 'package:flutter/material.dart';
import 'package:test_flutter/character/perses_fire.dart';
import 'package:test_flutter/favorite/favorite_fire.dart';
import 'package:test_flutter/locations/location_fire.dart';
import 'package:test_flutter/notes/notes_fire.dart';
import 'package:test_flutter/story/stories_fire.dart';
import '../character/new_character.dart';
import '../locations/new_location.dart';
import '../notes/new_note.dart';
import '../settings/settings.dart';
import '../story/new_story.dart';

class AddMenu extends StatefulWidget {
  const AddMenu({super.key});

  @override
  State<AddMenu> createState() => _AddMenu();
}

class _AddMenu extends State<AddMenu> {
  String _name = '';
  String _password = '';
  String _email = '';

  TextStyle _current_style = const TextStyle(fontSize: 20.0, color: Color(0xfffff7c3), fontFamily: 'Bajkal');
  final _sizeTitleDrawer = const TextStyle(fontSize: 30.0, fontStyle: FontStyle.italic, color: Colors.lightBlue);
  Color primaryColor = const Color(0xffe36b44);

  // AddMenu(String name, String email, String password) {
  //   _name = name;
  //   _password = password;
  //   _email = email;
  // }
  //
  // AddMenu.copy(AddMenu addMenu, {super.key}) {
  //   _name = addMenu._name;
  //   _password = addMenu._password;
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: const Color(0xffe79521),
          scaffoldBackgroundColor: const Color(0xffffe5b9)
      ),
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: primaryColor,
            title: const Text(
              "StoryForge",
              style: TextStyle(
                  fontSize: 24.0,
                  fontStyle: FontStyle.italic,
                  color: Colors.white,
              ),
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: const Color(0xfffbff29),
            unselectedItemColor: const Color(0xffd54a16),
            type: BottomNavigationBarType.shifting,
            iconSize: 35,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.add),
                label: "Создание",
                backgroundColor: Color(0xfff38557),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_tree),
                label: "Генерация",
                backgroundColor: Color(0xfff38557),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.star),
                label: "Избранное",
                backgroundColor: Color(0xfff38557),
              )
            ],
          ),

          // bottomNavigationBar: BottomNavigationBarExample(),


          drawer: Drawer(
            child: ColoredBox(
              color: const Color(0xffffe5b9),
              child: Column(
                children: [
                  Container(
                    height: 150,
                    width: 310,
                    color: primaryColor,
                    child: SizedBox(
                        width: 300,
                        height: 150,
                        child: Row(
                          children: [
                            const Icon(
                              Icons.account_circle_sharp,
                              color: Color(0xfffbff4b),
                              size: 64,
                            ),
                            Text(
                              "Здравствуйте, $_name",
                              style: const TextStyle(
                                color: Color(0xfffff7c3),
                                fontFamily: 'Bajkal',
                                fontSize: 24.0,
                              ),
                            ),
                          ],
                        )
                    ),
                  ),

                  SizedBox(
                    height: 550,
                    width: 300,
                    child: ListView(
                      scrollDirection: Axis.vertical,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 32.0, right: 32.0, bottom: 8),
                          child: FilledButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(const Color(0xffe79521)),
                              padding: MaterialStateProperty.all(const EdgeInsets.all(25)),
                              overlayColor: MaterialStateProperty.all(const Color(0xff5191CA)),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const FireChar(),
                                ),
                              );
                            },
                            child: Center(child: Text('Персонажи', style: _current_style,),),
                          ),
                        ),
                        const Divider(
                          indent: double.infinity,
                        ),


                        Padding(
                          padding: const EdgeInsets.only(left: 32.0, right: 32.0, bottom: 8),
                          child: FilledButton(
                            style: ButtonStyle(
                              overlayColor: MaterialStateProperty.all(const Color(0xff5191CA)),
                              backgroundColor: MaterialStateProperty.all(const Color(0xffe79521)),
                              padding: MaterialStateProperty.all(const EdgeInsets.all(25)),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const FireLocation(),
                                ),
                              );
                            },
                            child: Center(child: Text('Локации', style: _current_style,),),
                          ),
                        ),
                        const Divider(
                          indent: double.infinity,
                        ),


                        Padding(
                          padding: const EdgeInsets.only(left: 32.0, right: 32.0, bottom: 8),
                          child: FilledButton(
                            style: ButtonStyle(
                              overlayColor: MaterialStateProperty.all(const Color(0xff5191CA)),
                              backgroundColor: MaterialStateProperty.all(const Color(0xffe79521)),
                              padding: MaterialStateProperty.all(const EdgeInsets.all(25)),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const FireStory(),
                                ),
                              );
                            },
                            child: Center(child: Text('Истории', style: _current_style,),),
                          ),
                        ),
                        const Divider(
                          indent: double.infinity,
                        ),
                        const Divider(
                          indent: double.infinity,
                        ),


                        Padding(
                          padding: const EdgeInsets.only(left: 32.0, right: 32.0, bottom: 8),
                          child: FilledButton(
                            style: ButtonStyle(
                              overlayColor: MaterialStateProperty.all(const Color(0xff5191CA)),
                              backgroundColor: MaterialStateProperty.all(const Color(0xffe79521)),
                              padding: MaterialStateProperty.all(const EdgeInsets.all(25)),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const FireNote(),
                                ),
                              );
                            },
                            child: Center(child: Text('Заметки', style: _current_style,),),
                          ),
                        ),
                        const Divider(
                          indent: double.infinity,
                        ),
                        const Divider(
                          indent: double.infinity,
                        ),
                        const Divider(
                          indent: double.infinity,
                        ),
                        const Divider(
                          indent: double.infinity,
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 32.0, right: 32.0, bottom: 8),
                          child: FilledButton(
                            style: ButtonStyle(
                              overlayColor: MaterialStateProperty.all(const Color(0xff5191CA)),
                              backgroundColor: MaterialStateProperty.all(const Color(0xffd57705)),
                              padding: MaterialStateProperty.all(const EdgeInsets.all(15)),
                            ),
                            onPressed: () async {
                              var custom_style = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Settings(),
                                ),
                              );
                              setState(() {
                                _current_style = custom_style;
                              });
                            },
                            child: Center(child: Text('Настройки', style: _current_style,),),
                          ),
                        ),
                        const Divider(
                          indent: double.infinity,
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 32.0, right: 32.0, bottom: 8),
                          child: FilledButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(const Color(0xffd57705)),
                              padding: MaterialStateProperty.all(const EdgeInsets.all(15)),
                            ),
                            onPressed: () async {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const FireFavorite(),
                                ),
                              );
                            },
                            child: Center(child: Text('Избранное', style: _current_style,),),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),


          body: SizedBox(
            // height: double.infinity,
            // width: double.infinity,
              child: Column(
                children: [
                  const Divider(),

                  const Text(
                    'Главное меню',
                    style: TextStyle(
                        fontSize: 32.0,
                        color: Color(0xffe75c21),
                        fontFamily: 'Bajkal',
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  const Divider(
                    indent: double.infinity,
                  ),

                  const Text(
                    'Создание',
                    style: TextStyle(
                        fontSize: 32.0,
                        color: Color(0xffe75c21),
                        fontFamily: 'Bajkal',
                    ),
                  ),
                  const Divider(
                    indent: double.infinity,
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 32, right: 32, top: 8.0),
                    child: FilledButton(
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(const EdgeInsets.all(30)),
                        backgroundColor: MaterialStateProperty.all(const Color(0xffe79521)),
                        overlayColor: MaterialStateProperty.all(const Color(0xff5191CA)),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const NewCharacter(),
                          ),
                        );
                      },
                      child: Center(child: Text('Новый персонаж', style: _current_style,),),
                    ),
                  ),
                  const Divider(
                    indent: double.infinity,
                  ),


                  Padding(
                    padding: const EdgeInsets.only(left: 32, right: 32, top: 8.0),
                    child: FilledButton(
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(const EdgeInsets.all(30)),
                        backgroundColor: MaterialStateProperty.all(const Color(0xffe79521)),
                        overlayColor: MaterialStateProperty.all(const Color(0xff5191CA)),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const NewLocation(),
                          ),
                        );
                      },
                      child: Center(child: Text('Новая локация', style: _current_style,),),
                    ),
                  ),
                  const Divider(
                    indent: double.infinity,
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 32, right: 32, top: 8.0),
                    child: FilledButton(
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(const EdgeInsets.all(30)),
                        backgroundColor: MaterialStateProperty.all(const Color(0xffe79521)),
                        overlayColor: MaterialStateProperty.all(const Color(0xff5191CA)),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const NewStory(),
                          ),
                        );
                      },
                      child: Center(child: Text('Новая история', style: _current_style,),),
                    ),
                  ),
                  const Divider(
                    indent: double.infinity,
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 32, right: 32, top: 32.0),
                    child: FilledButton(
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(const EdgeInsets.all(30)),
                        backgroundColor: MaterialStateProperty.all(Color(0xffe79521)),
                        overlayColor: MaterialStateProperty.all(const Color(0xff5191CA)),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CreateNewNote(),
                          ),
                        );
                      },
                      child: Center(child: Text('Новая заметка', style: _current_style,),),
                    ),
                  ),
                ],
              )
          )),
    );
  }
}


class BottomNavigationBarExample extends StatefulWidget {

  @override
  _BottomNavigationBarExampleState createState() =>
      _BottomNavigationBarExampleState();
}

class _BottomNavigationBarExampleState extends State<BottomNavigationBarExample> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Создание',
      style: optionStyle,
    ),
    AddMenu(),
    // Text(
    //   'Index 1: Генерация',
    //   style: optionStyle,
    // ),
    // Settings(),
    const Text(
      'Index 2: Избранное',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
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
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}