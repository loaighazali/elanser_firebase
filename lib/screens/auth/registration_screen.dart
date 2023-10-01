import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           const Image(
              image: AssetImage('assets/lunch_img.png'),
            ),
           const Text(
              'Learn More',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
           const Text(
              'Lorem ipsum dolor sit amet, consetetur sadipscing elitr,\nsed diam nonumy eirmod tempor invidunt ut labore et\ndolore magna aliquyam erat, sed diam voluptua.\n' +
                  'Lorem ipsum dolor sit amet, consetetur sadipscing elitr,\nsed diam nonumy eirmod tempor invidunt ut labore et\ndolore magna aliquyam erat, sed diam voluptua.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.blueGrey,
              ),
            ),

           const SizedBox(height: 129,),

            Padding(
              padding: const EdgeInsetsDirectional.symmetric(horizontal: 25),
              child: ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/signIn_screen'),
                style: ElevatedButton.styleFrom(
                    backgroundColor:const Color(0xFF852530),
                    minimumSize:const Size(327, 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                        side:const BorderSide(
                          color: Color(0xFF707070),
                          width: 1,
                        )
                    )
                ),
                child: const Text(
                  'SignIn',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 6,),


            Padding(
              padding: const EdgeInsetsDirectional.symmetric(horizontal: 25),
              child: ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/signUp_screen'),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    minimumSize:const Size(327, 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                        side:const BorderSide(
                          color: Color(0xFF852530),
                          width: 1,
                        )
                    )
                ),
                child: const Text(
                  'Signup',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
