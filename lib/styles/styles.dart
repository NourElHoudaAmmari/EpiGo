import 'package:flutter/material.dart';

class Styles {
  static Color primaryColor = Color(0xffd1ad17);
  static Color secondaryColor = Colors.blueGrey;
  static Color bgColor = Colors.grey.shade200;
  static Color whiteColor = Colors.grey.shade200;
  static Color redColor = Colors.redAccent;
  static Color beigeColor = Color(0xFFF2A961);
  static Color marronColor = Color(0xFF79301B);
  static Color  orangeColor = Color(0xFFFF7043);
  static Color  greenColor = Color(0xFF595224);
  static Color kPrimaryLightColor = Color(0xFFF5F5F5);
  static Color textColor = Colors.black87;
  static double defaultPadding = 16.0;

  static TextStyle textStyle =
      TextStyle(fontSize: 16, color: textColor, fontWeight: FontWeight.w500);

  static TextStyle headLineStyle1 =
      TextStyle(fontSize: 26, color: textColor, fontWeight: FontWeight.bold);

  static TextStyle headLineStyle2 =
      TextStyle(fontSize: 18, color: textColor, fontWeight: FontWeight.bold);

  static TextStyle headLineStyle3 = TextStyle(
      fontSize: 16, color: secondaryColor, fontWeight: FontWeight.bold);

  static TextStyle headLineStyle4 = TextStyle(
      fontSize: 14, color: secondaryColor, fontWeight: FontWeight.w500);



  static InputDecoration inputDecoration = InputDecoration(
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 1, color: Styles.secondaryColor),
    ),
  );
  static InputDecoration dropdownDecoration = InputDecoration(
    filled: true,
    fillColor: Colors.white,
    prefixIcon: Icon(Icons.functions_outlined, color: Styles.orangeColor),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide.none,
    ),
  );
}