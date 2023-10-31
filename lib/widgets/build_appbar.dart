
import 'package:epigo_project/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unicons/unicons.dart';

class BuildAppBar extends StatelessWidget {
  const BuildAppBar({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () => Get.back(),
          child: Container(
            child: Icon(
              UniconsLine.angle_left_b,
              color: Styles.primaryColor,
            ),
          ),
        ),
        Text(
          title,
          style: Styles.headLineStyle2,
        ),
        InkWell(
          onTap: () {},
          child: Icon(
            UniconsLine.angle_left_b,
            color: Colors.transparent,
          ),
        ),
      ],
    );
  }
}