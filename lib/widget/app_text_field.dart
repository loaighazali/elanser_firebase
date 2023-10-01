import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.controller,
    required this.hint,
     this.inputType = TextInputType.text,
    this.obscure = false ,
    required this.suffix,
  });

  final String hint ;
  final TextInputType inputType  ;
  final bool obscure ;
  final IconButton suffix  ;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller:controller ,
      keyboardType: inputType,
      textAlignVertical: TextAlignVertical.bottom,
      obscureText: obscure,
      style:const TextStyle(
        fontSize: 14,
        color: Colors.black,
      ),
      decoration: InputDecoration(
        hintText: hint,
        suffixIcon: suffix,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: Colors.grey,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: Colors.blueAccent,
            width: 1,
          ),
        ),
      ),
    );
  }
}
