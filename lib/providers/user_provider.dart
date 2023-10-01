
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epigo_project/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  void addUserData({
   User? currentUser,
   String? id,
    String? name,
    String? email,
    String? phone,
    String? address,
    String? password,
    String? profilePick,
    bool? isBlocked,
 
  }) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(currentUser?.uid)
        .set(
      {
        "userName": name,
        "userEmail": email,
           "phoneNo" : phone ,
            "address"  :address,
            "password"   : password,
            "userImage": profilePick,
            "isBlocked":isBlocked,
           "userUid": currentUser?.uid,
    
      

      },
    );
  }

  late UserModel currentData;

  void getUserData() async {
    UserModel userModel;
    var value = await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get();
    if (value.exists) {
      userModel = UserModel(
       name: value.get("userName"),
       email: value.get("userEmail"),
       phone: value.get("phoneNo"),
       address: value.get("address"),
       password: value.get("password"),
        profilePick: value.get("userImage"),
        isBlocked: value.get("isBlocked"),
        id: value.get("userUid"),
      );
      currentData = userModel;
      notifyListeners();
    }
  }

  UserModel get currentUserData {
    return currentData;
  }
}