
import 'package:cloud_firestore/cloud_firestore.dart';

class Cart {
  late Map<String, dynamic>? product;

  late int? quantity;

  Cart({
    this.product,
    this.quantity,
  });
  Cart.fromDocumentSnapshot({required DocumentSnapshot snapshot}) {
    product = snapshot['cart'];
    quantity = snapshot['quantity'];
  }
  Map<String, dynamic> toMap() => {
        'product': product,
        'quantity': quantity,
      };
}