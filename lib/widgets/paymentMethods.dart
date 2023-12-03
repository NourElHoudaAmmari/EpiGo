import 'package:epigo_project/controllers/paymentController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unicons/unicons.dart';

import '../styles/styles.dart';

class PaymentComponentWidget extends StatefulWidget {
  const PaymentComponentWidget({super.key});

  @override
  State<PaymentComponentWidget> createState() => _PaymentComponentWidgetState();
}

class _PaymentComponentWidgetState extends State<PaymentComponentWidget> {
  @override
  Widget build(BuildContext context) {
           PaymentController paymentController = Get.put(PaymentController());
    return    Obx(
                  () => Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 236, 236, 236),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: [
                        RadioListTile(
                          activeColor: Styles.orangeColor,
                          value: 1,
                          groupValue: paymentController.payment,
                          title: Text('Payer par carte', style: Styles.textStyle),
                          subtitle: Text('Visa ou master card',
                              style: Styles.headLineStyle5),
                          onChanged: (value) =>
                              paymentController.payment = value!,
                          secondary: Icon(UniconsLine.credit_card,
                              color: Styles.secondaryColor),
                        ),
                        RadioListTile(
                          activeColor: Styles.orangeColor,
                          value: 2,
                          groupValue: paymentController.payment,
                          title:
                              Text('Paiement à la livraison', style: Styles.textStyle),
                          subtitle: Text('Payer en espèces à la maison',
                              style: Styles.headLineStyle5),
                          onChanged: (value) =>
                              paymentController.payment = value!,
                          secondary: Icon(UniconsLine.bill,
                              color: Styles.secondaryColor),
                        ),
                      ],
                    ),
                  ),
                );
  }
}