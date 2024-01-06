import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../user.dart';

Future<String> get _usersPath async {
  final directory = await getTemporaryDirectory();
  return directory.path;
}

Future<String> readUser() async {
  try {
    final file = await _usersFile;
    final contents = await file.readAsString();

    return contents;

  } catch (e) {
    return '0';
  }
}

Future<File> get _usersFile async {
  final path = await _usersPath;
  return File('$path/assets/users.json');
}

Future<File> writeUser(id, login, password) async {
  final file = await _usersFile;

  // Создание нового пользователя и подготовка его к записи в БД
  User new_user = User(id, login, password);
  final encoded = jsonEncode(new_user);
  final new_entry = jsonDecode(encoded);

  // Получение БД в текстовом виде
  final data = await file.readAsString();
  var decoded = json.decode(data);
  var users = decoded["users"] as List;

  // Запись нового пользователя
  users.insert(users.length, new_entry);
  var response = jsonEncode(decoded);
  print("RESPONSE: $response");

  return file.writeAsString(response.toString());
}

