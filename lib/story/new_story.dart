import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../adding/add_entity.dart';
import '../favorite/new_favorite.dart';
import 'edit_story.dart';

class NewStory extends StatefulWidget {
  const NewStory({super.key});

  @override
  State<NewStory> createState() => _CreateNewStory();
}

class _CreateNewStory extends State<NewStory> {
  final formKeyStory = GlobalKey<FormState>();
  late BuildContext _context;

  // Story's properties
  late int _storyID = 0;
  late String _storyTitle = '';
  late String _genre = '';
  late bool _isFavorite = false;
  late String _location;

  late String selectedGenre = 'Хоррор';
  late String selectedLocation = 'The Grand Canyon. The most huge landscape in North America. Also known as a popular site';

  Color primaryColor = const Color(0xffe36b44);
  Color backColor = const Color(0xffffe5b9);

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Scaffold(
      backgroundColor: backColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text(
          "Создание истории",
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

      body: Form(
        key: formKeyStory,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Padding(
              padding: const EdgeInsets.only(left: 8, top: 0, bottom: 32, right: 8),
              child: Text(
                'Новая история',
                style: TextStyle(
                    fontSize: 32.0,
                    fontFamily: 'Bajkal',
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                ),
              ),
            ),


            Padding(
              padding: const EdgeInsets.only(left: 32, top: 0, right: 32, bottom: 0),
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: "Название истории",
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
                    return "Слишком короткое название истории";
                  }
                  return null;
                },
              ),
            ),
            const Divider(
              indent: double.infinity,
            ),

            Text(
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

            Text(
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
                splashColor: const Color(0xff5191CA),
                color: primaryColor,
                height: 50.0,
                minWidth: 150.0,
                onPressed: submitStory,
                child: const Text(
                  "Создать историю",
                  style: TextStyle(
                      color: Colors.white
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

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

  void submitStory() {
    final form = formKeyStory.currentState;
    if (form!.validate()) {
      form.save();
      performStory();
    }
  }

  void performStory() async {
    hideKeyboard();

    var stories = FirebaseFirestore.instance.collection('stories');
    var storiesAsync = await stories.get();

    _storyID = storiesAsync.docs.length;
    _genre = selectedGenre;
    _location = selectedLocation;

    FirebaseFirestore.instance.collection('stories').add(
        {
          'id': _storyID,
          'title': _storyTitle,
          'genre': _genre,
          'isFavorite': _isFavorite,
          'location': _location
        }
    );

    Navigator.push(
        _context,
        MaterialPageRoute(
            builder: (context) => StoryView(_storyID, _storyTitle, _genre, _isFavorite, selectedLocation)));
  }

  void hideKeyboard() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }
}

class StoryView extends StatefulWidget {

  late int _storyID;
  late String _storyTitle = '';
  late String _genre = '';
  late bool _isFavorite = false;
  late String _location = '';

  StoryView(int id, String title, String genre, bool fav, String loc) {
    _storyID = id;
    _storyTitle = title;
    _genre = genre;
    _isFavorite = fav;
    _location = loc;
  }

  @override
  State<StoryView> createState() => _StoryView();
}

class _StoryView extends State<StoryView> {
  static const Color primaryColor = Color(0xffe36b44);
  static const Color backColor =  Color(0xffffe5b9);
  static const Color contrastColor = Color(0xff5191CA);

  // Story's properties
  late final int _storyID = widget._storyID;
  late String _storyTitle = widget._storyTitle;
  late String _genre = widget._genre;
  late bool _isFavorite = widget._isFavorite;
  late String _location = widget._location;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backColor,
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: const Text(
            "Созданная история",
            style: TextStyle(fontSize: 24.0),),
        ),

        body: Column(
          children: [
            const Divider(
              indent: double.infinity,
            ),

            Text(
              'История №$_storyID',
              style: const TextStyle(
                  fontSize: 24.0,
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
                const Flexible(
                  child: Text(
                    'Название:',
                    style: TextStyle(
                        fontSize: 24.0, color: primaryColor
                    ),
                  ),
                ),
                Flexible(
                  child: Text(
                    ' $_storyTitle',
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
                const Flexible(
                  child: Text(
                    'Жанр:',
                    style: TextStyle(fontSize: 24.0, color: primaryColor),
                  ),
                ),
                Flexible(
                  child: Text(
                    ' $_genre',
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
                const Flexible(
                  child: Text(
                    'Локация:',
                    style: TextStyle(fontSize: 24.0, color: primaryColor),
                  ),
                ),
                Flexible(
                  child: Text(
                    ' $_location',
                    style: const TextStyle(fontSize: 24.0),
                  ),
                ),
              ],
            ),

            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 48.0, top: 24.0, right: 48),
                  child: MaterialButton(
                    splashColor: contrastColor,
                    color: primaryColor,
                    height: 50.0,
                    minWidth: 72.0,
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
                          builder: (context) => StoryEditor(
                              _storyID, _storyTitle, _genre, _isFavorite, _location
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
                        'name': _storyTitle,
                        'type': 'История'
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
