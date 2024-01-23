import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LocationEditor extends StatefulWidget {

  late int _locationID;
  late String _locationName;
  late bool _isFavorite;
  late String _description;

  LocationEditor(int locationID, String locationName, bool isFavorite, String description) {
    _locationID = locationID;
    _locationName = locationName;
    _isFavorite = isFavorite;
    _description = description;
  }

  @override
  State<LocationEditor> createState() => _LocationEditor();
}

class _LocationEditor extends State<LocationEditor> {
  final formKeyLocation = GlobalKey<FormState>();
  late BuildContext _context;

  // Location's properties
  late int _locationID = widget._locationID;
  late bool _isFavorite = widget._isFavorite;
  late String _locationName = widget._locationName;
  late String _description = widget._description;

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
          "Изменение локации",
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
              const Padding(
                padding: EdgeInsets.only(left: 8, top: 0, bottom: 32, right: 8),
                child: Text(
                  'Локация',
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
                    "Обновить локацию",
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

    // FirebaseFirestore.instance.collection('locations').doc();

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