
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epigo_project/models/CodePromo_model.dart';
import 'package:flutter/cupertino.dart';

/*class CouponCode with ChangeNotifier{
 late bool expired ;
  late DocumentSnapshot document;
  Future<DocumentSnapshot> getCouponDetails(title, id) async {
    DocumentSnapshot document =
        await FirebaseFirestore.instance.collection('coupons').doc(title).get();
    if (document.exists) {
      var data = document.data();
      if (data != null && data['title'] == title) {
        checkExpiry(document);
      }
    }
    return document;
  }

  void checkExpiry(DocumentSnapshot document) {
    var expiryDate = document.data()?['expiryDate']?.toDate();
    if (expiryDate != null) {
      DateTime date = expiryDate;
      var dateDiff = date.difference(DateTime.now()).inDays;

  }
  }
}*/