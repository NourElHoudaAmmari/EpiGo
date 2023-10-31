import 'package:epigo_project/controllers/cart_controller.dart';
import 'package:epigo_project/controllers/product_controller.dart';
import 'package:epigo_project/controllers/user_controller.dart';
import 'package:epigo_project/screens/User/Product/product_card.dart';
import 'package:epigo_project/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class  AllProducts extends StatelessWidget {
 AllProducts({super.key});

  CartController cartController = Get.put(CartController());
  UserController userController =Get.put(UserController());
  ProductController productController = Get.find();
  //CartController cartController = Get.put(cartController());
  @override
  Widget build(BuildContext context) {
      return Scaffold(
      body: Obx(
        (() => Padding(
              padding: const EdgeInsets.only(
                  top: 10, left: 20, right: 20, bottom: 10),
              child: productController.products.isNotEmpty
                  ? GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      childAspectRatio: 1 / 1.3,
                      children: List.generate(
                        productController.products.length,
                        (index) {
                          return ProductCard(
                            product: productController.products[index],
                          );
                        },
                      ),
                    )
                  : Center(
                      child: Text('Aucun produit trouvé !', style: Styles.headLineStyle3),
                    ),
            )),
      ),
    );
  }
}
