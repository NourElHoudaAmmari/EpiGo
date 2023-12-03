import 'package:flutter/material.dart';

class Styles {
   //light mode
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
  static Color cardColor = Color.fromARGB(255, 241, 240, 240);
  static Color kTextColor = Color(0xFF757575);
  static double defaultPadding = 16.0;
  // dark mode
  static Color primaryColorDark = Color(0xFF956B0E); 
static Color secondaryColorDark = Colors.blueGrey.shade800; 
static Color bgColorDark = Colors.grey.shade800; 
static Color whiteColorDark = Colors.grey.shade800; 
static Color redColorDark = Colors.red; 
static Color beigeColorDark = Color(0xFFD39A58);
static Color marronColorDark = Color(0xFF4A200F); 
static Color orangeColorDark = Color(0xFFFF7043);
static Color greenColorDark = Color(0xFF443D20); 
static Color kPrimaryLightColorDark = Color(0xFFE6E6E6); 
static Color textColorDark = Colors.white; 
static Color cardColorDark = Color.fromARGB(255, 51, 51, 51); 
    static const Color lightScaffoldColor = Colors.white;
  static const Color lightPrimary = Color(0xffd1ad17);
  static const Color lightCardColor = Color.fromARGB(106, 250, 250, 250);
  static const Color darkScaffoldColor = Color.fromARGB(255, 9, 3, 27);
  static const Color darkPrimary = Color.fromARGB(255, 94, 75, 236);




  static TextStyle textStyle =
      TextStyle(fontSize: 16, color: textColor, fontWeight: FontWeight.w500);

  static TextStyle headLineStyle1 =
      TextStyle(fontSize: 26, color: textColor, fontWeight: FontWeight.bold);

  static TextStyle headLineStyle2 =
      TextStyle(fontSize: 18, color: textColor, fontWeight: FontWeight.bold);

  static TextStyle headLineStyle3 = TextStyle(
      fontSize: 16, color: secondaryColor, fontWeight: FontWeight.bold);

  static TextStyle headLineStyle4 = TextStyle(
      fontSize: 15, color: textColor, fontWeight: FontWeight.w500);

  static TextStyle headLineStyle5 = TextStyle(
      fontSize: 14, color: secondaryColor, fontWeight: FontWeight.w500);

      static TextStyle headLineStyle6 = TextStyle(
      fontSize: 13, color: textColor, fontWeight: FontWeight.w700);

  static ThemeData themeData(
      {required bool isDarkTheme, required BuildContext context}) {
    return ThemeData(
        scaffoldBackgroundColor: isDarkTheme
            ? Styles.darkScaffoldColor
            : Styles.lightScaffoldColor,
        cardColor: isDarkTheme
            ? const Color.fromARGB(255, 13, 6, 37)
            : Styles.lightCardColor,
        brightness: isDarkTheme ? Brightness.dark : Brightness.light);
  }

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