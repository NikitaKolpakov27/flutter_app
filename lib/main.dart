import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_flutter/navigation/main_menu.dart';
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
          resizeToAvoidBottomInset: false,
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
                  children: <Widget>[

                    Padding(
                      padding: const EdgeInsets.only(left: 8, top: 16, bottom: 16, right: 8),
                      child: Text(
                        'Добро пожаловать!',
                        style: TextStyle(
                          fontSize: 40.0,
                          fontFamily: 'Bajkal',
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const Divider(
                      indent: double.infinity,
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 32, top: 0, right: 32, bottom: 8),
                      child: TextFormField(
                        decoration: InputDecoration(
                            labelText: "E-mail",
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
                        keyboardType: TextInputType.emailAddress,
                        style: sizeTextBlack,
                        onSaved: (val) => _email = val!,
                        onChanged: (val) => _email = val,
                        validator: (val) => emailValidator(_email)
                      ),
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
                        style: sizeTextBlack,
                        onSaved: (val) => _name = val!,
                        onChanged: (val) => _name = val,
                        validator: (val) =>
                        val!.length < 8
                            ? 'Слишком короткий логин'
                            : null,
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 32, top: 0, right: 32, bottom: 8),
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
                        style: sizeTextBlack,
                        onSaved: (val) => _password = val!,
                        onChanged: (val) => _password = val,
                        validator: (val) =>
                        val!.length < 8
                            ? 'Слишком короткий пароль'
                            : null,
                      ),
                    ),


                    Padding(
                      padding: const EdgeInsets.only(left: 32, top: 0, right: 32, bottom: 8),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: "Подтвердите пароль",
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
                        splashColor: const Color(0xff5191CA),
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
                          children: const <TextSpan>[
                            TextSpan(
                              text: "Войдите",
                              style: TextStyle(
                                color: Color(0xff5191CA)
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

    var users = FirebaseFirestore.instance.collection('users');
    var usersAsync = await users.get();

    var _userID = usersAsync.docs.length;

    FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password);
    FirebaseFirestore.instance.collection('users').add(
        {
          'id': _userID,
          'login': _name,
          'password': _password,
          'email': _email
        }
    );

    Navigator.push(
        _context,
        MaterialPageRoute(
              builder: (context) => MainMenu()));
  }

  void hideKeyboard() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }
}

