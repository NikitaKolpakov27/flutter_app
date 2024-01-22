import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_flutter/character/perses_fire.dart';
import 'package:test_flutter/file_utils/file_utils.dart';
import 'package:test_flutter/user/user.dart';
import 'adding/add_entity.dart';
import 'login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Platform.isAndroid
  ? await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: 'AIzaSyC7H3JUJGOuFO8G8tzzo1g528UCG48J4-w',
        appId: '1:420289599985:android:fd9221f21110463ca70c50',
        messagingSenderId: '420289599985',
        projectId: 'writersflutter'
    )
  )
  : await Firebase.initializeApp();
  runApp(MaterialApp(home: Registration()));
}

class Registration extends StatelessWidget {
  late String _name;
  late String _password;
  late String _email;
  late String _confirmPassword;
  TextStyle sizeTextBlack = const TextStyle(fontSize: 20.0, color: Colors.black);
  TextStyle _sizeTextWhite = const TextStyle(fontSize: 20.0, color: Colors.white);

  Color primaryColor = const Color(0xffe36b44);

  final formKey = GlobalKey<FormState>();
  late BuildContext _context;

  void initFirebase() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    return MaterialApp(
        theme: ThemeData(
            primaryColor: const Color(0xffe79521),
            scaffoldBackgroundColor: const Color(0xffffe5b9)
        ),
        home: Scaffold(
          appBar: AppBar(
            title: const Text("Приложение для писателей"),
            centerTitle: true,
            backgroundColor: primaryColor,
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
                        decoration: const InputDecoration(labelText: "Логин"),
                        keyboardType: TextInputType.name,
                        style: sizeTextBlack,
                        onSaved: (val) => _name = val!,
                        onChanged: (val) => _name = val,
                        validator: (val) =>
                        val!.length < 8
                            ? 'Слишком короткий логин'
                            : null,
                      ),
                    ),
                    Container(
                      width: 400.0,
                      padding: const EdgeInsets.only(top: 10.0),
                      child: TextFormField(
                        decoration: const InputDecoration(labelText: "Пароль"),
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        style: sizeTextBlack,
                        onSaved: (val) => _password = val!,
                        onChanged: (val) => _password = val,
                        validator: (val) =>
                        val!.length < 8
                            ? 'Слишком короткий пароль'
                            : null,
                      ),
                    ),
                    Container(
                      width: 400.0,
                      padding: const EdgeInsets.only(top: 10.0),
                      child: TextFormField(
                        decoration: const InputDecoration(labelText: "Подтвердите пароль"),
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        style: sizeTextBlack,
                        onSaved: (val) => _confirmPassword = val!,
                        validator: (val) {
                          if (val! != _password) {
                            return 'Пароли отличаются';
                          } else {
                            return null;
                          }
                        }
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: MaterialButton(
                        color: primaryColor,
                        height: 50.0,
                        minWidth: 150.0,
                        onPressed: submit,
                        child: Text(
                          "Зарегистрироваться",
                          style: _sizeTextWhite,
                        ),
                      ),
                    ),
                    const Divider(),
                    InkWell(
                      child: RichText(
                        text: TextSpan(
                          text: "У Вас уже есть аккаунт? ",
                          style: sizeTextBlack,
                          children: <TextSpan>[
                            TextSpan(
                              text: "Войдите",
                              style: TextStyle(
                                color: primaryColor
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

