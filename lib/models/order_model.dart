import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epigo_project/models/address_model.dart';
import 'package:epigo_project/models/product_model.dart';
import 'package:epigo_project/models/delivery_methods.dart';
import 'package:get/get.dart';

class Orders {
  late String? id;
  late List<Product>? cart;
   late Map<String, dynamic>? user;
  late double? total;
  late String? status;
  late String? date;
  late String? paymentMethod;
  late String? paymentStatus;
  late String? deliveryStatus;
  late List<Address>? deliveryAddress;
  late String? deliverymethods;

  Orders({
    this.id,
    this.cart,
    this.user,
    this.total,
    this.status,
    this.date,
    this.paymentMethod,
    this.paymentStatus,
    this.deliveryStatus,
    this.deliveryAddress,
    this.deliverymethods,
  });
  Orders.fromDocumentSnapshot({required DocumentSnapshot snapshot}) {
    id = snapshot.id;
    cart = snapshot['products'] == null
        ? []
        : snapshot['products'].map<Product>((e) => Product.fromMap(e)).toList();
    user = snapshot['user'];
    total = snapshot['total'];
    status = snapshot['status'];
    date = snapshot['date'];
    paymentMethod = snapshot['paymentMethod'];
    paymentStatus = snapshot['paymentStatus'];
    deliveryStatus = snapshot['deliveryStatus'];
    deliveryAddress = (snapshot['deliveryAddress'] as List<dynamic>?)
      ?.map<Address>((e) => Address.fromMap(e))
      .toList();
  
  }
  Map<String, dynamic> toMap() => {
        'id': id,
        'products': cart == null ? [] : cart!.map((e) => e.toMap()).toList(),
        'user': user,
        'total': total,
        'status': status,
        'date': date,
        'paymentMethod': paymentMethod,
        'paymentStatus': paymentStatus,
        'deliveryStatus': deliveryStatus,
        'deliveryAddress': deliveryAddress?.map((e) => e.toMap()).toList(),
        "deliverymethods": deliverymethods,

      };


}