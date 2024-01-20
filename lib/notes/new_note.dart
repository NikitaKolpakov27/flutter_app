import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CreateNewNote extends StatelessWidget {
  final formKeyNote = GlobalKey<FormState>();
  late BuildContext _context;
  late String _name = '';

  // Location's properties
  late int _noteID = 0;
  late String _noteTitle = '';
  late String _noteText = '';

  CreateNewNote(String name) {
    _name = name;
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Создание заметки",
          style: TextStyle(
              fontSize: 20.0,
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

      body: Center(
        child: Form(
          key: formKeyNote,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 400.0,
                child: TextFormField(
                  decoration: const InputDecoration(labelText: "Название заметки"),
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
              TextFormField(
                minLines: 2,
                maxLines: 5,
                decoration: const InputDecoration(
                    hintText: "Напишите здесь, что угодно!",
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
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
              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: MaterialButton(
                  color: Colors.indigoAccent,
                  height: 50.0,
                  minWidth: 150.0,
                  onPressed: submitLocation,
                  child: const Text(
                    "Оставить заметку",
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


    );
  }

  void submitLocation() {
    final form = formKeyNote.currentState;
    if (form!.validate()) {
      form.save();
      performLocation();
    }
  }

  void performLocation() {
    hideKeyboard();
    Navigator.push(
        _context,
        MaterialPageRoute(
            builder: (context) => NoteView(_noteID, _noteTitle, _noteText)));
  }

  void hideKeyboard() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }
}

class NoteView extends StatelessWidget {

  // Note's properties
  late int _noteID = 0;
  late String _noteTitle = '';
  late String _noteText = '';

  NoteView(int noteID, String noteTitle, String text) {
    _noteID = noteID;
    _noteTitle = noteTitle;
    _noteText = text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Результаты"),
        ),

        body: Column(
          children: [
            Text('Название заметки: $_noteTitle'),
            const Divider(),
            Text(_noteText),
            const Divider(),
          ],
        )
    );
  }
}

