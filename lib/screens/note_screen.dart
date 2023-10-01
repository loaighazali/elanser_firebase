import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elanser_firebase/controller/fb_auth_controller.dart';
import 'package:elanser_firebase/controller/fb_firestore_controller.dart';
import 'package:elanser_firebase/helpers/helpers.dart';
import 'package:elanser_firebase/model/note.dart';
import 'package:flutter/material.dart';

import 'create_screen.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({Key? key}) : super(key: key);

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> with Helpers {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            onPressed: () async {
              await logout();
            },
            icon: Icon(Icons.logout),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreateScreen(),
                  ));
            },
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FbFireStoreController().read(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
              List<QueryDocumentSnapshot> documents = snapshot.data!.docs;
              return ListView.builder(
                itemCount: documents.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.notes),
                    title: Text(documents[index].get('title')),
                    subtitle: Text(documents[index].get('details')),
                    trailing: IconButton(
                      onPressed: () async =>
                          await delete(path: documents[index].id),
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreateScreen(
                              title: 'update', note: mapNote(documents[index])),
                        ),
                      );
                    },
                  );
                },
              );
            } else {
              return const Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.warning,
                      size: 80,
                      color: Colors.grey,
                    ),
                    Text(
                      'No Data',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              );
            }
          }),
    );
  }

  Future<void> logout() async {
    await FbAuthController().signOut();
    Navigator.pushReplacementNamed(context, '/signIn_screen');
    showSnackBar(context: context, message: 'Log Out is Succsuffly');
  }

  Future<void> delete({required String path}) async {
    bool deleted = await FbFireStoreController().delete(path: path);
    String message = deleted ? 'Deleted is successfully' : 'Deleted is Field';
    showSnackBar(context: context, message: message, error: !deleted);
  }

  Note mapNote(QueryDocumentSnapshot queryDocumentSnapshot) {
    Note note = Note();
    note.id = queryDocumentSnapshot.id;
    note.title = queryDocumentSnapshot.get('title');
    note.details = queryDocumentSnapshot.get('details');
    return note;
  }
}
