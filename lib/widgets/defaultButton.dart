


import 'package:epigo_project/Utils/size_config.dart';
import 'package:flutter/material.dart';

import '../config/constants.dart';

class DefaultButton extends StatelessWidget {
    final String text;
  final VoidCallback press;

  const DefaultButton({super.key, required this.text, required this.press,});

  @override
  Widget build(BuildContext context) {
   return SizedBox(
      width: double.infinity,
      height: getProportionateScreenHeight(56),
      child: ElevatedButton(
     style: ButtonStyle(
    backgroundColor: MaterialStateProperty.all(primaryColor), // Couleur de fond
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0), // Rayon de la bordure
        side: BorderSide(color:primaryColor), // Couleur et épaisseur de la bordure
      ),
    ),
  ),
        onPressed: press,
        child: Text(
          text,
          style: TextStyle(
            fontSize: getProportionateScreenWidth(18),
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}