
import 'dart:io';
import 'package:epigo_project/styles/app_layout.dart';
import 'package:epigo_project/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:unicons/unicons.dart';

class BuildImage extends StatelessWidget {
  final XFile? imagePath;
  final VoidCallback callback;
  final String? imageUrl;
  const BuildImage({
    Key? key,
    this.imagePath,
    required this.callback,
    this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () => callback(),
        child: Center(
          child: Container(
              height: AppLayout.getHeight(150),
              width: AppLayout.getWidth(150),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Styles.orangeColor,
              ),
              child: Center(
                child: imagePath == null
                    ? CircleAvatar(
                        backgroundImage: imageUrl == null
                            ? NetworkImage(
                                    'http://clipart-library.com/images/8TEbenojc.jpg')
                                as ImageProvider
                            : NetworkImage(imageUrl!) as ImageProvider,
                        radius: 150.0,
                      )
                    : CircleAvatar(
                        backgroundColor: Styles.orangeColor,
                        backgroundImage: FileImage(File(imagePath!.path)),
                        radius: 150.0,
                      ),
              )),
        ),
      ),
    );
  }
}
