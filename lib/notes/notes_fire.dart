import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'new_note.dart';

class FireNote extends StatefulWidget {
  const FireNote({super.key});

  @override
  State<FireNote> createState() => _FireNoteState();
}

class _FireNoteState extends State<FireNote> {
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
          'Созданные заметки',
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('notes').orderBy('id', descending: false).snapshots(),
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
                        builder: (context) => NoteView(
                            snapshot.data?.docs[index].get('id'),
                            snapshot.data?.docs[index].get('note_title'),
                            snapshot.data?.docs[index].get('isFavorite'),
                            snapshot.data?.docs[index].get("note_text")
                        ),
                      ),
                    );
                  },
                  child: Card(
                    color: const Color(0xfff38557),
                    margin: const EdgeInsets.all(16),
                    child: ListTile(
                      leading: Text(
                        snapshot.data!.docs[index].get('id').toString(),
                        style: const TextStyle(color: Color(0xffffffff)),
                      ),
                      title: Text(
                        snapshot.data?.docs[index].get('note_title'),
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