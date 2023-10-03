import 'package:elanser_firebase/bloc/bloc/storage_bloc.dart';
import 'package:elanser_firebase/bloc/states/storage_states.dart';
import 'package:elanser_firebase/screens/auth/SignIn_screen.dart';
import 'package:elanser_firebase/screens/auth/registration_screen.dart';
import 'package:elanser_firebase/screens/auth/signUp_screen.dart';
import 'package:elanser_firebase/screens/create_screen.dart';
import 'package:elanser_firebase/screens/images/images_screen.dart';
import 'package:elanser_firebase/screens/images/upload_image_screen.dart';
import 'package:elanser_firebase/screens/lunch_screen.dart';
import 'package:elanser_firebase/screens/note_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<StorageBloc>(
          create: (context) => StorageBloc(LoadingState()),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,

        initialRoute: '/lunch_screen',
        routes: {
          '/lunch_screen' : (context) =>const LunchScreen(),
          '/registration_screen' : (context) =>const RegistrationScreen(),
          '/signIn_screen' : (context) =>const SignInScreen(),
          '/signUp_screen' : (context) =>const SignUpScreen(),
          '/note_screen' : (context) =>const NoteScreen(),
          '/create_screen' : (context) =>const CreateScreen(),
          '/images_screen' : (context) =>const ImageScreen(),
          '/upload_image_screen' : (context) =>const UploadImageScreen(),

        },
      ),
    );
  }
}

