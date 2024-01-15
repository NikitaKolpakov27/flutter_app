import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_flutter/user/user.dart';
import 'main.dart';


class LoginProcess extends StatelessWidget {
  late String _name;
  late String _password;
  late String _email;

  final _sizeTextBlack = const TextStyle(fontSize: 20.0, color: Colors.black);
  final _sizeTextWhite = const TextStyle(fontSize: 20.0, color: Colors.white);
  final formKey = GlobalKey<FormState>();
  late BuildContext _context;
  final Registration reg = Registration();


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
                      decoration: const InputDecoration(labelText: "Login"),
                      keyboardType: TextInputType.name,
                      style: _sizeTextBlack,
                      onSaved: (val) => _name = val!,
                      onChanged: (val) => _name = val,
                      validator: (val) => usernameValidator(_name)
                    ),
                  ),
                  Container(
                    width: 400.0,
                    padding: const EdgeInsets.only(top: 10.0),
                    child: TextFormField(
                        decoration: const InputDecoration(labelText: "Password"),
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        style: _sizeTextBlack,
                        onSaved: (val) => _password = val!,
                        onChanged: (val) => _password = val,
                        validator: (val) => passwordValidator(_password, _name)
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0, right: 25.0),
                      child: Row(
                        children: [
                          MaterialButton(
                              color: Colors.indigoAccent,
                              height: 50.0,
                              minWidth: 150.0,
                              onPressed: submit,
                              child: Text(
                                "LOG IN",
                                style: _sizeTextWhite,
                              )
                          ),
                          MaterialButton(
                              color: Colors.indigoAccent,
                              height: 50.0,
                              minWidth: 150.0,
                              onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Registration(),
                                    ),
                                  );
                              },
                              child: Text(
                                "Back to Registration",
                                style: _sizeTextWhite,
                              )
                          )
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        )
    );
  }

  String? usernameValidator(username) {
    dynamic msg;

    getUsersData('login').then((val) {
      if (val.contains(username)) {
        print("Да, он в теме!");
      } else {
        print("Нет, его нету в базе");
        msg = 'Имени $username нет в базе!';
      }
    });

    if (username.length < 5) {
      msg = 'Имя слишком короткое!';
    }

    return msg;
  }

  String? passwordValidator(password, login) {
    dynamic msg;

    getUsersDataByLogin('password', login).then((val) {
      if (val == password) {
        print("Да, он в теме!");
      } else {
        print("ПАРОЛЬ. Нет, его нету в базе");
        msg = 'Такого пароля нет в базе!';
      }
    });

    if (password.length < 8) {
      msg = 'Пароль слишком короткий!';
    }

    return msg;
  }

  void submit() async {
    final form = formKey.currentState;

    // Инициализировать email по логину из БД (достать email из джсон файла)
    _email = 'default@mail.ru';

    if (form!.validate()) {

      try {
        var right_email = await getUsersDataByLogin('email', _name);
        var right_password = await getUsersDataByLogin('password', _name);

        _email = right_email;

        if (right_password != _password) {
          throw Exception('Неверный пароль!');
        }

        print('Успешный вход! E-mail: $_email');
        form.save();
        performLogin();
      } catch (e) {
        print('Нет пользователя с таким логином');
      }

    }
  }

  void performLogin() {
    hideKeyboard();
    Navigator.push(
        _context,
        MaterialPageRoute(
            builder: (context) => AddMenu(_name, _email, _password)));
  }

  void hideKeyboard() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

}