import 'package:epigo_project/config/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreenTopImage extends StatelessWidget {
  const LoginScreenTopImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Se Connecter".toUpperCase(),
            style: GoogleFonts.caveat(
          textStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 35,
            color: marronColor.withOpacity(0.8), 
            fontStyle: FontStyle.italic,
          ),
        ),
        ),
        SizedBox(height: defaultPadding * 2),
        Row(
          children: [
            const Spacer(),
            Expanded(
              flex: 7,
              child: Image.asset(
            "assets/images/photo.png",
             ),
            ),
            const Spacer(),
          ],
        ),
        SizedBox(height: defaultPadding * 2),
      ],
    );
  }
}