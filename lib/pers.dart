import 'dart:convert';
import 'dart:io';

import 'character/personality.dart';

void main() {
  // var res = getAllChars();
  // print(res);
  var res = getInfoByID(0);
  print(res);
}

getInfoByID(id) {
  File file = File("./assets/perses.json");

  final data = file.readAsStringSync();
  var decoded = json.decode(data);
  var chars = decoded["perses"] as List;

  List charData = [];
  List personalityData = [];

  for (var char in chars) {

    var personality = char["personality"] as List;
    
    if (char["id"] == id) {

      for (var pers in personality) {
        personalityData.insert(personalityData.length,
            Personality(
                char["id"],
                pers["mbti"],
                pers["temper"]
            )
        );
      }

      charData.insert(charData.length, Character(
          char["id"], char["name"], char["lastname"], char["patronymic"],
          char["sex"], char["age"],
          personalityData[0]
      ));
    }
  }

  return charData;
}

getAllChars() {
  File file = File("./assets/perses.json");

  final data = file.readAsStringSync();
  var decoded = json.decode(data);
  var chars = decoded["perses"] as List;

  return chars;
}

// Функция, возвращающая данные персонажа (ID, имя, фамилия и т.д.)
getUsersData(type_data) {
  File file = File("./lib/db/perses.json");

  final data = file.readAsStringSync();
  var decoded = json.decode(data);
  var chars = decoded["perses"] as List;

  List charData = [];

  for (var char in chars) {
    charData.insert(charData.length, char[type_data]);
  }

  return charData;
}

// Создание нового пользователя и запись его в БД
createNewChar(id, name, lastname, patronymic, sex, age, personality) {
  Character new_char = Character(id, name, lastname, patronymic, sex, age, personality);
  final encoded = jsonEncode(new_char);
  final new_entry = jsonDecode(encoded); // Новый персонаж без кавычек

  // Запись в БД
  File file = File("./lib/assets/perses.json");
  final data = file.readAsStringSync();

  var decoded = json.decode(data);
  var chars = decoded["perses"] as List;

  chars.insert(chars.length, new_entry);
  var response = jsonEncode(decoded);
  print(response);


  file.writeAsStringSync(response.toString());
  print('New character has been created');
}

class Character {
  final int _id;
  final String _name;
  final String _lastname;
  final String _patronymic;
  final bool _sex;
  final int _age;
  final Personality _personality;


  Character(
      this._id,
      this._name,
      this._lastname,
      this._patronymic,
      this._sex,
      this._age,
      this._personality
      );

  factory Character.fromJson(Map<String, Object?> jsonMap) {
    return Character(
        jsonMap['id'] as int,
        jsonMap['name'] as String,
        jsonMap['lastname'] as String,
        jsonMap['patronymic'] as String,
        jsonMap['sex'] as bool,
        jsonMap['age'] as int,
        jsonMap['personality'] as Personality
    );
  }

  Map toJson() => {
    "id": _id,
    "name": _name,
    "lastname": _lastname,
    "patronymic": _patronymic,
    "sex": _sex,
    "age": _age,
    "personality": _personality
  };

  @override
  String toString() {
    var sexStr = _sex == true ? "Male" : "Female";
    return "Character: $_name $_lastname $_patronymic. $sexStr, $_age years old. Personality = ${_personality.getMbti()}, ${_personality.getTemper()}";
  }

}