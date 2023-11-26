
import 'package:epigo_project/controllers/cart_controller.dart';
import 'package:epigo_project/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class CheckoutOrderDetails extends StatelessWidget {
  const CheckoutOrderDetails({super.key});

  @override
  Widget build(BuildContext context) {
      final CartController cartController = Get.put(CartController());
    return Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                       color: Color.fromARGB(255, 241, 240, 240),
                        borderRadius: BorderRadius.circular(15)),
                    child:Column(
                      children: [
                        
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Sous-Total: ', style: Styles.textStyle),
                         Text('${cartController.subTotal.toString()} DT',
                                style: Styles.headLineStyle4),
                          ],
                        ),
                        const Gap(10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Livraison: ', style: Styles.textStyle),
                             Text('${cartController.calculateShippingFee()} DT',
                                style: Styles.headLineStyle4),
                          ],
                        ),
                           Divider(color: Styles.primaryColor),
                            const Gap(10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Total: ', style: Styles.textStyle),
                     Text('${cartController.total.toString()} DT',
                                style: Styles.headLineStyle4),
                          ],
                        ),
                     
                        const Gap(10),
                      ],
                    ),
    );
  }
}