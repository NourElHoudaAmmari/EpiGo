import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
final TextEditingController controller;
final String labText;
final TextInputType keyboardType;
CustomTextField({required this.controller,required this.keyboardType,required this.labText});

  @override
  Widget build(BuildContext context) {
     return TextField(
      keyboardType:keyboardType ,
      controller: controller,
      decoration: InputDecoration(
        labelText: labText,
      ),
    );
  }
}