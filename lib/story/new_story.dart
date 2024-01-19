import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_flutter/character/pers.dart';

class CreateNewStory extends StatelessWidget {
  final formKeyStory = GlobalKey<FormState>();
  late BuildContext _context;
  late String _name = '';

  // Story's properties
  late int _storyID = 0;
  late List<Character> _characters = [];
  late String _storyTitle = '';
  late String _genre = '';
  // late String _persPatronymic = ''; // late List<Location> locations;

  CreateNewStory(String name) {
    _name = name;
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Создание истории",
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
          key: formKeyStory,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 400.0,
                child: TextFormField(
                  decoration: const InputDecoration(labelText: "Название истории"),
                  keyboardType: TextInputType.name,
                  onSaved: (val) => _storyTitle = val!,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Too short story's name";
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                width: 400.0,
                child: TextFormField(
                  decoration: const InputDecoration(labelText: "Жанр"),
                  keyboardType: TextInputType.name,
                  onSaved: (val) => _genre = val!,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Too short genre's name";
                    }
                    return null;
                  },
                ),
              ),
              Container(
                width: 400.0,
                padding: const EdgeInsets.only(top: 10.0),
                child: DropdownButton(
                  items: dropdownCharacters,
                  onChanged: (val) => _characters = val as List<Character>,

                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: MaterialButton(
                  color: Colors.indigoAccent,
                  height: 50.0,
                  minWidth: 150.0,
                  onPressed: submitStory,
                  child: const Text(
                    "Создать историю",
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

  List<DropdownMenuItem<String>> get dropdownCharacters {

    List<DropdownMenuItem<String>> characters = [];
    getAllChars().then((val) {
      for (var char in val) {
        characters.insert(
            characters.length,
            DropdownMenuItem(child: Text(char.toString()), value: char.toString())
        );
      }
    });

    return characters;
  }

  void submitStory() {
    final form = formKeyStory.currentState;
    if (form!.validate()) {
      form.save();
      performStory();
    }
  }

  void performStory() {
    hideKeyboard();
    // var chars = getAllChars();
    // _persID = chars.length;
    // createNewChar(_persID, _persName, _persLastName, _persPatronymic, _persSex, _persAge);
    Navigator.push(
        _context,
        MaterialPageRoute(
            builder: (context) => SecondScreen(_storyTitle, _genre, _characters)));
  }

  void hideKeyboard() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }
}

class SecondScreen extends StatelessWidget {

  // Story's properties
  late String _storyTitle = '';
  late String _genre = '';
  late List<Character> _characters = [];

  SecondScreen(String storyTitle, String genre, List<Character> characters) {
    _storyTitle = storyTitle;
    _genre = genre;
    _characters = characters;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Результаты"),
        ),

        body: Column(
          children: [
            Text('Название истории: $_storyTitle'),
            Divider(),
            Text('Жанр: $_genre'),
            Divider(),
            Text('Персонажи: ${_characters.toString()}'),
            Divider(),
          ],
        )

    );
  }

}
