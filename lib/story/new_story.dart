import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  late String _location;

  late String selectedGenre = 'Хоррор';
  late String selectedLocation = 'The Grand Canyon. The most huge landscape in North America';

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

            const Text(
              'Новая история',
              style: TextStyle(fontSize: 25.0, fontFamily: 'Bajkal'),
            ),


            SizedBox(
              child: TextFormField(
                decoration: const InputDecoration(labelText: "Название истории"),
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
    Navigator.push(
        _context,
        MaterialPageRoute(
            builder: (context) => StoryView(_storyID, _storyTitle, _genre, selectedLocation)));
  }

  void hideKeyboard() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }
}

class StoryView extends StatelessWidget {
  static const Color primaryColor = Color(0xffe36b44);
  static const Color backColor =  Color(0xffffe5b9);

  // Story's properties
  late int _storyID;
  late String _storyTitle = '';
  late String _genre = '';
  late String _location = '';

  StoryView(int storyID, String storyTitle, String genre, String location) {
    _storyID = storyID;
    _storyTitle = storyTitle;
    _genre = genre;
    _location = location;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backColor,
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: const Text(
            "Созданная история",
            style: TextStyle(fontSize: 25.0),),
        ),

        body: Column(
          children: [
            const Divider(
              indent: double.infinity,
            ),

            Text(
              'История №$_storyID',
              style: const TextStyle(
                  fontSize: 25.0,
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
          ],
        )

    );
  }

}
