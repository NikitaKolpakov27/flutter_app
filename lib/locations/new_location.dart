import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CreateNewLocation extends StatelessWidget {
  final formKeyLocation = GlobalKey<FormState>();
  late BuildContext _context;
  late String _name = '';

  // Location's properties
  late int _locationID = 0;
  late String _locationName = '';
  late String _description = '';

  CreateNewLocation(String name) {
    _name = name;
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Scaffold(
      appBar: AppBar(
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
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: "Создание"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_tree),
              label: "Генерация"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.star),
              label: "Избранное"
          )
        ],
      ),

      body: Center(
        child: Form(
          key: formKeyLocation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
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
              SizedBox(
                width: 400.0,
                child: TextFormField(
                  decoration: const InputDecoration(labelText: "Описание"),
                  keyboardType: TextInputType.name,
                  onSaved: (val) => _description = val!,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Слишком короткое описание";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: MaterialButton(
                  color: Colors.indigoAccent,
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

  void performLocation() {
    hideKeyboard();
    Navigator.push(
        _context,
        MaterialPageRoute(
            builder: (context) => LocationView(_locationID, _locationName, _description)));
  }

  void hideKeyboard() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }
}

class LocationView extends StatelessWidget {

  // Story's properties
  late int _locationID = 0;
  late String _locationName = '';
  late String _description = '';

  LocationView(int locationID, String locationName, String description) {
    _locationID = locationID;
    _locationName = locationName;
    _description = description;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Результаты"),
        ),

        body: Column(
          children: [
            Text('Название локации: $_locationName'),
            Divider(),
            Text('Описание локации: $_description'),
            Divider(),
          ],
        )
    );
  }
}

