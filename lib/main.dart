import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_flutter/file_utils/file_utils.dart';
import 'package:test_flutter/character/pers.dart';
import 'package:test_flutter/character/perses_json.dart';
import 'package:test_flutter/locations/locations_json.dart';
import 'package:test_flutter/settings/settings.dart';
import 'package:test_flutter/story/stories_json.dart';
import 'package:test_flutter/user/user.dart';
import 'package:test_flutter/user/users_json.dart';
import 'character/new_character.dart';
import 'locations/new_location.dart';
import 'story/new_story.dart';
import 'login.dart';

void main() => runApp(MaterialApp(
  home: Registration(),
));

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//
//   final String data = await rootBundle.loadString('assets/perses.json');
//   var decoded = json.decode(data);
//   print(decoded);
// }

class Registration extends StatelessWidget {
  late String _name;
  late String _password;
  late String _email;
  late String _confirmPassword;
  TextStyle sizeTextBlack = const TextStyle(fontSize: 20.0, color: Colors.black);
  TextStyle _sizeTextWhite = const TextStyle(fontSize: 20.0, color: Colors.white);
  final formKey = GlobalKey<FormState>();
  late BuildContext _context;

  @override
  Widget build(BuildContext context) {
    _context = context;
    return MaterialApp(
        theme: ThemeData(primaryColor: Colors.indigoAccent),
        home: Scaffold(
          appBar: AppBar(
            title: const Text("Приложение для писателей"),
            centerTitle: true,
          ),
          body: Center(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: 400.0,
                      child: TextFormField(
                        decoration: const InputDecoration(labelText: "E-mail"),
                        keyboardType: TextInputType.emailAddress,
                        style: sizeTextBlack,
                        onSaved: (val) => _email = val!,
                        onChanged: (val) => _email = val,
                        validator: (val) => emailValidator(_email)
                      ),
                    ),
                    SizedBox(
                      width: 400.0,
                      child: TextFormField(
                        decoration: const InputDecoration(labelText: "Login"),
                        keyboardType: TextInputType.name,
                        style: sizeTextBlack,
                        onSaved: (val) => _name = val!,
                        onChanged: (val) => _name = val,
                        validator: (val) =>
                        val!.length < 8
                            ? 'Too short name'
                            : null,
                      ),
                    ),
                    Container(
                      width: 400.0,
                      padding: const EdgeInsets.only(top: 10.0),
                      child: TextFormField(
                        decoration: const InputDecoration(labelText: "Password"),
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        style: sizeTextBlack,
                        onSaved: (val) => _password = val!,
                        onChanged: (val) => _password = val,
                        validator: (val) =>
                        val!.length < 8
                            ? 'Too short password'
                            : null,
                      ),
                    ),
                    Container(
                      width: 400.0,
                      padding: const EdgeInsets.only(top: 10.0),
                      child: TextFormField(
                        decoration: const InputDecoration(labelText: "Confirm Password"),
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        style: sizeTextBlack,
                        onSaved: (val) => _confirmPassword = val!,
                        validator: (val) {
                          if (val! != _password) {
                            return 'Passwords are not the same!';
                          } else {
                            return null;
                          }
                        }
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: MaterialButton(
                        color: Colors.indigoAccent,
                        height: 50.0,
                        minWidth: 150.0,
                        onPressed: submit,
                        child: Text(
                          "REGISTER",
                          style: _sizeTextWhite,
                        ),
                      ),
                    ),
                    const Divider(),
                    InkWell(
                      child: RichText(
                        text: TextSpan(
                          text: "Already have an account? ",
                          style: sizeTextBlack,
                          children: const <TextSpan>[
                            TextSpan(
                              text: "Sign in",
                              style: TextStyle(
                                color: Colors.indigoAccent
                              )
                            )
                          ]
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginProcess(),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
          ),
        )
    );
  }

  String? emailValidator(email) {
    dynamic msg;

    RegExp exp = RegExp(r'[a-zA-Z0-9_.]+@[A-Za-z]+\.[a-z]{2,4}');
    if (exp.hasMatch(email)) {
      msg = null;
    } else {
      msg = 'Неправильный E-mail формат!';
    }

    return msg;
  }

  void submit() {
    final form = formKey.currentState;
    if (form!.validate()) {
      form.save();
      performLogin();
    }
  }

  void performLogin() async {
    hideKeyboard();

    // ДОБАВИТЬ ЗАПИСЬ В БД !!!
    var us_id = await getAllUsers(); // Это работает
    writeUser(us_id.length, _name, _password);

    Navigator.push(
        _context,
        MaterialPageRoute(
            // builder: (context) => AddMenu(_name, _email, _password)));
              builder: (context) => AddMenu()));
  }

  void hideKeyboard() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

}

class AddMenu extends StatefulWidget {
  @override
  _AddMenu createState() {
    return _AddMenu();
  }
}

class _AddMenu extends State<AddMenu> {
  String _name = '';
  String _password = '';
  String _email = '';

  TextStyle _current_style = const TextStyle(fontSize: 20.0, color: Colors.black);
  final _sizeTitleDrawer = const TextStyle(fontSize: 30.0, fontStyle: FontStyle.italic, color: Colors.lightBlue);

  // AddMenu(String name, String email, String password) {
  //   _name = name;
  //   _password = password;
  //   _email = email;
  // }
  //
  // AddMenu.copy(AddMenu addMenu, {super.key}) {
  //   _name = addMenu._name;
  //   _password = addMenu._password;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Приложение для писателей",
            style: TextStyle(
              fontSize: 22.0,
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
                height: 550,
                width: 250,
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const JsonChar(),
                          ),
                        );
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const JsonStory(),
                          ),
                        );
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const JsonLocation(),
                          ),
                        );
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

                    const Divider(),

                    InkWell(
                      onTap: () async {
                        var custom_style = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Settings(),
                          ),
                        );
                        setState(() {
                          _current_style = custom_style;
                        });
                      },
                      child: SizedBox(
                        height: 50,
                        width: 50,
                        child: Container(
                          height: 50,
                          width: 50,
                          color: Colors.indigo,
                          child: const Center(child: Text(
                            'Настройки',
                            style: TextStyle(
                                fontSize: 10.0
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


        body: SizedBox(
          height: 500,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              children: [
                const SizedBox(height: 20,),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CreateNewCharacter(_name),
                        ),
                    );
                  },
                  child: SizedBox(
                    height: 150,
                    child: Column(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.blue,
                          ),
                          height: 100,
                          width: 300,
                          margin: const EdgeInsets.all(20),
                          child: Center(child: Text('Создать нового персонажа', style: _current_style,),),
                        ),
                      ],
                    ),
                  ),
                ),


                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CreateNewLocation(_name),
                      ),
                    );
                  },
                  child: SizedBox(
                    height: 150,
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 100,
                          width: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.blue,
                          ),
                          margin: const EdgeInsets.all(20),
                          child: Center(child: Text('Создать новую локацию', style: _current_style,),),
                        ),
                      ],
                    ),
                  ),
                ),


                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CreateNewStory(_name),
                      ),
                    );
                  },
                  child: SizedBox(
                    height: 150,
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 100,
                          width: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.blue,
                          ),
                          margin: const EdgeInsets.all(20),
                          child: Center(child: Text('Создать новую историю', style: _current_style,),),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ));
  }
}

