import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class DeliveryMethod {
  final String id;
  final String name;
  final String days;
  final String imgUrl;
 

  DeliveryMethod({
    required this.id,
    required this.name,
    required this.days,
    required this.imgUrl,
  });

  static DeliveryMethod fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return DeliveryMethod(
      id: snapshot.id,
      name: data['name'] ?? '',
      days: data['days'] ?? '',
      imgUrl: data['imgUrl'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'id': id});
    result.addAll({'name': name});
    result.addAll({'days': days});
    result.addAll({'imgUrl': imgUrl});
    return result;
  }

  factory DeliveryMethod.fromMap(Map<String, dynamic> map, String documentId) {
    return DeliveryMethod(
      id: documentId,
      name: map['name'] ?? '',
      days: map['days'] ?? '',
      imgUrl: map['imgUrl'] ?? '',
    );
  }
}