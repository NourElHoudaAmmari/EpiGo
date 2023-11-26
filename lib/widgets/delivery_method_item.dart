


import 'package:epigo_project/models/delivery_methods.dart';
import 'package:flutter/material.dart';

class DeliveryMethodItem extends StatelessWidget {
  final DeliveryMethod deliveryMethod;

  const DeliveryMethodItem({Key? key, required this.deliveryMethod}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.white12
      ),
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.network(
            deliveryMethod.imgUrl,
            fit: BoxFit.cover,
            height: 30,
          ),
        //  const SizedBox(height: 6.0),
          Text(
            '${deliveryMethod.days} jours',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ]),
      ),
    );
  }
}