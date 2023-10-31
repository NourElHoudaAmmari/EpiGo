import 'package:epigo_project/config/constants.dart';
import 'package:flutter/material.dart';

import '../../Login/login_screen.dart';
import '../../Signup/signup_screen.dart';

class LoginAndSignupBtn extends StatelessWidget {
  const LoginAndSignupBtn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Hero(
          tag: "login_btn",
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return LoginScreen();
                  },
                ),
              );
            },
            style: ButtonStyle(
    backgroundColor: MaterialStateProperty.all(Colors.transparent),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0), // Définir le rayon de la bordure
        side: BorderSide(color: Colors.black), // Définir la couleur et l'épaisseur de la bordure
      ),
    ),
  ),
  child: Text(
    "Se Connecter".toUpperCase(),
    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black,),
  ),
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return SignUpScreen();
                },
              ),
            );
          },
        style: ButtonStyle(
    backgroundColor: MaterialStateProperty.all(primaryColor), // Couleur de fond
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0), // Rayon de la bordure
        side: BorderSide(color:primaryColor), // Couleur et épaisseur de la bordure
      ),
    ),
  ),
  child: Text(
    "S'inscrire".toUpperCase(),
    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
  ),
        ),
      ],
    );
  }
}