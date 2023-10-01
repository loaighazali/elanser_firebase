import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elanser_firebase/model/note.dart';

class FbFireStoreController {
  final FirebaseFirestore _firebaseFireStore = FirebaseFirestore.instance;

  Future<bool> create({required Note note}) async {
    return  _firebaseFireStore
        .collection('Notes')
        .add(note.toMap())
        .then((value) => true)
        .catchError((error) {
          print(error);
          return false;
    });
  }

  Future<bool> delete({required String path}) async {
    return  _firebaseFireStore
        .collection('Notes')
        .doc(path)
        .delete()
        .then((value) => true)
        .catchError((error) => false);
  }

  Future<bool> update({required Note note}) async {
    return await _firebaseFireStore
        .collection('Notes')
        .doc(note.id)
        .update(note.toMap())
        .then((value) => true)
        .catchError((error) => false);
  }

  Stream<QuerySnapshot> read()async*{
    yield* _firebaseFireStore.collection('Notes').snapshots();
  }
}
