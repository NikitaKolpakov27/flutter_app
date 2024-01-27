import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_flutter/navigation/main_menu.dart';
import 'package:test_flutter/user/user.dart';
import 'adding/add_entity.dart';
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

  Color primaryColor = const Color(0xffe36b44);

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
            title: const Text(
              "StoryForge",
              style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 24
              ),
            ),
            centerTitle: true,
            backgroundColor: primaryColor,
          ),
          body: Center(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  Padding(
                    padding: const EdgeInsets.only(left: 8, top: 0, bottom: 32, right: 8),
                    child: Text(
                      'Вход',
                      style: TextStyle(
                        fontSize: 40.0,
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
                      decoration: InputDecoration(
                          labelText: "Логин",
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
                      style: _sizeTextBlack,
                      onSaved: (val) => _name = val!,
                      onChanged: (val) => _name = val,
                      validator: (val) => usernameValidator(_name)
                    ),
                  ),


                  Padding(
                    padding: const EdgeInsets.only(left: 32, top: 0, right: 32, bottom: 0),
                    child: TextFormField(
                        decoration: InputDecoration(
                            labelText: "Пароль",
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
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        style: _sizeTextBlack,
                        onSaved: (val) => _password = val!,
                        onChanged: (val) => _password = val,
                        validator: (val) => passwordValidator(_password, _name)
                    ),
                  ),

                  const Divider(
                    indent: double.infinity,
                  ),


                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 72, top: 0, bottom: 0, right: 32),
                        child: MaterialButton(
                            splashColor: const Color(0xff5191CA),
                            color: primaryColor,
                            height: 48.0,
                            minWidth: 80.0,
                            onPressed: submit,
                            child: Text(
                              "Войти",
                              style: _sizeTextWhite,
                            )
                        ),
                      ),

                      const Divider(),

                      Padding(
                        padding: const EdgeInsets.only(left: 0, top: 0, bottom: 0, right: 0),
                        child: MaterialButton(
                            splashColor: const Color(0xff5191CA),
                            color: primaryColor,
                            height: 48.0,
                            minWidth: 80.0,
                            onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Registration(),
                                  ),
                                );
                            },
                            child: Text(
                              "Регистрация",
                              style: _sizeTextWhite,
                            )
                        ),
                      )
                    ],
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
              // builder: (context) => AddMenu()));
            builder: (context) => MainMenu()));
  }

  void hideKeyboard() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

}