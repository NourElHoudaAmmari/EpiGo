


import 'package:epigo_project/models/CodePromo_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PromoCodeRow extends StatelessWidget {
  final CouponModel  couponcode;
  const PromoCodeRow({super.key, required this.couponcode });

  @override
  Widget build(BuildContext context) {
    
    return InkWell(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
      color: Colors.grey.withOpacity(0.5), // Couleur de la bordure
      width: 1.0, // Largeur de la bordure
    ),
            borderRadius: BorderRadius.circular(5),
            boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 2)]),
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                           couponcode.title,
                            style: TextStyle(
                                color: Color(0xff030303),
                                fontSize: 14,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                              color: Color(0xff828282).withOpacity(0.2),
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(
                           couponcode.title,
                            style: TextStyle(
                                color: Color(0xff53B175),
                                fontSize: 15,
                                fontWeight: FontWeight.w700),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                   couponcode.description,
                      style: TextStyle(
                          color: Color(0xff828282),
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
    
                    const SizedBox(
                      height: 6,
                    ),
    
                    Row(
                      children: [
                        Text(
                         "Expiry Date:",
                          style: TextStyle(
                              color: Color(0xff53B175),
                              fontSize: 14,
                              fontWeight: FontWeight.w700),
                        ),
    
                        const SizedBox(width: 8,),
                        Text(
                         couponcode.expiryDate!= null
            ? DateFormat('dd-MM-yyyy HH:mm:ss').format(DateTime.parse(couponcode.expiryDate!))
            : 'Date not available',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    )
                   
                  ],
                ),
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}