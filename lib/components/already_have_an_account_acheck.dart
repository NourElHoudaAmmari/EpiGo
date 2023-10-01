


import 'package:flutter/material.dart';

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool login;
  final Function? press;
  const AlreadyHaveAnAccountCheck({
    Key? key,
    this.login = true,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          login ? " Vous n’avez pas de compte ? " : "Vous avez déjà un compte? ",
          style: const TextStyle(color:Color.fromARGB(255, 62, 62, 62)),
        ),
        GestureDetector(
          onTap: press as void Function()?,
          child: Text(
            login ? "S`inscrire" : "Se Connecter",
            style: const TextStyle(
              color: Color.fromARGB(255, 117, 46, 4),
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}