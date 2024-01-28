import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_flutter/character/personality.dart';
import 'new_character.dart';

class FireChar extends StatefulWidget {
  const FireChar({super.key});

  @override
  State<FireChar> createState() => _FireHomeState();
}

class _FireHomeState extends State<FireChar> {
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
            'Созданные Персонажи',
          ),
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('perses')
              .where('user_id', isEqualTo: currentUserID)
              .orderBy('id', descending: false).snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const CircularProgressIndicator();
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
                          builder: (context) => CharView(
                              snapshot.data?.docs[index].get('id'),
                              snapshot.data?.docs[index].get('name'),
                              snapshot.data?.docs[index].get("lastname"),
                              snapshot.data?.docs[index].get("patronymic"),
                              false,
                              snapshot.data?.docs[index].get("sex"),
                              snapshot.data?.docs[index].get("age"),
                              Personality(
                                  snapshot.data?.docs[index].get('id'),
                                  snapshot.data?.docs[index].get("personality")["mbti"],
                                  snapshot.data?.docs[index].get("personality")["temper"]
                              )
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
                            snapshot.data?.docs[index].get('name') + " " + snapshot.data?.docs[index].get("lastname") + " " + snapshot.data?.docs[index].get("patronymic"),
                            style: const TextStyle(color: Color(0xffc5eafd)),
                        ),
                        subtitle: Text(
                            "Age: ${snapshot.data?.docs[index].get("age")}",
                            style: const TextStyle(color: Color(0xffffffff)),
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