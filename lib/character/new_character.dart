import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_flutter/character/pers.dart';

class CreateNewCharacter extends StatelessWidget {
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

  CreateNewCharacter(String name) {
    _name = name;
  }

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

      drawer: Drawer(
        child: Column(
          children: [
            Container(
              height: 150,
              width: 300,
              color: Colors.blueAccent,
              child: SizedBox(
                  width: 300,
                  height: 150,
                  child: Row(
                    children: [
                      const Icon(
                        Icons.account_circle_sharp,
                        color: Colors.greenAccent,
                        size: 75,
                      ),
                      Text(
                        "Здравствуйте, $_name",
                        style: const TextStyle(
                          color: Colors.white,
                          fontStyle: FontStyle.italic,
                          fontSize: 20.0,
                        ),
                      ),
                    ],
                  )
              ),
            ),
            const Divider(),

            SizedBox(
              height: 500,
              width: 250,
              child: ListView(
                scrollDirection: Axis.vertical,
                children: [
                  InkWell(
                    onTap: () {
                    },
                    child: SizedBox(
                      height: 150,
                      width: 150,
                      child: Container(
                        height: 150,
                        width: 150,
                        color: Colors.indigo,
                        child: const Center(child: Text(
                          'Персонажи',
                          style: TextStyle(
                              fontSize: 25.0
                          ),
                        ),),
                      ),
                    ),
                  ),
                  const Divider(),

                  InkWell(
                    onTap: () {
                    },
                    child: SizedBox(
                      height: 150,
                      width: 150,
                      child: Container(
                        height: 150,
                        width: 150,
                        color: Colors.indigo,
                        child: const Center(child: Text(
                          'Истории',
                          style: TextStyle(
                              fontSize: 25.0
                          ),
                        ),),
                      ),
                    ),
                  ),
                  const Divider(),

                  InkWell(
                    onTap: () {
                    },
                    child: SizedBox(
                      height: 150,
                      width: 150,
                      child: Container(
                        height: 150,
                        width: 150,
                        color: Colors.indigo,
                        child: const Center(child: Text(
                          'Локации',
                          style: TextStyle(
                              fontSize: 25.0
                          ),
                        ),),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
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
              Container(
                width: 400.0,
                padding: const EdgeInsets.only(top: 10.0),
                child: CheckboxListTile(
                  title: const Text("Sex"),
                  value: _persSex,
                  onChanged: (bool? value) {
                    _persSex = value!;
                  },
                )
              ),
              Container(
                width: 400.0,
                padding: const EdgeInsets.only(top: 10.0),
                child: TextFormField(
                  decoration: const InputDecoration(labelText: "Age"),
                  keyboardType: TextInputType.number,
                  onSaved: (val) => _persAge = int.parse(val!),
                  validator: (val) =>
                  int.parse(val!) <= 0
                      ? 'Too small age'
                      : null,
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

  void submitPers() {
    final form = formKeyPers.currentState;
    if (form!.validate()) {
      form.save();
      performLogin();
    }
  }

  void performLogin() {
    hideKeyboard();
    // var chars = getAllChars();
    // _persID = chars.length;
    // createNewChar(_persID, _persName, _persLastName, _persPatronymic, _persSex, _persAge);
    Navigator.push(
        _context,
        MaterialPageRoute(
            builder: (context) => SecondScreen(_persName, _persLastName, _persPatronymic, _persSex, _persAge)));
  }

  void hideKeyboard() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

}

class SecondScreen extends StatelessWidget {

  // Character's properties
  late String _persName = '';
  late String _persLastName = '';
  late String _persPatronymic = '';
  late String _persSex = '';
  late int _persAge = 0;

  SecondScreen(String persName, String persLastName, String persPatronymic, bool persSex, int persAge) {
    _persName = persName;
    _persLastName = persLastName;
    _persPatronymic = persPatronymic;
    _persSex = (persSex == true ? 'Female' : 'Male');
    _persAge = persAge;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Результаты"),
      ),

      body: Column(
        children: [
          Text('Имя персонажа: $_persName'),
          Divider(),
          Text('Фамилия персонажа: $_persLastName'),
          Divider(),
          Text('Отчество персонажа: $_persPatronymic'),
          Divider(),
          Text('Пол персонажа: $_persSex'),
          Divider(),
          Text('Возраст персонажа: $_persAge'),
        ],
      )

    );
  }

}
