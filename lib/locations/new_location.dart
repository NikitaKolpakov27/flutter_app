import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_flutter/adding/add_entity.dart';
import 'package:test_flutter/locations/edit_location.dart';
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
  static const Color contrastColor = Color(0xff5191CA);

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
          child: ListView(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(left: 8, top: 0, bottom: 32, right: 8),
                child: Text(
                  'Новая локация',
                  style: TextStyle(
                    fontSize: 32.0,
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
                padding: const EdgeInsets.only(left: 32, top: 0, right: 32, bottom: 0),
                child: TextFormField(
                  decoration: InputDecoration(
                      labelText: "Название локации",
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: contrastColor),
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

              Padding(
                padding: const EdgeInsets.only(left: 32, top: 0, right: 32, bottom: 0),
                child: TextFormField(
                  minLines: 2,
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: "Опишите свою локацию",
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
                  keyboardType: TextInputType.multiline,
                  onSaved: (val) => _description = val!,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Слишком мало написано";
                    }
                    return null;
                  },
                ),
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
  static const Color contrastColor = Color(0xff5191CA);

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

            const Divider(
              indent: double.infinity,
            ),

            Text(
              'Локация №$_locationID',
              style: const TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Bajkal',
                  color: primaryColor
              ),
            ),
            const Divider(
              indent: double.infinity,
            ),

            Row(
              children: [

                const Padding(
                  padding: EdgeInsets.only(left: 32, right: 0),
                  child: Text(
                    'Название:',
                    style: TextStyle(
                        fontSize: 24.0, color: primaryColor
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(right: 32),
                  child: Text(
                    ' $_locationName',
                    style: const TextStyle(fontSize: 24.0),
                  ),
                ),
              ],
            ),
            const Divider(
              indent: double.infinity,
            ),

            Column(
              children: [

                const Padding(
                  padding: EdgeInsets.only(left: 16, right: 0, bottom: 8),
                  child: Text(
                    'Описание:',
                    style: TextStyle(
                        fontSize: 24.0, color: primaryColor
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(bottom: 0),
                  child: Text(
                    ' $_description',
                    style: const TextStyle(fontSize: 24.0),
                  ),
                ),
              ],
            ),
            const Divider(
              indent: double.infinity,
            ),

            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 24.0, top: 24.0, right: 16),
                  child: MaterialButton(
                    splashColor: contrastColor,
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
                    },
                    child: const Text(
                      "ОК",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 24.0, top: 24.0, right: 16),
                  child: MaterialButton(
                    splashColor: contrastColor,
                    color: primaryColor,
                    height: 50.0,
                    minWidth: 150.0,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LocationEditor(
                              _locationID, _locationName, _isFavorite, _description
                          ),
                          // builder: (context) => const AddMenu(),
                        ),
                      );
                    },
                    child: const Text(
                      "Редактировать",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const Divider(
              indent: double.infinity,
            ),

            Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: MaterialButton(
                splashColor: contrastColor,
                color: const Color(0xffb44c1a),
                height: 50.0,
                minWidth: 150.0,
                onPressed: () async {

                  var favorites = FirebaseFirestore.instance.collection('favorites');
                  var favoritesAsync = await favorites.get();

                  var favID = favoritesAsync.docs.length;

                  FirebaseFirestore.instance.collection('favorites').add(
                      {
                        'id': favID,
                        'name': _locationName,
                        'type': 'Локация'
                      }
                  );

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
                      color: Colors.white,
                      fontSize: 16.0
                  ),
                ),
              ),
            ),
          ],
        )
    );
  }
}

