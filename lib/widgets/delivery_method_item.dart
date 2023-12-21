import 'package:epigo_project/controllers/deliveryMethods_Controller.dart';
import 'package:epigo_project/models/delivery_methods.dart';
import 'package:epigo_project/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeliveryMethodItem extends StatelessWidget {
 // final DeliveryMethod deliveryMethod;

  const DeliveryMethodItem({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DeliveryController deliveryController = Get.put(DeliveryController());
      
     return Obx(
                  () => Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                        children: [
                          Expanded(
                            child: RadioListTile(
                              activeColor: Styles.orangeColor,
                              value: 1,
                              groupValue: deliveryController.deliveryMethod,
                              title: Image.asset(
                            'assets/images/aramexm.png',  
                            width: 24,  
                              height: 24,  
                              ),
                              subtitle: Text('1-2 jours',
                                  style: Styles.headLineStyle6),
                              onChanged: (value) =>
                                 deliveryController.deliveryMethod= value!,
                             
                            ),
                          ),
                             SizedBox(width: 8),
                          Expanded(
                            child: RadioListTile(
                              activeColor: Styles.orangeColor,
                              value: 2,
                              groupValue: deliveryController.deliveryMethod,
                              title:
                              Image.asset(
                             'assets/images/postem.png', 
                               width: 24,  
                                  height: 24,  
                                 ),
                              subtitle: Text('3-4 jours',
                                  style: Styles.headLineStyle6),
                              onChanged: (value) =>
                                 deliveryController.deliveryMethod = value!,
                                                  
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
             
  }
}