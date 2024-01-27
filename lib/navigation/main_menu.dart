import 'package:flutter/material.dart';
import 'package:test_flutter/character/perses_fire.dart';
import 'package:test_flutter/colors.dart';
import 'package:test_flutter/favorite/favorite_fire.dart';
import 'package:test_flutter/locations/location_fire.dart';
import 'package:test_flutter/main.dart';
import 'package:test_flutter/notes/notes_fire.dart';
import 'package:test_flutter/story/stories_fire.dart';
import '../adding/add_entity.dart';
import '../character/new_character.dart';
import '../locations/new_location.dart';
import '../notes/new_note.dart';
import '../settings/settings.dart';
import '../story/new_story.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});


  @override
  _MainMenu createState() => _MainMenu();
}


class _MainMenu extends State<MainMenu> {
  TextStyle _current_style = const TextStyle(fontSize: 20.0, color: Color(0xfffff7c3), fontFamily: 'Bajkal');

  int _selectedIndex = 0;
  PageController pageController = PageController();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    pageController.animateToPage(index, duration: Duration(milliseconds: 500), curve: Curves.decelerate);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: const Color(0xffe79521),
          scaffoldBackgroundColor: const Color(0xffffe5b9)
      ),
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: MyColors.primaryColor,
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
          selectedItemColor: MyColors.selectedSectionColor,
          unselectedItemColor: MyColors.unselectedSectionColor,
          type: BottomNavigationBarType.shifting,
          iconSize: 35,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: "Создание",
              backgroundColor: MyColors.navigationBarColor,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_tree),
              label: "Генерация",
              backgroundColor: MyColors.navigationBarColor,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.star),
              label: "Избранное",
              backgroundColor: MyColors.navigationBarColor,
            )
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),

          drawer: Drawer(
            child: ColoredBox(
              color: const Color(0xffffe5b9),
              child: Column(
                children: [
                  Container(
                    height: 150,
                    width: 310,
                    color: MyColors.primaryColor,
                    child: const SizedBox(
                        width: 300,
                        height: 150,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 24.0, bottom: 8.0),
                              child: Text(
                                "Просмотр",
                                style: TextStyle(
                                  color: Color(0xfffff7c3),
                                  fontFamily: 'Bajkal',
                                  fontSize: 32.0,
                                ),
                              ),
                            ),
                            Text(
                              "записей",
                              style: TextStyle(
                                color: Color(0xfffff7c3),
                                fontFamily: 'Bajkal',
                                fontSize: 32.0,
                              ),
                            ),
                          ],
                        )
                    ),
                  ),

                  SizedBox(
                    height: 630,
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
                              var customStyle = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Settings(),
                                ),
                              );
                              setState(() {
                                _current_style = customStyle;
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
                              overlayColor: MaterialStateProperty.all(const Color(0xff5191CA)),
                              backgroundColor: MaterialStateProperty.all(MyColors.primaryColor),
                              padding: MaterialStateProperty.all(const EdgeInsets.all(15)),
                            ),
                            onPressed: () async {
                              var customStyle = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Registration(),
                                ),
                              );
                              setState(() {
                                _current_style = customStyle;
                              });
                            },
                            child: Center(
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 56, right: 16.0),
                                    child: Text(
                                      'Выход', style: _current_style,
                                    ),
                                  ),
                                  Icon(
                                      Icons.exit_to_app_rounded,
                                      color: _current_style.color,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),

        body: PageView(
          controller: pageController,
          children: const [
            AddMenu(),
            Center(
              child: Text(
                'Секция "Генерация" в процессе разработки',
                style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Bajkal',
                    color: MyColors.primaryColor
                ),
              ),
            ),
            FireFavorite()
          ],
        )
      ),
    );
  }
}