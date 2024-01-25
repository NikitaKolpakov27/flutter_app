import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'new_story.dart';

class FireStory extends StatefulWidget {
  const FireStory({super.key});

  @override
  State<FireStory> createState() => _FireStoryState();
}

class _FireStoryState extends State<FireStory> {
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
          'Созданные истории',
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('stories').snapshots(),
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
                        builder: (context) => StoryView(
                            snapshot.data?.docs[index].get('id'),
                            snapshot.data?.docs[index].get('title'),
                            snapshot.data?.docs[index].get("genre"),
                            false,
                            snapshot.data?.docs[index].get("location"),
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
                        snapshot.data?.docs[index].get('title'),
                        style: const TextStyle(color: Color(0xffffffff)),
                      ),
                      subtitle: Text(
                        snapshot.data?.docs[index].get("genre"),
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