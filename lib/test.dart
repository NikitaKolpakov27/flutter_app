// Define a widget for each page
import 'package:flutter/material.dart';

void main() {
  runApp(TestClass());
}

class TestClass extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text(
              "Тест навигации",
              style: TextStyle(
                  fontSize: 22.0,
                  fontStyle: FontStyle.italic,
                  color: Colors.white
              ),
            ),
          ),
          bottomNavigationBar: MyHomePage(),
          body: Text('asdasdasd'),
        )
    );
  }

}

class HomeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Home Page'));
  }
}

class BusinessWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Business Page'));
  }
}

class SchoolWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('School Page'));
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

// Update the _MyHomePageState class
class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    HomeWidget(),
    BusinessWidget(),
    SchoolWidget(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bottom Navigation Bar Tutorial'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Business',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'School',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}