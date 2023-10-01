import 'package:epigo_project/config/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';



class SignUpScreenTopImage extends StatelessWidget {
  const SignUpScreenTopImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "S'inscrire".toUpperCase(),
            style: GoogleFonts.caveat(
          textStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 35,
            color: marronColor.withOpacity(0.8), 
            fontStyle: FontStyle.italic,
          ),
        ),
        ),
        SizedBox(height: defaultPadding),
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
        SizedBox(height: defaultPadding),
      ],
    );
  }
}
