
import 'package:epigo_project/controllers/adressController.dart';
import 'package:epigo_project/models/address_model.dart';
import 'package:epigo_project/screens/User/Adresses/List_adresses.dart';
import 'package:epigo_project/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShippingAddressComponent extends StatelessWidget {
     final Address adress;
 ShippingAddressComponent({super.key, required this.adress});

      final AdressController adressController = Get.put(AdressController());
  @override
  Widget build(BuildContext context) {
  return Card(
    color: const Color.fromARGB(255, 236, 236, 236),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                 adress.name,
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                InkWell(
                  onTap: () =>Get.to(()=> AdressList()),
                  child: Text(
                    'Changer',
                    style: Theme.of(context).textTheme.button!.copyWith(
                          color: Colors.redAccent,
                        ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
         
            Text(
              "${adress.address}, ${adress.region}, ${adress.pays},${adress.codePostale} ",
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ],
        ),
      ),
    );
  }
}