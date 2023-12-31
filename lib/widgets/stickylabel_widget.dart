


import 'package:epigo_project/config/constants.dart';
import 'package:flutter/material.dart';

class  StickyLabel extends StatelessWidget {
    final String text;
  final Color? textColor;
  const  StickyLabel({super.key, required this.text, this.textColor});

  @override
  Widget build(BuildContext context) {
  return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(
        left: kDefaultPadding,
        top: kFixPadding,
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: 20.0,
        ),
      ),
    );
  }
}