import 'package:flutter/material.dart';
import 'package:test_flutter/character/perses_fire.dart';
import 'package:test_flutter/colors.dart';
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
  TextStyle _current_style = const TextStyle(fontSize: 20.0, color: Color(0xfffff7c3), fontFamily: 'Bajkal');
  final _sizeTitleDrawer = const TextStyle(fontSize: 30.0, fontStyle: FontStyle.italic, color: Colors.lightBlue);
  Color primaryColor = const Color(0xffe36b44);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: const Color(0xffe79521),
          scaffoldBackgroundColor: const Color(0xffffe5b9)
      ),
      home: Scaffold(
          body: SizedBox(
              child: Column(
                children: [
                  const Divider(
                    indent: double.infinity,
                  ),

                  const Text(
                    'Создание',
                    style: TextStyle(
                        fontSize: 40.0,
                        color: MyColors.contrastColor,
                        fontFamily: 'Bajkal',
                        fontWeight: FontWeight.bold
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
                      child: Center(
                        child: Row(
                          children: [
                            const Icon(
                              Icons.person,
                              size: 32,
                              color: MyColors.selectedSectionColor,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 40),
                              child: Text(
                                'Новый персонаж', style: _current_style,
                              ),
                            ),
                          ],
                        ),
                      ),
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
                      child: Center(
                        child: Row(
                          children: [
                            const Icon(
                              Icons.photo,
                              size: 32,
                              color: MyColors.selectedSectionColor,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 40),
                              child: Text(
                                'Новая локация', style: _current_style,
                              ),
                            ),
                          ],
                        ),
                      ),
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
                      child: Center(
                        child: Row(
                          children: [
                            const Icon(
                              Icons.history_edu,
                              size: 32,
                              color: MyColors.selectedSectionColor,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 40),
                              child: Text(
                                'Новая история', style: _current_style,
                              ),
                            ),
                          ],
                        ),
                      ),
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
                        backgroundColor: MaterialStateProperty.all(const Color(0xffe79521)),
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
                      child: Center(
                        child: Row(
                          children: [
                            const Icon(
                              Icons.note,
                              size: 32,
                              color: MyColors.selectedSectionColor,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 40),
                              child: Text(
                                'Новая заметка', style: _current_style,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )
          )),
    );
  }
}