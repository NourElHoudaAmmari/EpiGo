import 'package:epigo_project/controllers/theme_controller.dart';
import 'package:epigo_project/styles/styles.dart';
import 'package:epigo_project/widgets/subtitle_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeController themeController = Get.put(ThemeController());
    return Scaffold(
      appBar: AppBar(
    title:  Text(
          "Réglages",
          style: TextStyle(color: Colors.black, fontSize: 20,fontWeight: FontWeight.bold),
        ),
        elevation: 0.0,
        backgroundColor:Styles.primaryColor,
        leading: IconButton(
          icon: Icon(CupertinoIcons.arrowtriangle_left,color: Colors.black,), onPressed: () {  Navigator.of(context).pop();},
        ),
      ),
      body:  SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             SwitchListTile(
                    secondary: Image.asset(
                     'assets/images/imagePath.png',
                      height: 34,
                    ),
                    title: Text(themeController.getIsDarkTheme
                        ? "Mode Sombre"
                        : "Mode Lumière"),
                    value: themeController.getIsDarkTheme,
                    onChanged: (value) {
                      themeController.setDarkTheme(themeValue: value);
                    },
                  ),
          ],
      ),
      ),
      
    );
  }
  
}
class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    required this.imagePath,
    required this.text,
    required this.function,
  });
  final String imagePath, text;
  final VoidCallback function;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        function();
      },
      title: SubtitleTextWidget(label: text),
      leading: Image.asset(
        imagePath,
        height: 34,
      ),
      trailing: const Icon(IconlyLight.arrowRight2),
    );
  }
}
