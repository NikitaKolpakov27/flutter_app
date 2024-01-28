import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_flutter/locations/location_fire.dart';

import '../navigation/edit_view.dart';

class StoryEditor extends StatefulWidget {

  late int _storyID;
  late String _storyTitle;
  late String _genre;
  late bool _isFavorite;
  late String _location;

  StoryEditor(int id, String title, String genre, bool isFavorite, String loc) {
    _storyID = id;
    _storyTitle = title;
    _genre = genre;
    _isFavorite = isFavorite;
    _location = loc;
  }

  @override
  State<StoryEditor> createState() => _StoryEditor();
}

class _StoryEditor extends State<StoryEditor> {
  final formKeyLocation = GlobalKey<FormState>();
  late BuildContext _context;

  // Location's properties
  late final int _storyID = widget._storyID;
  late String _storyTitle = widget._storyTitle;
  late String _genre = widget._genre;
  late bool _isFavorite = widget._isFavorite;
  late String _location = widget._location;

  late String selectedGenre = _genre;
  late String selectedLocation = 'The Grand Canyon. The most huge landscape in North America. Also known as a popular site';

  static const Color primaryColor =  Color(0xffe36b44);
  static const Color backColor = Color(0xffffe5b9);
  final String currentUserID = FirebaseAuth.instance.currentUser!.uid;

  List<DropdownMenuItem<String>> get dropdownGenres {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "Хоррор", child: Text("Хоррор")),
      const DropdownMenuItem(value: "Драма", child: Text("Драма")),
      const DropdownMenuItem(value: "Сказка", child: Text("Сказка")),
      const DropdownMenuItem(value: "Комедия", child: Text("Комедия")),
      const DropdownMenuItem(value: "Рассуждение", child: Text("Рассуждение")),
      const DropdownMenuItem(value: "Повесть", child: Text("Повесть")),
      const DropdownMenuItem(value: "Научная фанатастика", child: Text("Научная фанатастика")),
    ];
    return menuItems;
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: backColor,
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: const Text(
            "Изменение истории",
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
                    'История',
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
                    initialValue: _storyTitle,
                    decoration: InputDecoration(
                      labelText: "Название",
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
                    onSaved: (val) => _storyTitle = val!,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Слишком короткое название";
                      }
                      return null;
                    },
                  ),
                ),

                const Divider(
                  indent: double.infinity,
                ),

                const Text(
                  'Жанр',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: primaryColor,
                      fontSize: 20.0,
                      fontFamily: 'Bajkal'
                  ),
                ),
                SizedBox(
                  child: DropdownButton(
                    value: selectedGenre,
                    items: dropdownGenres,
                    onChanged: (String? val) {
                      setState(() {
                        selectedGenre = val!;
                      });
                    },
                    isExpanded: false,
                  ),
                ),
                const Divider(
                  indent: double.infinity,
                ),

                const Text(
                  'Локация',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: primaryColor,
                      fontSize: 20.0,
                      fontFamily: 'Bajkal'
                  ),
                ),
                StreamBuilder(
                  stream: FirebaseFirestore.instance.collection('locations').snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    List<DropdownMenuItem<String>> locationItems = [];

                    // Set default value
                    locationItems.add(const DropdownMenuItem<String>(
                        value: 'The Grand Canyon. The most huge landscape in North America. Also known as a popular site',
                        child: Text(
                            'The Grand Canyon'
                        )
                    ));

                    if (!snapshot.hasData) {
                      return const CircularProgressIndicator();
                    }

                    final locations = snapshot.data?.docs.toList();
                    for (var loc in locations!) {
                      locationItems.add(DropdownMenuItem<String>(
                          value: loc['location_name'] + ". " + loc['description'],
                          child: Text(
                              loc['location_name']
                          )
                      ));
                    }
                    return DropdownButton<String>(
                      value: selectedLocation,
                      items: locationItems,
                      onChanged: (String? val) {
                        setState(() {
                          selectedLocation = val!;
                        });
                      },
                      isExpanded: false,
                    );
                  },
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
                    onPressed: submitStory,
                    child: const Text(
                      "Обновить",
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
      ),
    );
  }

  void submitStory() {
    final form = formKeyLocation.currentState;
    if (form!.validate()) {
      form.save();
      updateLocation();
    }
  }

  void updateLocation() async {
    hideKeyboard();

    _location = selectedLocation;
    _genre = selectedGenre;
    Map<String, dynamic> updateInfo = {
      'title': _storyTitle,
      'genre': _genre,
      'location': _location,
      'user_id': currentUserID
    };

    print('STORY ID HERE: $_storyID');

    var documents = await FirebaseFirestore.instance.collection('stories').get();
    final String docName = documents.docs.elementAt(_storyID).id;
    await FirebaseFirestore.instance.collection('stories').doc(docName).update(updateInfo);

    Navigator.push(
        _context,
        MaterialPageRoute(
            builder: (context) => EditorView()));
  }

  void hideKeyboard() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }
}