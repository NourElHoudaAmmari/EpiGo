import 'package:epigo_project/controllers/cart_controller.dart';
import 'package:epigo_project/controllers/favorite_controller.dart';
import 'package:epigo_project/controllers/product_controller.dart';
import 'package:epigo_project/controllers/search_controller.dart';
import 'package:epigo_project/controllers/user_controller.dart';
import 'package:epigo_project/screens/Product/product_card.dart';
import 'package:epigo_project/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchProduct extends StatelessWidget {
   SearchProduct({super.key});
  SearchController searchController = Get.find();
    ProductController productController = Get.put(ProductController());
 CartController cartController = Get.find();
  FavoriteController favoriteController = Get.put(FavoriteController());
UserController userController =Get.put(UserController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        (() => Padding(
              padding: const EdgeInsets.all(20),
              child: searchController.products.isNotEmpty
                  ? GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      childAspectRatio: 1 / 1.3,
                      children: List.generate(
                        searchController.products.length,
                        (index) {
                          return ProductCard(
                            product: searchController.products[index],
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