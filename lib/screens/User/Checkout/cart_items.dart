

import 'package:flutter/material.dart';
import 'package:epigo_project/models/product_model.dart';
import 'package:epigo_project/styles/app_layout.dart';
import 'package:epigo_project/styles/styles.dart';
import 'package:gap/gap.dart';

class CartItems extends StatelessWidget {
  const CartItems({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(
       product.imageUrl,
        width: 60,
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
        product.title,
            style: TextStyle(
              color: Colors.grey[600],
            ),
          ),
          Text(
          product.unit,
            style: TextStyle(
              color: Colors.grey[600],
            ),
          ),
          Text(
            "${product.price} \Dt",
            
          ),
        ],
      ),
         subtitle: Text("Quantité: ${product.quantity}"),
    );
  }
}