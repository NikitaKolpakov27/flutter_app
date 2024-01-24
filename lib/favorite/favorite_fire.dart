import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FireFavorite extends StatefulWidget {
  const FireFavorite({super.key});

  @override
  State<FireFavorite> createState() => _FireFavState();
}

class _FireFavState extends State<FireFavorite> {
  static const Color primaryColor = Color(0xffe36b44);
  static const Color backColor = Color(0xffffe5b9);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        title: const Text(
          'Избранное',
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('favorites').orderBy('id', descending: false).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }
          return ListView.builder(
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color: const Color(0xfff38557),
                    margin: const EdgeInsets.all(8),
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