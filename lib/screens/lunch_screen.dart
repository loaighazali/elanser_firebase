import 'dart:async';

import 'package:elanser_firebase/controller/fb_auth_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LunchScreen extends StatefulWidget {
  const LunchScreen({Key? key}) : super(key: key);

  @override
  State<LunchScreen> createState() => _LunchScreenState();
}

class _LunchScreenState extends State<LunchScreen> {

  late StreamSubscription _streamSubscription;

  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(
      Duration(seconds: 3), () async{

        _streamSubscription = await FbAuthController().checkUserState(listener: ({required bool status}) {
        String rout = status ? '/note_screen' :  '/registration_screen';
        Navigator.pushNamed(context, rout);
        },);


    } ,
    );
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _streamSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.teal.shade200, Colors.teal.shade900],
          ),
        ),
        child: Center(
          child: Text(
            'FireBase App',
            style: TextStyle(
                fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
