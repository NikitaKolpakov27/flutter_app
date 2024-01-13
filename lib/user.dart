import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

void main() async {
  print(await getUsersDataByLogin('password', 'Nikita101'));
}

getAllUsers() async {
  WidgetsFlutterBinding.ensureInitialized();

  final String data = await rootBundle.loadString('assets/users.json');
  var decoded = json.decode(data);
  var users = decoded["users"] as List;

  return users;
}

// Функция, возвращающая данные пользователя (ID, логин, пароль)
getUsersData(type_data) async {
  WidgetsFlutterBinding.ensureInitialized();

  final String data = await rootBundle.loadString('assets/users.json');
  var decoded = json.decode(data);
  var users = decoded["users"] as List;

  List userData = [];

  for (var user in users) {
    userData.insert(userData.length, user[type_data]);
  }

  return userData;
}

// Функция, возвращающая данные пользователя по логину (ID, emial, пароль)
getUsersDataByLogin(type_data, login) async {
  WidgetsFlutterBinding.ensureInitialized();

  final String data = await rootBundle.loadString('assets/users.json');
  var decoded = json.decode(data);
  var users = decoded["users"] as List;

  dynamic userData;

  for (var user in users) {

    if (user['login'] == login) {
      userData = user[type_data];
    }
  }

  return userData;
}

// Создание нового пользователя и запись его в БД
createNewUser(id, login, password) {
  User new_user = User(id, login, password);
  final encoded = jsonEncode(new_user);
  final new_entry = jsonDecode(encoded); // Новый пользователь без кавычек

  // Запись в БД
  File file = File("./lib/db/users.json");
  final data = file.readAsStringSync();

  var decoded = json.decode(data);
  var users = decoded["users"] as List;

  users.insert(users.length, new_entry);
  var response = jsonEncode(decoded);
  print(response);


  file.writeAsStringSync(response.toString());
  print('New user has been created');
}

class User {
  final int _id;
  final String _login;
  final String _password;

  User(this._id, this._login, this._password);

  factory User.fromJson(Map<String, Object?> jsonMap) {
    return User(jsonMap['id'] as int, jsonMap['login'] as String, jsonMap['password'] as String);
  }

  Map toJson() => {
    "id": _id,
    "login": _login,
    "password": _password,
  };

  @override
  String toString() {
    return "Name: $_login \t Password: $_password";
  }

}