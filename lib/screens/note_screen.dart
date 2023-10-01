import 'package:elanser_firebase/controller/fb_auth_controller.dart';
import 'package:elanser_firebase/helpers/helpers.dart';
import 'package:flutter/material.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({Key? key}) : super(key: key);

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen>with Helpers {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            onPressed: () async{
            await logout();
            },
            icon: Icon(Icons.logout),
          ),

          IconButton(
            onPressed: () {

            },
            icon: Icon(Icons.save),
          ),
        ],
      ),
    );
  }

  Future<void> logout()async{
    await FbAuthController().signOut();
    Navigator.pushReplacementNamed(context, '/signIn_screen');
    showSnackBar(context: context, message: 'Log Out is Succsuffly');
  }
}
