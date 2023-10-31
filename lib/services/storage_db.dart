import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';

class StorageDB {
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future<void> uploadImage(XFile image, String path) async {
    await storage.ref('$path/${image.name}').putFile(File(image.path));
  }

  Future<String> getImageUrl(String imageName, String path) async {
    return await storage.ref('$path/$imageName').getDownloadURL();
  }
}