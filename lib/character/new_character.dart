import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_flutter/character/pers.dart';
import 'package:test_flutter/character/personality.dart';
import 'package:test_flutter/navigation/main_menu.dart';

import '../adding/add_entity.dart';
import '../favorite/new_favorite.dart';
import 'edit_character.dart';

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

  // Character's properties
  late int _persID = 0;
  late String _persName = '';
  late String _persLastName = '';
  late String _persPatronymic = '';
  late bool _persSex = false;
  late bool _isFavorite = false;
  late int _persAge = 0;

  late String selectedMBTI = 'ISTJ';
  late String selectedTemper = 'CHOLERIC';
  late Personality _personality;
  final String currentUserID = FirebaseAuth.instance.currentUser!.uid;

  bool isFavorite = false;
  Color primaryColor = const Color(0xffe36b44);

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xffffe5b9),
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: const Text(
            "Создание персонажа",
            style: TextStyle(
                fontSize: 22.0,
                fontStyle: FontStyle.italic,
                color: Colors.white
            ),
          ),
        ),

        body: Center(
          child: Form(
            key: formKeyPers,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                Padding(
                  padding: const EdgeInsets.only(bottom: 32, right: 8, left: 8, top: 32),
                  child: Text(
                    'Новый персонаж',
                    style: TextStyle(
                        fontSize: 40.0,
                        fontFamily: 'Bajkal',
                        fontWeight: FontWeight.bold,
                        color: primaryColor
                    ),
                  ),
                ),


                Padding(
                  padding: const EdgeInsets.only(left: 32, top: 0, right: 32, bottom: 8),
                  child: TextFormField(
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
                    onSaved: (val) => _persName = val!,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Слишком короткое имя персонажа";
                      }
                      return null;
                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 32, top: 0, right: 32, bottom: 8),
                  child: TextFormField(
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
                    onSaved: (val) => _persLastName = val!,
                    validator: (val) =>
                    val!.isEmpty
                        ? 'Слишком короткая фамилия'
                        : null,
                  ),
                ),


                Padding(
                  padding: const EdgeInsets.only(left: 32, top: 0, right: 32, bottom: 8),
                  child: TextFormField(
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
                    onSaved: (val) => _persPatronymic = val!,
                    validator: (val) =>
                    val!.length < 6
                        ? 'Слишком короткое отчество'
                        : null,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 32, bottom: 8),
                  child: Row(
                    children: [
                      Text(
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
                            'Жен.', style: TextStyle(fontSize: 16.0),
                          ),
                          leading: Radio<bool>(
                            activeColor: const Color(0xff5191CA),
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
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 80, top: 0, right: 80, bottom: 8),
                  child: TextFormField(
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
                    onSaved: (val) => _persAge = int.parse(val!),
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

                Padding(
                  padding: const EdgeInsets.all(8.0),
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
                  padding: const EdgeInsets.only(left: 32, top: 0, right: 32, bottom: 8),
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
                  padding: const EdgeInsets.only(left: 32, top: 0, right: 32, bottom: 8),
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
                  padding: const EdgeInsets.only(top: 0.0),
                  child: MaterialButton(
                    splashColor: const Color(0xff5191CA),
                    color: primaryColor,
                    height: 48.0,
                    minWidth: 160.0,
                    onPressed: submitPers,
                    child: const Text(
                      "Создать персонажа",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0
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

    var chars = FirebaseFirestore.instance.collection('perses');
    var charsAsync = await chars.get();

    _persID = charsAsync.docs.length;

    FirebaseFirestore.instance.collection('perses').add(
        {
          'id': _persID,
          'name': _persName,
          'lastname': _persLastName,
          'patronymic': _persPatronymic,
          'sex': _persSex,
          'age': _persAge,
          'personality':
            {
              'mbti': _personality.getMBTI,
              'temper': _personality.getTemper
            },
          'user_id': currentUserID
        }
    );

    Navigator.push(
        _context,
        MaterialPageRoute(
            builder: (context) => CharView(
                _persID, _persName, _persLastName, _persPatronymic, _isFavorite, _persSex, _persAge, _personality
            )));
  }

  void hideKeyboard() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }
}

class CharView extends StatefulWidget {

  late int _persID;
  late String _persName = '';
  late String _persLastName = '';
  late String _persPatronymic = '';
  late bool _isFavorite = false;
  late bool _persSex = false;
  late int _persAge = 0;
  late Personality _personality;

  CharView(
      int persID, String persName, String persLastName, String persPatronymic, bool fav, bool persSex,
        int persAge, Personality personality
      ) {

    _persID = persID;
    _persName = persName;
    _persLastName = persLastName;
    _persPatronymic = persPatronymic;
    _isFavorite = fav;
    _persSex = persSex;
    _persAge = persAge;
    _personality = personality;
  }

  @override
  State<CharView> createState() => CharacterView();
}

class CharacterView extends State<CharView> {
  static const Color primaryColor = Color(0xffe36b44);
  static const Color backColor =  Color(0xffffe5b9);
  static const Color contrastColor = Color(0xff5191CA);

  // Character's properties
  late int _persID = widget._persID;
  late String _persName = widget._persName;
  late String _persLastName = widget._persLastName;
  late String _persPatronymic = widget._persPatronymic;
  late bool _isFavorite = widget._isFavorite;
  late bool _persSex = widget._persSex;
  late int _persAge = widget._persAge;
  late Personality _personality = widget._personality;

  late String strSex = _persSex == true ? 'Муж.' : 'Жен.';
  final String currentUserID = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text(
            'Созданный персонаж',
            style: TextStyle(fontSize: 24.0),
          ),
      ),

      body: Column(
        children: [
          const Divider(
            indent: double.infinity,
          ),

          Text(
            'Персонаж №$_persID',
            style: const TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Bajkal',
                color: primaryColor
            ),
          ),
          const Divider(
            indent: double.infinity,
          ),

          Row(
            children: [

                const Padding(
                  padding: EdgeInsets.only(left: 40, right: 0),
                  child: Text(
                    'Имя:',
                    style: TextStyle(
                        fontSize: 24.0, color: primaryColor
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(right: 40),
                  child: Text(
                    ' $_persName',
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

              const Padding(
                padding: EdgeInsets.only(left: 40.0),
                child: Text(
                  'Фамилия:',
                  style: TextStyle(fontSize: 24.0, color: primaryColor),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(right: 40.0),
                child: Text(
                  ' $_persLastName',
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
              const Padding(
                padding: EdgeInsets.only(left: 40.0),
                child: Text(
                  'Отчество:',
                  style: TextStyle(fontSize: 24.0, color: primaryColor),
                ),
              ),

              Flexible(
                child: Text(
                  ' $_persPatronymic',
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
              const Padding(
                padding: EdgeInsets.only(left: 40.0),
                child: Text(
                  'Пол:',
                  style: TextStyle(fontSize: 24.0, color: primaryColor),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(right: 40.0),
                child: Text(
                  ' $strSex',
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
              const Padding(
                padding: EdgeInsets.only(left: 40.0),
                child: Text(
                  'Возраст:',
                  style: TextStyle(fontSize: 24.0, color: primaryColor),
                ),
              ),


              Flexible(
                child: Text(
                  ' $_persAge',
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
              const Padding(
                padding: EdgeInsets.only(left: 40.0),
                child: Text(
                  'Тип личности по MBTI:',
                  style: TextStyle(fontSize: 24.0, color: primaryColor),
                ),
              ),

              Flexible(
                child: Text(
                  ' ${_personality.getMBTI}',
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
              const Padding(
                padding: EdgeInsets.only(left: 32.0),
                child: Text(
                  'Характер персонажа:',
                  style: TextStyle(fontSize: 24.0, color: primaryColor),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 32.0),
                child: Text(
                  ' ${_personality.getTemper}',
                  style: const TextStyle(fontSize: 24.0),
                ),
              ),
            ],
          ),


          Row(
            children: [
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
                        builder: (context) => CharEditor(
                            _persID, _persName, _persLastName, _persPatronymic, _persSex, _persAge, _personality
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
                      'name': "$_persName $_persLastName $_persPatronymic",
                      'type': 'Персонаж',
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
      ),

    );
  }

}
