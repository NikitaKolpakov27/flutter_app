import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_flutter/adding/add_entity.dart';
import '../favorite/new_favorite.dart';

class NewLocation extends StatefulWidget {
  const NewLocation({super.key});

  @override
  State<NewLocation> createState() => _CreateNewLocation();
}

class _CreateNewLocation extends State<NewLocation> {
  final formKeyLocation = GlobalKey<FormState>();
  late BuildContext _context;

  // Location's properties
  late int _locationID = 0;
  late bool _isFavorite = false;
  late String _locationName = '';
  late String _description = '';

  static const Color primaryColor =  Color(0xffe36b44);
  static const Color backColor = Color(0xffffe5b9);

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Scaffold(
      backgroundColor: backColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text(
          "Создание локации",
          style: TextStyle(
              fontSize: 20.0,
              fontStyle: FontStyle.italic,
              color: Colors.white
          ),
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color(0xfffbff29),
        unselectedItemColor: const Color(0xffd54a16),
        type: BottomNavigationBarType.shifting,
        iconSize: 35,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: "Создание",
            backgroundColor: Color(0xfff38557),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_tree),
            label: "Генерация",
            backgroundColor: Color(0xfff38557),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: "Избранное",
            backgroundColor: Color(0xfff38557),
          )
        ],
      ),

      body: Center(
        child: Form(
          key: formKeyLocation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Новая локация',
                style: TextStyle(fontSize: 25.0, fontFamily: 'Bajkal'),
              ),
              const Divider(
                indent: double.infinity,
              ),
              SizedBox(
                width: 400.0,
                child: TextFormField(
                  decoration: const InputDecoration(labelText: "Название локации"),
                  keyboardType: TextInputType.name,
                  onSaved: (val) => _locationName = val!,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Слишком короткое название локации";
                    }
                    return null;
                  },
                ),
              ),
              const Divider(
                indent: double.infinity,
              ),
              TextFormField(
                minLines: 2,
                maxLines: 5,
                decoration: const InputDecoration(
                  hintText: "Опишите свою локацию",
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                ),
                keyboardType: TextInputType.multiline,
                onSaved: (val) => _description = val!,
                validator: (val) {
                  if (val!.isEmpty) {
                    return "Слишком мало написано";
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: MaterialButton(
                  color: primaryColor,
                  height: 50.0,
                  minWidth: 150.0,
                  onPressed: submitLocation,
                  child: const Text(
                    "Создать локацию",
                    style: TextStyle(
                        color: Colors.white
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

  void submitLocation() {
    final form = formKeyLocation.currentState;
    if (form!.validate()) {
      form.save();
      performLocation();
    }
  }

  void performLocation() async {
    hideKeyboard();

    var locations = FirebaseFirestore.instance.collection('locations');
    var locationsAsync = await locations.get();

    _locationID = locationsAsync.docs.length;

    FirebaseFirestore.instance.collection('locations').add(
        {
          'id': _locationID,
          'location_name': _locationName,
          'description': _description
        }
    );

    Navigator.push(
        _context,
        MaterialPageRoute(
            builder: (context) => LocView(_locationID, _locationName, _isFavorite, _description)));
  }

  void hideKeyboard() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }
}

class LocView extends StatefulWidget {

  late int _locationID;
  late String _locationName;
  late bool _isFavorite;
  late String _description;

  LocView(int locationID, String locationName, bool isFavorite, String description, {super.key}) {
    _locationID = locationID;
    _locationName = locationName;
    _isFavorite = isFavorite;
    _description = description;
  }

  @override
  State<LocView> createState() => LocationView();
}

class LocationView extends State<LocView> {
  static const Color primaryColor = Color(0xffe36b44);
  static const Color backColor =  Color(0xffffe5b9);

  // Location properties
  late int _locationID = widget._locationID;
  late bool _isFavorite = widget._isFavorite;
  late String _locationName = widget._locationName;
  late String _description = widget._description;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backColor,
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: const Text(
              "Созданная локация",
              style: TextStyle(fontSize: 25.0),
          ),
        ),

        body: Column(
          children: [
            Text('Название локации: $_locationName'),
            const Divider(
              indent: double.infinity,
            ),
            Text('Описание локации: $_description'),
            const Divider(
              indent: double.infinity,
            ),

            Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: MaterialButton(
                color: primaryColor,
                height: 50.0,
                minWidth: 150.0,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddMenu(),
                    ),
                  );
                  setState(() {
                    _isFavorite = true;
                  });
                },
                child: const Text(
                  "ОК",
                  style: TextStyle(
                      color: Colors.white
                  ),
                ),
              ),
            ),

            const Divider(
              indent: double.infinity,
            ),

            Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: MaterialButton(
                color: primaryColor,
                height: 50.0,
                minWidth: 150.0,
                onPressed: () {
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
                      color: Colors.white
                  ),
                ),
              ),
            ),
          ],
        )
    );
  }
}

