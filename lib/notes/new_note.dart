import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_flutter/navigation/main_menu.dart';

import '../adding/add_entity.dart';
import '../favorite/new_favorite.dart';
import 'edit_note.dart';

class CreateNewNote extends StatelessWidget {
  final formKeyNote = GlobalKey<FormState>();
  late BuildContext _context;

  // Location's properties
  late int _noteID = 0;
  late String _noteTitle = '';
  late bool _isFavorite = false;
  late String _noteText = '';

  Color primaryColor = const Color(0xffe36b44);
  Color backColor = const Color(0xffffe5b9);
  final String currentUserID = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Scaffold(
      backgroundColor: backColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text(
          "Создание заметки",
          style: TextStyle(
              fontSize: 24.0,
              fontStyle: FontStyle.italic,
              color: Colors.white
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

      body: Center(
        child: Form(
          key: formKeyNote,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  'Новая заметка',
                  style: TextStyle(
                    fontSize: 32.0,
                    fontFamily: 'Bajkal',
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              const Divider(
                indent: double.infinity,
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Название",
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xff5191CA)),
                        borderRadius: BorderRadius.circular(20.0)
                    ),
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xff5191CA)),
                        borderRadius: BorderRadius.circular(20.0)
                    ),
                    errorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffde0202)),
                    ),
                  ),
                  keyboardType: TextInputType.name,
                  onSaved: (val) => _noteTitle = val!,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Слишком короткое название заметки";
                    }
                    return null;
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  minLines: 2,
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: 'Напишите здесь, что угодно!',
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xff5191CA)),
                        borderRadius: BorderRadius.circular(20.0)
                    ),
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xff5191CA)),
                        borderRadius: BorderRadius.circular(20.0)
                    ),
                    errorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffde0202)),
                    ),
                  ),
                  keyboardType: TextInputType.multiline,
                  onSaved: (val) => _noteText = val!,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Слишком мало написано";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: MaterialButton(
                  splashColor: const Color(0xff5191CA),
                  color: primaryColor,
                  height: 50.0,
                  minWidth: 150.0,
                  onPressed: submitNote,
                  child: const Text(
                    "Оставить заметку",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),


    );
  }

  void submitNote() {
    final form = formKeyNote.currentState;
    if (form!.validate()) {
      form.save();
      performNote();
    }
  }

  Future<void> performNote() async {
    hideKeyboard();

    var notes = FirebaseFirestore.instance.collection('notes');
    var notesAsync = await notes.get();

    _noteID = notesAsync.docs.length;

    FirebaseFirestore.instance.collection('notes').add(
        {
          'id': _noteID,
          'note_title': _noteTitle,
          'isFavorite': _isFavorite,
          'note_text': _noteText,
          'user_id': currentUserID
        }
    );

    Navigator.push(
        _context,
        MaterialPageRoute(
            builder: (context) => NoteView(_noteID, _noteTitle, _isFavorite, _noteText)));
  }

  void hideKeyboard() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }
}

class NoteView extends StatefulWidget {

  late int _noteID;
  late String _noteTitle;
  late bool _isFavorite;
  late String _noteText;

  NoteView(int noteID, String noteTitle, bool isFavorite, String noteText) {
    _noteID = noteID;
    _noteTitle = noteTitle;
    _isFavorite = isFavorite;
    _noteText = noteText;
  }

  @override
  State<NoteView> createState() => NotesView();
}

class NotesView extends State<NoteView> {
  static const Color primaryColor = Color(0xffe36b44);
  static const Color backColor =  Color(0xffffe5b9);
  static const Color contrastColor = Color(0xff5191CA);

  // Note's properties
  late int _noteID = widget._noteID;
  late String _noteTitle = widget._noteTitle;
  late bool _isFavorite = widget._isFavorite;
  late String _noteText = widget._noteText;
  final String currentUserID = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backColor,
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: const Text(
            "Созданная заметка",
            style: TextStyle(fontSize: 25.0),
          ),
        ),

        body: Column(
          children: [

            const Divider(
              indent: double.infinity,
            ),

            Text(
              'Заметка №$_noteID',
              style: const TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Bajkal',
                  color: primaryColor
              ),
            ),
            const Divider(
              indent: double.infinity,
              // color: contrastColor,
              // thickness: 2,
            ),


            Row(
              children: [

                const Padding(
                  padding: EdgeInsets.only(left: 32, right: 0),
                  child: Text(
                    'Название:',
                    style: TextStyle(
                        fontSize: 24.0, color: primaryColor
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(right: 32),
                  child: Text(
                    ' $_noteTitle',
                    style: const TextStyle(fontSize: 24.0),
                  ),
                ),
              ],
            ),
            const Divider(
              indent: double.infinity,
            ),

            Column(
              children: [

                Padding(
                  padding: const EdgeInsets.only(top: 32, bottom: 0),
                  child: Text(
                    ' $_noteText',
                    style: const TextStyle(fontSize: 24.0),
                  ),
                ),
              ],
            ),
            const Divider(
              indent: double.infinity,
            ),

            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 48.0, top: 24.0, right: 48),
                  child: MaterialButton(
                    splashColor: contrastColor,
                    color: primaryColor,
                    height: 50.0,
                    minWidth: 72.0,
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

                Padding(
                  padding: const EdgeInsets.only(left: 24.0, top: 24.0, right: 16),
                  child: MaterialButton(
                    splashColor: contrastColor,
                    color: primaryColor,
                    height: 50.0,
                    minWidth: 150.0,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NoteEditor(
                              _noteID, _noteTitle, _isFavorite, _noteText
                          ),
                          // builder: (context) => const AddMenu(),
                        ),
                      );
                    },
                    child: const Text(
                      "Редактировать",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const Divider(
              indent: double.infinity,
            ),

            Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: MaterialButton(
                splashColor: contrastColor,
                color: const Color(0xffb44c1a),
                height: 50.0,
                minWidth: 150.0,
                onPressed: () async {

                  var favorites = FirebaseFirestore.instance.collection('favorites');
                  var favoritesAsync = await favorites.get();

                  var favID = favoritesAsync.docs.length;

                  FirebaseFirestore.instance.collection('favorites').add(
                      {
                        'id': favID,
                        'name': _noteTitle,
                        'type': 'Заметка',
                        'user_id': currentUserID
                      }
                  );

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FavoriteSetter(),
                    ),
                  );
                  setState(() {
                    _isFavorite = true;
                  });
                },
                child: const Text(
                  "Добавить в избранное",
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

