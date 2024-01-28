import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_flutter/character/new_character.dart';
import 'package:test_flutter/character/personality.dart';
import '../navigation/edit_view.dart';

class CharEditor extends StatefulWidget {

  late int _persID;
  late String _name;
  late String _lastName;
  late String _patronymic;
  late bool _sex;
  late int _age;
  late Personality _personality;

  CharEditor(int persID, String name, String lastName, String patronymic, bool sex, int age, Personality personality) {
    _persID = persID;
    _name = name;
    _lastName = lastName;
    _patronymic = patronymic;
    _sex = sex;
    _age = age;
    _personality = personality;
  }

  @override
  State<CharEditor> createState() => _CharEditor();
}

class _CharEditor extends State<CharEditor> {
  final formKeyLocation = GlobalKey<FormState>();
  late BuildContext _context;

  late final int _persID = widget._persID;
  late String _name = widget._name;
  late String _lastName = widget._lastName;
  late String _patronymic = widget._patronymic;
  late bool _sex = widget._sex;
  late int _age = widget._age;
  late Personality _personality = widget._personality;

  late String selectedMBTI = _personality.getMBTI;
  late String selectedTemper = _personality.getTemper;
  final String currentUserID = FirebaseAuth.instance.currentUser!.uid;

  static const Color primaryColor =  Color(0xffe36b44);
  static const Color backColor = Color(0xffffe5b9);

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

  @override
  Widget build(BuildContext context) {
    _context = context;
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: backColor,
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: const Text(
            "Изменение персонажа",
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
                  padding: EdgeInsets.only(left: 8, top: 8, bottom: 8, right: 8),
                  child: Text(
                    'Персонаж',
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
                  padding: const EdgeInsets.only(left: 32, top: 0, right: 32, bottom: 8),
                  child: TextFormField(
                    initialValue: _name,
                    decoration: InputDecoration(
                      labelText: "Имя",
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
                    onSaved: (val) => _name = val!,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Слишком короткое имя";
                      }
                      return null;
                    },
                  ),
                ),
                const Divider(
                  indent: double.infinity,
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 32, top: 0, right: 32),
                  child: TextFormField(
                    initialValue: _lastName,
                    decoration: InputDecoration(
                      labelText: "Фамилия",
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
                    onSaved: (val) => _lastName = val!,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Слишком короткая фамилия";
                      }
                      return null;
                    },
                  ),
                ),
                const Divider(
                  indent: double.infinity,
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 32, top: 0, right: 32),
                  child: TextFormField(
                    initialValue: _patronymic,
                    decoration: InputDecoration(
                      labelText: "Отчество",
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
                    onSaved: (val) => _patronymic = val!,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Слишком короткое отчество";
                      }
                      return null;
                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 32),
                  child: Row(
                    children: [
                      const Text(
                        'Пол:',
                        style: TextStyle(
                          fontSize: 24.0,
                          color: primaryColor,
                          fontFamily: 'Bajkal',
                        ),
                      ),

                      Flexible(
                        child: ListTile(
                          title: const Text(
                            'Муж.', style: TextStyle(fontSize: 16.0),
                          ),
                          leading: Radio<bool>(
                            value: true,
                            activeColor: const Color(0xff5191CA),
                            groupValue: _sex,
                            onChanged: (bool? value) {
                              setState(() {
                                _sex = value!;
                              });
                            },
                          ),
                        ),
                      ),

                      Flexible(
                        child: ListTile(
                          title: const Text(
                            'Жен.', style: TextStyle(fontSize: 16.0),
                          ),
                          leading: Radio<bool>(
                            activeColor: const Color(0xff5191CA),
                            value: false,
                            groupValue: _sex,
                            onChanged: (bool? value) {
                              setState(() {
                                _sex = value!;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(
                  indent: double.infinity,
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 80, top: 0, right: 80),
                  child: TextFormField(
                      initialValue: _age.toString(),
                      decoration: InputDecoration(
                        labelText: "Возраст",
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
                      keyboardType: TextInputType.number,
                      onSaved: (val) => _age = int.parse(val!),
                      validator: (val) {
                        try {
                          var age = int.parse(val!);

                          if (age <= 0) {
                            return 'Слишком малый возраст';
                          }
                        } catch (e) {
                          return 'Это не число!';
                        }

                        return null;
                      }
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Личность:',
                    style: TextStyle(
                        fontSize: 24.0,
                        fontFamily: 'Bajkal',
                        color: primaryColor
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 32, top: 0, right: 32),
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

                Padding(
                  padding: const EdgeInsets.only(left: 32, top: 0, right: 32),
                  child: DropdownButton(
                    value: selectedTemper,
                    items: dropdownTempers,
                    onChanged: (String? val) {
                      setState(() {
                        selectedTemper = val!;
                      });
                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: MaterialButton(
                    splashColor: CharacterView.contrastColor,
                    color: primaryColor,
                    height: 48.0,
                    minWidth: 80.0,
                    onPressed: submitChar,
                    child: const Text(
                      "Обновить",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16
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

  void submitChar() {
    final form = formKeyLocation.currentState;
    if (form!.validate()) {
      form.save();
      updateChar();
    }
  }

  void updateChar() async {
    hideKeyboard();

    Map<String, dynamic> updateInfo = {
      'name': _name,
      'lastname': _lastName,
      'patronymic': _patronymic,
      'sex': _sex,
      'age': _age,
      'personality':
      {
        'mbti': selectedMBTI,
        'temper': selectedTemper
      },
      'user_id': currentUserID
    };

    print('PERS ID HERE: $_persID');

    var documents = await FirebaseFirestore.instance.collection('perses').get();
    final String docName = documents.docs.elementAt(_persID).id;

    print('Doc name: $docName');
    await FirebaseFirestore.instance.collection('perses').doc(docName).update(updateInfo);

    Navigator.push(
        _context,
        MaterialPageRoute(
            builder: (context) => EditorView()));
  }

  void hideKeyboard() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }
}