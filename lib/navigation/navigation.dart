import 'package:flutter/material.dart';

void main() {
  runApp(MainClass());
}

class MainClass extends StatelessWidget {

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
        body: Text('asdasdasd'),
      )
    );
  }

}

// class BottomNavigationBarExample extends StatefulWidget {
//
//   @override
//   _BottomNavigationBarExampleState createState() =>
//       _BottomNavigationBarExampleState();
// }
//
// class _BottomNavigationBarExampleState extends State<BottomNavigationBarExample> {
//   int _selectedIndex = 0;
//   static const TextStyle optionStyle =
//   TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
//   static List<Widget> _widgetOptions = <Widget>[
//     Text(
//       'Index 0: Создание',
//       style: optionStyle,
//     ),
//     AddMenu(),
//     // Text(
//     //   'Index 1: Генерация',
//     //   style: optionStyle,
//     // ),
//     // Settings(),
//     const Text(
//       'Index 2: Избранное',
//       style: optionStyle,
//     ),
//   ];
//
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: _widgetOptions.elementAt(_selectedIndex),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//               icon: Icon(Icons.add),
//               label: "Создание"
//           ),
//           BottomNavigationBarItem(
//               icon: Icon(Icons.account_tree),
//               label: "Генерация"
//           ),
//           BottomNavigationBarItem(
//               icon: Icon(Icons.star),
//               label: "Избранное"
//           ),
//         ],
//         currentIndex: _selectedIndex,
//         selectedItemColor: Colors.amber[800],
//         onTap: _onItemTapped,
//       ),
//     );
//   }
// }