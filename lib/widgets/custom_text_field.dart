import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({this.onChange, required this.hintText ,  this.obsecure = false});
  String? hintText;
  Function(String)? onChange;
  bool obsecure;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obsecure,
      validator: (data) {
        if (data!.isEmpty) {
          return 'Required';
        }
      },
      onChanged: onChange,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Colors.white,
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
