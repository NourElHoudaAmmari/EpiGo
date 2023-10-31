import 'package:epigo_project/controllers/cart_controller.dart';
import 'package:epigo_project/controllers/category_controller.dart';
import 'package:epigo_project/controllers/user_controller.dart';
import 'package:epigo_project/screens/User/Product/product_card.dart';
import 'package:epigo_project/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryProduct extends StatelessWidget {
   CategoryProduct({super.key, required this.category});
  final String category;

  CategoryController categoryController = Get.find();
  UserController userController =Get.put(UserController());
  CartController cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    categoryController.getProductsByCategory(category);
    return Scaffold(
      body: Obx(
        (() => Padding(
              padding: const EdgeInsets.all(20),
              child: categoryController.products.isNotEmpty
                  ? GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      childAspectRatio: 1 / 1.3,
                      children: List.generate(
                        categoryController.products.length,
                        (index) {
                          return ProductCard(
                            product: categoryController.products[index],
                          );
                        },
                      ),
                    )
                  : Center(
                      child: Text('Aucun produit trouvé', style: Styles.headLineStyle3),
                    ),
            )),
      ),
    );
  }
}