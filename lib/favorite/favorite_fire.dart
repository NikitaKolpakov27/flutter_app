import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FireFavorite extends StatefulWidget {
  const FireFavorite({super.key});

  @override
  State<FireFavorite> createState() => _FireFavState();
}

class _FireFavState extends State<FireFavorite> {
  static const Color backColor = Color(0xffffe5b9);
  final String currentUserID = FirebaseAuth.instance.currentUser!.uid;

  void getCurrentUserData() async {
    dynamic _colRef = FirebaseFirestore.instance.collection('users').where('login', isEqualTo: 'Nikita101');
    QuerySnapshot querySnapshot = await _colRef.get();
    final allData = querySnapshot.docs.map((e) => e.data()).toList();
    var a = FirebaseAuth.instance.currentUser!.email;
    // print('ALL DATA: $allData');
    print('CURRENT USER ID: $a');
  }

  // void getCurrentUserData() async {
  //   FirebaseFirestore.instance
  //       .collection('talks')
  //       .where("login", isEqualTo: "Nikita101")
  //       .snapshots()
  //       .listen((data) =>
  //       data.docs.forEach((doc) => print(doc['password'])));
  // }

  @override
  Widget build(BuildContext context) {
    getCurrentUserData();
    return Scaffold(
      backgroundColor: backColor,
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('favorites')
            .where('user_id', isEqualTo: currentUserID)
            .orderBy('id', descending: false)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color: const Color(0xfff38557),
                    margin: const EdgeInsets.only(left: 8, right: 8),
                    child: ListTile(
                      leading: Text(
                        snapshot.data!.docs[index].get('id').toString(),
                        style: const TextStyle(color: Color(0xffffffff)),
                      ),
                      title: Text(
                        snapshot.data?.docs[index].get('name'),
                        style: const TextStyle(color: Color(0xffffffff)),
                      ),
                      subtitle: Text(
                        snapshot.data?.docs[index].get("type"),
                        style: const TextStyle(color: Color(0xffc5eafd)),
                      ),
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}