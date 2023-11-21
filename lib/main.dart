import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MaterialApp(
  home: MyApp(),
));

class MyApp extends StatelessWidget {
  late String _name;
  late String _password;
  final _sizeTextBlack = const TextStyle(fontSize: 20.0, color: Colors.black);
  final _sizeTextWhite = const TextStyle(fontSize: 20.0, color: Colors.white);
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
                    Container(
                      width: 400.0,
                      child: TextFormField(
                        decoration: InputDecoration(labelText: "Login"),
                        keyboardType: TextInputType.name,
                        style: _sizeTextBlack,
                        onSaved: (val) => _name = val!,
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
                        style: _sizeTextBlack,
                        onSaved: (val) => _password = val!,
                        validator: (val) =>
                        val!.length < 8
                            ? 'Too short password'
                            : null,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 25.0),
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
                  ],
                ),
              ),
          ),
        )
    );
  }

  void submit() {
    final form = formKey.currentState;
    if (form!.validate()) {
      form.save();
      performLogin();
    }
  }

  void performLogin() {
    hideKeyboard();
    Navigator.push(
        _context,
        MaterialPageRoute(
            builder: (context) => SecondScreen(_name, _password)));
  }

  void hideKeyboard() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

}

class SecondScreen extends StatelessWidget {
  String _name = '';
  String _password = '';
  final _sizeTextBlack = const TextStyle(fontSize: 20.0, color: Colors.black);

  SecondScreen(String name, String password) {
    _name = name;
    _password = password;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Second Screen"),
        ),
        body: Center(
          child: Text(
            "Login: $_name, password: $_password",
            style: _sizeTextBlack,
          ),
        ));
  }
}