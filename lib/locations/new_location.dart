import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../favorite/new_favorite.dart';

class NewLocation extends StatefulWidget {
  const NewLocation({super.key});

  @override
  State<NewLocation> createState() => _CreateNewLocation();
}

class _CreateNewLocation extends State<NewLocation> {
  final formKeyLocation = GlobalKey<FormState>();
  late BuildContext _context;
  late String _name = '';

  // Location's properties
  late int _locationID = 0;
  late bool _isFavorite = false;
  late String _locationName = '';
  late String _description = '';

  // _CreateNewLocation(String name) {
  //   _name = name;
  // }

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
        iconSize: 30,
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
              label: "Избранное",
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
              const Divider(),
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
            // builder: (context) => LocationView(_locationID, _isFavorite, _locationName, _description)));
            builder: (context) => LocView(_locationID, _locationName, _isFavorite,  _description)));
  }

  void hideKeyboard() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }
}

class LocView extends StatefulWidget {
  // final int locID;
  // const LocView({Key? key, required this.locID}) : super(key: key);

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

  // Location properties
  late int _locationID = widget._locationID;
  late bool _isFavorite = widget._isFavorite;
  late String _locationName = widget._locationName;
  late String _description = widget._description;

  // LocationView(int locationID, bool isFavorite, String locationName, String description) {
  //   _locationID = locationID;
  //   _isFavorite = isFavorite;
  //   _locationName = locationName;
  //   _description = description;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
              "Созданная локация",
              style: TextStyle(fontSize: 25.0),
          ),
        ),

        body: Column(
          children: [
            Text('Название локации: $_locationName'),
            const Divider(),
            Text('Описание локации: $_description'),
            const Divider(),

            Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: MaterialButton(
                color: Colors.indigoAccent,
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

