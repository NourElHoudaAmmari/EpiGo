import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epigo_project/models/order_model.dart';
import 'package:epigo_project/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';


class SingleOrderComponent extends StatelessWidget {
  final Orders ordres;


  SingleOrderComponent({required this.ordres,});

  @override
  Widget build(BuildContext context) {
  
   return Padding(
      padding: EdgeInsets.symmetric(vertical: 29),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 16,
            ),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Styles.kTextColor.withOpacity(0.12),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Text.rich(
              TextSpan(
                text: "Commandé le:  ",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
                children: [
                  TextSpan(
                    text:ordres.date != null
            ? DateFormat('dd-MM-yyyy HH:mm:ss').format(DateTime.parse(ordres.date!))
            : 'Date not available',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 4,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              border: Border.symmetric(
                vertical: BorderSide(
                  color: Styles.kTextColor.withOpacity(0.15),
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Text(
                'Methode de paiement : ${ordres.paymentMethod}',
                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
              ),
  
      SizedBox(height: 13,),        
Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: ordres.deliveryAddress!.map((address) {
    String fullAddress = 'Livrée à : ${address.address}, ${address.codePostale}, ${address.region}';
    return Text(
      fullAddress,
      style: TextStyle(fontWeight: FontWeight.w600,color: Styles.secondaryColor),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }).toList(),
),        
                SizedBox(height: 13),
            Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                      Text(
                      'Total: ${ordres.total?.toStringAsFixed(3)} Dt',
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                    ),
                    Text(
                      ' ${ordres.status}',
                      style: TextStyle(fontWeight: FontWeight.w600, color: Color.fromARGB(255, 220, 140, 20)),
                    ),
                  
                  ],
                ),
                    SizedBox(height: 6),
              ExpansionTile(
  title: Text('Articles commandés:', style: TextStyle(fontWeight: FontWeight.w500)),
  children: ordres.cart?.map((product) {
    return ListTile(
      leading: Image.network(
        product.imageUrl ?? '',
        height: 40,
        width: 40,
        fit: BoxFit.cover,
      ),
      title: Text(product.title ?? ''),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${product.quantity} x ${product.title}', style: TextStyle(color: Colors.grey)),
         // Text('Frais de livraison: ${ordres.cart?.}', style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }).toList() ?? [],
),
               
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 2,
            ),
            decoration: BoxDecoration(
              color: Styles.primaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
           
          ),
        ],
      ),
    );
  }
}