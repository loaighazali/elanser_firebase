
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../controller/fb_auth_controller.dart';
import '../../helpers/helpers.dart';
import '../../widget/app_text_field.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> with Helpers {
  bool visiblePass = true;

  late TextEditingController _emailEditingController ;
  late TextEditingController _passwordEditingController ;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailEditingController = TextEditingController();
    _passwordEditingController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailEditingController.dispose();
    _passwordEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, '/registration_screen');
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Color(0xFF852530),
          ),
        ),
        title: const Text(
          'SIGN IN',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Color(0xFF717171),
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsetsDirectional.symmetric(horizontal: 25),
        child: ListView(
          children: [
            const Center(
              child: Image(
                image: AssetImage('assets/sign.png'),
              ),
            ),
            const SizedBox(
              height: 80,
            ),
            // Row(
            //   children: [
            //     Container(
            //       width: 70,
            //       height: 45,
            //       decoration: BoxDecoration(
            //         borderRadius: BorderRadiusDirectional.circular(5),
            //         border: Border.all(
            //           color: Colors.grey,
            //           width: 1,
            //         ),
            //       ),
            //       child: const Center(
            //         child: Text(
            //           '+972',
            //           style: TextStyle(fontSize: 14, color: Colors.black),
            //         ),
            //       ),
            //     ),
            //     const SizedBox(
            //       width: 10,
            //     ),
            //     Expanded(
            //       child: SizedBox(
            //         width: 248,
            //         height: 44,
            //         child: AppTextField(
            //           hint: 'Phone',
            //           inputType: TextInputType.phone,
            //           suffix:
            //               IconButton(onPressed: () {}, icon: const Icon(null)),
            //         ),
            //       ),
            //     )
            //   ],
            // ),

            SizedBox(
              width: 364,
              height: 44,
              child:  AppTextField(
                controller: _emailEditingController,
                hint: 'Email',
                inputType: TextInputType.emailAddress,
                suffix:
                IconButton(onPressed: () {}, icon: const Icon(null)),
              ),
            ),

            const SizedBox(
              height: 15,
            ),
            SizedBox(
              width: 364,
              height: 44,
              child: AppTextField(
                controller: _passwordEditingController,
                hint: 'Password',
                inputType: TextInputType.visiblePassword,
                obscure: visiblePass,
                suffix: IconButton(
                  onPressed: () {
                    setState(() {
                      visiblePass = !visiblePass;
                    });
                  },
                  icon: Icon(
                    visiblePass ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),

            const SizedBox(
              height: 45,
            ),
            ElevatedButton(
              onPressed: () async =>  await performSignIn(),
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsetsDirectional.zero,
                  backgroundColor: const Color(0xFF852530),
                  minimumSize: const Size(364, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                      side: const BorderSide(
                        color: Color(0xFF707070),
                        width: 1,
                      ))),
              child: const Text(
                'SignIn',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextButton(
              onPressed: () => Navigator.pushNamed(context, '/forgetpass_screen'),
              child:const Text(
                'Forget Password?',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFFDDAD38),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> performSignIn()async{

    if(checkData()){
      await login();
    }
  }

  bool checkData(){
    if(_emailEditingController.text.isNotEmpty && _passwordEditingController.text.isNotEmpty){

      return true;
    }
    showSnackBar(context: context, message: 'Enter Email And Password !' , error:  true);
    return false;

  }

  Future<void> login()async{
    bool status = await FbAuthController().signIn(context: context, email: _emailEditingController.text, password: _passwordEditingController.text);
    if(status){
      showSnackBar(context: context, message: 'SignIn is Successfully');
      Navigator.pushReplacementNamed(context, '/note_screen');
    }
  }

}
