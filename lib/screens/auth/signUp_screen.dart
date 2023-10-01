
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../controller/fb_auth_controller.dart';
import '../../helpers/helpers.dart';
import '../../widget/app_text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> with Helpers {
  bool visiblePass = true;
  bool visibleConfPass = true;

 late TextEditingController _emailEditingController ;
 late TextEditingController _passwordEditingController ;
 late TextEditingController _confiermPasswordEditingController ;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailEditingController = TextEditingController();
    _passwordEditingController = TextEditingController();
    _confiermPasswordEditingController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailEditingController.dispose();
    _passwordEditingController.dispose();
    _confiermPasswordEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Color(0xFF852530),
            ),
          )),
      body: Padding(
        padding: const EdgeInsetsDirectional.symmetric(horizontal: 25),
        child: ListView(
          padding: const EdgeInsetsDirectional.symmetric(vertical: 25),
          children: [
            const Padding(
              padding: EdgeInsetsDirectional.only(bottom: 20),
              child: Center(
                child: Image(
                  image: AssetImage('assets/signin_img.png'),
                ),
              ),
            ),
            const Text(
              'Create a new account',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            const SizedBox(
              height: 15,
            ),
            const SizedBox(
              width: 10,
            ),
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
                controller:_passwordEditingController,
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
            SizedBox(
              width: 364,
              height: 44,
              child: AppTextField(
                controller: _confiermPasswordEditingController,
                hint: 'Confirm Password ',
                inputType: TextInputType.visiblePassword,
                obscure: visibleConfPass,
                suffix: IconButton(
                  onPressed: () {
                    setState(() {
                      visibleConfPass = !visibleConfPass;
                    });
                  },
                  icon: Icon(
                    visibleConfPass ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Center(
              child: TextButton(
                onPressed: () =>
                    Navigator.pushNamed(context, '/verification_screen'),
                child: const Text(
                  'Verification code?',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Center(
              child: TextButton(
                onPressed: () => Navigator.pushNamed(context, '/terms_screen'),
                child: const Text(
                  'Terms & Conditions',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async => await performSignIN() ,
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
                'SignUp',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Already have account?'),
                TextButton(
                  onPressed: () =>  Navigator.pushNamed(context, '/signIn_screen'),
                  child:const Text(
                    'SignIn',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.red,
                    ),
                  ),
                ),

              ],
            ),

            // Center(
            //   child: RichText(
            //     textAlign: TextAlign.center,
            //     text: TextSpan(
            //         text: 'Already have account? ',
            //         style:  TextStyle(fontSize: 14, color: Colors.black),
            //         children: [
            //           TextSpan(
            //               //recognizer: _gestureRecognizer,
            //               text: 'SignIn',
            //               style:
            //                    TextStyle(fontSize: 14, color: Colors.red)),
            //         ]),
            //   ),
            // ),
            const SizedBox(
              height: 10,
            ),
            const Center(
              child: Text(
                'OR',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.red,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                ),
                child: const Image(
                  image: AssetImage('assets/wts.png'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> performSignIN()async{

    if(checkData()){
      await register();
    }
  }

  bool checkData(){
    if(_emailEditingController.text.isNotEmpty && _passwordEditingController.text.isNotEmpty && _confiermPasswordEditingController.text.isNotEmpty){
      if(_passwordEditingController.text == _confiermPasswordEditingController.text){
        return true ;
      }
      else{
        showSnackBar(context: context, message: ' Password isNot Confierm !' , error: true);
      }
    }
    showSnackBar(context: context, message: 'Check Email And Password !' , error:  true);
    return false;

  }

  Future<void> register()async{
    bool status = await FbAuthController().register(context: context, email: _emailEditingController.text, password: _confiermPasswordEditingController.text);
    if(status){
      Navigator.pushNamed(context, '/signIn_screen');
    }
  }
}
