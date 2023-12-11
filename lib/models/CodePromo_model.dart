
import 'package:cloud_firestore/cloud_firestore.dart';

class CouponModel {
late String id;
 late String title;
 late int discount;
  late String? expiryDate;
 late String description;
 late bool? isActivated;


 CouponModel({
      required this.id,
    required this.title,
    required this.discount,
       this.expiryDate,
    required this.description,
     this.isActivated,
  });


factory CouponModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    var data = doc.data() as Map<String, dynamic>;
    return CouponModel(
      id: doc.id,
      title: data['title'],
      discount: data['discount'],
      expiryDate: data['expiryDate'],
      description: data['description'],
      isActivated: data['isActivated'],
    );
  }
CouponModel.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    title = map['title'];
    discount = map['discount'];
    expiryDate = map['expiryDate'];
    description = map['description'];
    isActivated = map['isActivated'];
  
  }
  Map<String, dynamic> toMap() => {
        'id': id,
        'title':title,
        'discount':discount,
        'expiryDate':expiryDate,
        'description':description,
        'isActivated':isActivated,

        
      };


  }


  
