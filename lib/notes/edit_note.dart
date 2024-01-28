import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_flutter/colors.dart';
import 'package:test_flutter/locations/location_fire.dart';
import 'package:test_flutter/navigation/main_menu.dart';

import '../navigation/edit_view.dart';

class NoteEditor extends StatefulWidget {

  late int _noteID;
  late String _noteTitle;
  late bool _isFavorite;
  late String _noteText;

  NoteEditor(int noteID, String noteTitle, bool isFavorite, String noteText) {
    _noteID = noteID;
    _noteTitle = noteTitle;
    _isFavorite = isFavorite;
    _noteText = noteText;
  }

  @override
  State<NoteEditor> createState() => _NoteEditor();
}

class _NoteEditor extends State<NoteEditor> {
  final formKeyLocation = GlobalKey<FormState>();
  late BuildContext _context;

  // Location's properties
  late int _noteID = widget._noteID;
  late bool _isFavorite = widget._isFavorite;
  late String _noteTitle = widget._noteTitle;
  late String _noteText = widget._noteText;

  static const Color primaryColor =  Color(0xffe36b44);
  static const Color backColor = Color(0xffffe5b9);
  final String currentUserID = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    _context = context;
    return MaterialApp(
      home: Scaffold(
        backgroundColor: backColor,
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: const Text(
            "Изменение заметки",
            style: TextStyle(
                fontSize: 20.0,
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
            key: formKeyLocation,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.only(left: 8, top: 0, bottom: 32, right: 8),
                  child: Text(
                    'Заметка',
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
                  padding: const EdgeInsets.only(left: 32, top: 0, right: 32, bottom: 0),
                  child: TextFormField(
                    initialValue: _noteTitle,
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
                        return "Слишком короткое название локации";
                      }
                      return null;
                    },
                  ),
                ),

                const Divider(
                  indent: double.infinity,
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 32, top: 0, right: 32, bottom: 0),
                  child: TextFormField(
                    initialValue: _noteText,
                    minLines: 2,
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: 'Напишите здесь все, что угодно!',
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
                  padding: const EdgeInsets.only(top: 25.0),
                  child: MaterialButton(
                    color: primaryColor,
                    height: 50.0,
                    minWidth: 150.0,
                    onPressed: submitNote,
                    child: const Text(
                      "Обновить заметку",
                      style: TextStyle(
                          color: Colors.white
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void submitNote() {
    final form = formKeyLocation.currentState;
    if (form!.validate()) {
      form.save();
      updateNote(_noteID.toString());
    }
  }

  void updateNote(String locationID) async {
    hideKeyboard();

    Map<String, dynamic> updateInfo = {
      'note_title': _noteTitle,
      'note_text': _noteText,
      'user_id': currentUserID
    };

    var documents = await FirebaseFirestore.instance.collection('notes').get();
    final String docName = documents.docs.elementAt(_noteID).id;
    await FirebaseFirestore.instance.collection('notes').doc(docName).update(updateInfo);

    Navigator.push(
        _context,
        MaterialPageRoute(
            builder: (context) => EditorView()));
  }

  void hideKeyboard() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }
}