import 'package:epigo_project/services/storage_db.dart';
import 'package:epigo_project/styles/styles.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class ImageController extends GetxController {
  final _imagePath = ''.obs;
  String get imagePath => _imagePath.value;
  set imagePath(String value) => _imagePath.value = value;

  final _image = Rxn<XFile>();
  XFile? get image => _image.value;
  set image(XFile? value) => _image.value = value;

  final _imagePicker = ImagePicker();

  Future<void> pickImage() async {
    try {
      final pickedFile =
          await _imagePicker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        image = pickedFile;
        // imagePath = pickedFile.path;
        await StorageDB().uploadImage(image!, 'users_images');
        imagePath = await StorageDB().getImageUrl(image!.name, 'users_images');
      } else {
        Get.snackbar(
          'Aucune image sélectionnée',
          'Veuillez sélectionner une image',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Styles.orangeColor,
          colorText: Styles.whiteColor,
          duration: const Duration(seconds: 1),
        );
      }
    } catch (e) {
      Get.snackbar(
        'Erreur',
        e.toString(),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Styles.orangeColor,
        colorText: Styles.whiteColor,
        duration: const Duration(seconds: 1),
      );
    }
  }
}