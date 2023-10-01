

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epigo_project/models/user_model.dart';
import 'package:epigo_project/screens/Login/login_screen.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as Path;
class UserRepository extends GetxController{
   var isProfileInformationLoading = false.obs;
  static UserRepository get instance=>Get.find();

  final _db = FirebaseFirestore.instance;

//store User in Firestore
  createUser(UserModel user) async {
  await _db.collection("users").add(user.toJson()).whenComplete(() {
    Get.to(() => LoginScreen());
    print("succefully redirected"); // navigate to login screen
    Get.snackbar(
      "Succès",
      "Compte créé avec succès",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green.withOpacity(0.1),
      colorText: Colors.green,
    );
  }).catchError((error, stackTrace) {
    Get.snackbar("Erreur", "Quelque chose s'est mal passé, essaie encore",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red);
    print("Error - $error");
  });
}

//Fetch all users or user details
Future <UserModel> getUserDetails(String email)async{
  final snapshot = await _db.collection("users").where("email",isEqualTo: email).get();
  final userData = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;
  return userData;
}

Future <List<UserModel>> allUser()async{
  final snapshot = await _db.collection("users").get();
  final userData = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList();
  return userData;
}
Future<void> updateUserRecord(UserModel user)async{
  await _db.collection("users").doc(user.id).update(user.toJson());


   
}
   Future<String> uploadImageToFirebaseStorage(File image) async {
    String imageUrl = '';
    String fileName = Path.basename(image.path);

    var reference =
        FirebaseStorage.instance.ref().child('profileImages/$fileName');
    UploadTask uploadTask = reference.putFile(image);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    await taskSnapshot.ref.getDownloadURL().then((value) {
      imageUrl = value;
    }).catchError((e) {
      print("Error happen $e");
    });

    return imageUrl;
  }
  


}