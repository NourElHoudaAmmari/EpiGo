


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    Key? key,
     required this.title,
      required this.icon,
     required this.onPress,
      this.endIcon = true,
       this.textColor,
  }):super(key :key);

  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap : onPress,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.black.withOpacity(0.1),
        ),
        child:  Icon(icon,color:Colors.black),
        ),
        title: Text(title,style: Theme.of(context).textTheme.bodyText1?.apply(color: textColor)),
        
        trailing: endIcon? Container(
          width: 40,
          height: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.white.withOpacity(0.1),
          ),
          child: const Icon(CupertinoIcons.arrowtriangle_right,color:Colors.grey),
        ):null
      );
  }
}
