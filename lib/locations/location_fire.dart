import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'new_location.dart';

class FireLocation extends StatefulWidget {
  const FireLocation({super.key});

  @override
  State<FireLocation> createState() => _FireLocState();
}

class _FireLocState extends State<FireLocation> {
  static const Color primaryColor = Color(0xffe36b44);
  static const Color backColor = Color(0xffffe5b9);
  final String currentUserID = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        title: const Text(
          'Созданные локации',
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('locations')
            .where('user_id', isEqualTo: currentUserID)
            .orderBy('id', descending: false).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (context, index) {
                return InkWell(
                  // overlayColor: MaterialStateProperty.all(Color(0xff5191CA)),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LocView(
                            snapshot.data?.docs[index].get('id'),
                            snapshot.data?.docs[index].get('location_name'),
                            false,
                            snapshot.data?.docs[index].get("description")
                        ),
                      ),
                    );
                  },
                  child: Card(
                    color: const Color(0xfff38557),
                    margin: const EdgeInsets.all(20),
                    child: ListTile(
                      leading: Text(
                        snapshot.data!.docs[index].get('id').toString(),
                        style: const TextStyle(color: Color(0xffffffff)),
                      ),
                      title: Text(
                        snapshot.data?.docs[index].get('location_name'),
                        style: const TextStyle(color: Color(0xffffffff)),
                      ),
                      subtitle: Text(
                        snapshot.data?.docs[index].get("description"),
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