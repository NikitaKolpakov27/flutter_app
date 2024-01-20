import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_flutter/character/pers.dart';
import 'package:test_flutter/character/personality.dart';

class CreateNewCharacter extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: NewCharacter(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class NewCharacter extends StatefulWidget {
  const NewCharacter({super.key});

  @override
  State<NewCharacter> createState() => _CreateNewCharacter();
}

class _CreateNewCharacter extends State<NewCharacter> {
  final formKeyPers = GlobalKey<FormState>();
  late BuildContext _context;
  late String _name = '';

  // Character's properties
  late int _persID = 0;
  late String _persName = '';
  late String _persLastName = '';
  late String _persPatronymic = '';
  late bool _persSex = false;
  late int _persAge = 0;

  late String selectedMBTI = 'ISTJ';
  late String selectedTemper = 'CHOLERIC';
  late Personality _personality;

  bool isFavorite = false;

  // _CreateNewCharacter(String name) {
  //   _name = name;
  // }

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Scaffold(

      appBar: AppBar(
        title: const Text(
          "Создание персонажа",
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
          key: formKeyPers,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 400.0,
                child: TextFormField(
                  decoration: const InputDecoration(labelText: "Name"),
                  keyboardType: TextInputType.name,
                  onSaved: (val) => _persName = val!,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Too short character's name";
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                width: 400.0,
                child: TextFormField(
                  decoration: const InputDecoration(labelText: "Last Name"),
                  keyboardType: TextInputType.name,
                  onSaved: (val) => _persLastName = val!,
                  validator: (val) =>
                  val!.length < 8
                      ? 'Too short last name'
                      : null,
                ),
              ),
              Container(
                width: 400.0,
                padding: const EdgeInsets.only(top: 10.0),
                child: TextFormField(
                  decoration: const InputDecoration(labelText: "Patronymic"),
                  keyboardType: TextInputType.name,
                  onSaved: (val) => _persPatronymic = val!,
                  validator: (val) =>
                  val!.length < 6
                      ? 'Too short patronymic'
                      : null,
                ),
              ),

              Row(
                children: [
                  const Flexible(
                    child: Text(
                      'Пол:',
                      style: TextStyle(fontSize: 20.0, color: Colors.black),
                    ),
                  ),
                  // const Divider(),
                  Flexible(
                    child: ListTile(
                      title: const Text(
                        'Мужчина', style: TextStyle(fontSize: 15.0),
                      ),
                      leading: Radio<bool>(
                        value: true,
                        groupValue: _persSex,
                        onChanged: (bool? value) {
                          setState(() {
                            _persSex = value!;
                          });
                        },
                      ),
                    ),
                  ),
                  Flexible(
                    child: ListTile(
                      title: const Text(
                        'Женщина', style: TextStyle(fontSize: 15.0),
                      ),
                      leading: Radio<bool>(
                        value: false,
                        groupValue: _persSex,
                        onChanged: (bool? value) {
                          setState(() {
                            _persSex = value!;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),

              Container(
                width: 400.0,
                padding: const EdgeInsets.only(top: 10.0),
                child: TextFormField(
                  decoration: const InputDecoration(labelText: "Age"),
                  keyboardType: TextInputType.number,
                  onSaved: (val) => _persAge = int.parse(val!),
                  validator: (val) {
                    try {
                      var age = int.parse(val!);

                      if (age <= 0) {
                        return 'Too small age';
                      }
                    } catch (e) {
                      return 'It\'s not a number!';
                    }

                    return null;
                  }
                ),
              ),

              const Flexible(
                  child: Text(
                    'Личность:',
                    style: TextStyle(fontSize: 15.0),
                  )
              ),

              Flexible(
                child: Container(
                  width: 400.0,
                  padding: const EdgeInsets.only(top: 10.0),
                  child: DropdownButton(
                      value: selectedMBTI,
                      items: dropdownMBTI,
                      onChanged: (String? val){
                        setState(() {
                          selectedMBTI = val!;
                        });
                      },
                  ),
                ),
              ),

              Flexible(
                child: Container(
                  width: 400.0,
                  padding: const EdgeInsets.only(top: 10.0),
                  child: DropdownButton(
                    value: selectedTemper,
                    items: dropdownTempers,
                    onChanged: (String? val){
                      setState(() {
                        selectedTemper = val!;
                      });
                    },
                  ),
                ),
              ),


              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: MaterialButton(
                  color: Colors.indigoAccent,
                  height: 50.0,
                  minWidth: 150.0,
                  onPressed: submitPers,
                  child: const Text(
                    "Создать персонажа",
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

  List<DropdownMenuItem<String>> get dropdownMBTI{
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "ISTJ", child: Text("ISTJ")),
      const DropdownMenuItem(value: "ISFJ", child: Text("ISFJ")),
      const DropdownMenuItem(value: "INFJ", child: Text("INFJ")),
      const DropdownMenuItem(value: "INTJ", child: Text("INTJ")),

      const DropdownMenuItem(value: "ISTP", child: Text("ISTP")),
      const DropdownMenuItem(value: "ISFP", child: Text("ISFP")),
      const DropdownMenuItem(value: "INFP", child: Text("INFP")),
      const DropdownMenuItem(value: "INTP", child: Text("INTP")),

      const DropdownMenuItem(value: "ESTP", child: Text("ESTP")),
      const DropdownMenuItem(value: "ESFP", child: Text("ESFP")),
      const DropdownMenuItem(value: "ENFP", child: Text("ENFP")),
      const DropdownMenuItem(value: "ENTP", child: Text("ENTP")),

      const DropdownMenuItem(value: "ESTJ", child: Text("ESTJ")),
      const DropdownMenuItem(value: "ESFJ", child: Text("ESFJ")),
      const DropdownMenuItem(value: "ENFJ", child: Text("ENFJ")),
      const DropdownMenuItem(value: "ENTJ", child: Text("ENTJ")),
    ];
    return menuItems;
  }

  List<DropdownMenuItem<String>> get dropdownTempers{
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "CHOLERIC", child: Text("CHOLERIC")),
      const DropdownMenuItem(value: "MELANCHOLIC", child: Text("MELANCHOLIC")),
      const DropdownMenuItem(value: "PHLEGMATIC", child: Text("PHLEGMATIC")),
      const DropdownMenuItem(value: "SANGUINE", child: Text("SANGUINE")),
    ];
    return menuItems;
  }

  void submitPers() {
    final form = formKeyPers.currentState;
    if (form!.validate()) {
      form.save();
      performLogin();
    }
  }

  void performLogin() async {
    hideKeyboard();

    _personality = Personality(_persID, selectedMBTI, selectedTemper);

    // var chars = await getAllChars();
    _persID = 12;
    // createNewChar(_persID, _persName, _persLastName, _persPatronymic, _persSex, _persAge, _personality);

    Navigator.push(
        _context,
        MaterialPageRoute(
            builder: (context) => CharacterView(_persID, _persName, _persLastName, _persPatronymic, _persSex, _persAge, _personality)));
  }

  void hideKeyboard() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }
}

class CharacterView extends StatelessWidget {

  // Character's properties
  late int _persID;
  late String _persName = '';
  late String _persLastName = '';
  late String _persPatronymic = '';
  late String _persSex = '';
  late int _persAge = 0;
  late Personality _personality;

  CharacterView(int persID, String persName, String persLastName, String persPatronymic, bool persSex, int persAge, Personality personality) {
    _persID = persID;
    _persName = persName;
    _persLastName = persLastName;
    _persPatronymic = persPatronymic;
    _persSex = (persSex == true ? 'Male' : 'Female');
    _persAge = persAge;
    _personality = personality;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
            'Созданный персонаж',
            style: TextStyle(fontSize: 25.0),
          ),
      ),

      body: Column(
        children: [

          Text(
            'Персонаж №$_persID',
            style: const TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
          ),
          const Divider(),

          Row(
            children: [
                const Flexible(
                    child: Text(
                      'Имя персонажа:',
                      style: TextStyle(fontSize: 17.0, color: Colors.indigo),
                    ),
                ),
                Flexible(
                    child: Text(
                      ' $_persName',
                      style: TextStyle(fontSize: 17.0),
                    ),
                  ),
            ],
          ),
          Divider(),

          Row(
            children: [
              const Flexible(
                  child: Text(
                    'Фамилия персонажа:',
                    style: TextStyle(fontSize: 17.0, color: Colors.indigo),
                  ),
                ),
              Flexible(
                child: Text(
                  ' $_persLastName',
                  style: TextStyle(fontSize: 17.0),
                ),
              ),
            ],
          ),
          Divider(),

          Row(
            children: [
              const Flexible(
                child: Text(
                  'Отчество персонажа:',
                  style: TextStyle(fontSize: 17.0, color: Colors.indigo),
                ),
              ),
              Flexible(
                child: Text(
                  ' $_persPatronymic',
                  style: TextStyle(fontSize: 17.0),
                ),
              ),
            ],
          ),
          Divider(),

          Row(
            children: [
              const Flexible(
                child: Text(
                  'Пол персонажа:',
                  style: TextStyle(fontSize: 17.0, color: Colors.indigo),
                ),
              ),
              Flexible(
                child: Text(
                  ' $_persSex',
                  style: TextStyle(fontSize: 17.0),
                ),
              ),
            ],
          ),
          Divider(),

          Row(
            children: [
              const Flexible(
                child: Text(
                  'Возраст персонажа:',
                  style: TextStyle(fontSize: 17.0, color: Colors.indigo),
                ),
              ),
              Flexible(
                child: Text(
                  ' $_persAge',
                  style: TextStyle(fontSize: 17.0),
                ),
              ),
            ],
          ),
          Divider(),

          Row(
            children: [
              const Flexible(
                child: Text(
                  'Тип личности по MBTI:',
                  style: TextStyle(fontSize: 17.0, color: Colors.indigo),
                ),
              ),
              Flexible(
                child: Text(
                  ' ${_personality.getMBTI}',
                  style: TextStyle(fontSize: 17.0),
                ),
              ),
            ],
          ),
          Divider(),

          Row(
            children: [
              const Flexible(
                child: Text(
                  'Характер персонажа:',
                  style: TextStyle(fontSize: 17.0, color: Colors.indigo),
                ),
              ),
              Flexible(
                child: Text(
                  ' ${_personality.getTemper}',
                  style: TextStyle(fontSize: 17.0),
                ),
              ),
            ],
          ),
        ],
      )

    );
  }

}
