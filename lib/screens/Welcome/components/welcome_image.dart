import 'package:epigo_project/config/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeImage extends StatelessWidget {
  const WelcomeImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
 RichText(
  textAlign: TextAlign.center,
  text: TextSpan(
    children: [
      TextSpan(
        text: "Bienvenue à EpiGo",
        style: GoogleFonts.lobster(
          textStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 40,
            color: marronColor.withOpacity(0.8), 
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
      TextSpan(
        text: "\nLa fraîcheur à chaque instant",
        style: GoogleFonts.lobster(
          textStyle: TextStyle(
            color: beigeColor.withOpacity(0.8), 
            fontSize: 20,
          ),
        ),
      ),
    ],
  ),
),
        SizedBox(height: defaultPadding * 2),
        Row(
          children: [
            //Spacer(),
            Expanded(
              flex: 8,
              child:
             Image.asset(
            "assets/images/photo.png",
             ),
            ),
            Spacer(),
          ],
        ),
        SizedBox(height: defaultPadding * 2),
      ],
    );
  }
}