import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epigo_project/controllers/cart_controller.dart';
import 'package:epigo_project/models/product_model.dart';
import 'package:epigo_project/controllers/favorite_controller.dart';
import 'package:epigo_project/controllers/product_controller.dart';
import 'package:epigo_project/controllers/user_controller.dart';
import 'package:epigo_project/repository/user_repository.dart';
import 'package:epigo_project/screens/User/Product/product_detailsScreen.dart';
import 'package:epigo_project/styles/app_layout.dart';
import 'package:epigo_project/styles/styles.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:epigo_project/services/firestore_db.dart';

class ProductCard  extends StatefulWidget {
 ProductCard({
    Key? key,

    required this.product,
  }) : super(key: key);
  final Product product;
  
  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
  
  final ProductController productController = Get.put(ProductController());

 CartController cartController = Get.find();

FavoriteController favoriteController = Get.put(FavoriteController());
UserController userController =Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return InkWell(
      key: ValueKey('product_card_key'), // Ajoutez cette ligne
      onTap: () {
    _analytics.logEvent(name: 'button_details_clicked',
    parameters: {'screen':'home'},
    );
       Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => 
                ProductDetails(product: widget.product),
                ),
            );
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Styles.cardColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Center(
                  child: SizedBox(
                    height: AppLayout.getHeight(100),
                  width: double.infinity,
                    child: Hero(
                      transitionOnUserGestures: true,
                      tag: widget.product,
                      child: Image.network(widget.product.imageUrl),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    widget.product.discount != 0
                        ? Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              '${widget.product.discount} %',
                              style: Styles.headLineStyle4
                                  .copyWith(color: Colors.white),
                            ),
                          )
                        : const SizedBox(),
                     InkWell(
             onTap: () {
        favoriteController.addToFavorite(widget.product);
      },
      child: Obx(() => Container(
        width: 40, // Largeur du cercle
        height: 40, // Hauteur du cercle
        decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: Colors.white, // Couleur du cercle blanc
        ),
        child: Center(
      child: favoriteController.isFavorite(widget.product)
          ? Icon(
              Icons.favorite,
              color: Colors.red,
            )
          : Icon(
              Icons.favorite_border,
              color: Colors.black,
            ),
        ),
      )),
            ),
                  ],
                ),
              ],
            ),
            const Gap(10),
            Text(
              widget.product.title,
              style: Styles.textStyle,
              maxLines: 2,
            ),
            SizedBox(height: 4,),
            Text(widget.product.unit, style: Styles.headLineStyle5),
            SizedBox(height: 6,),
             Text(
  (widget.product.availableInStock && widget.product.stockQuantity != 0)
      ? 'En stock'
      : 'Rupture de stock',
  style: TextStyle(
    color: (widget.product.availableInStock && widget.product.stockQuantity != 0)
        ? Colors.green // Couleur pour "En stock"
        : Colors.red, // Couleur pour "Rupture de stock"
    fontWeight: FontWeight.bold,
  ),
),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      '${widget.product.price.toStringAsFixed(3)}\Dt',
                      style: Styles.headLineStyle6.copyWith(
                        decoration: widget.product.discount.isGreaterThan(0)
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        color: Styles.orangeColor,
                      ),
                    ),
                    const Gap(4),
                    Text(
                      widget.product.discount.isGreaterThan(0)
                          ? '${(widget.product.price - (widget.product.price * widget.product.discount / 100)).toStringAsFixed(3)}\Dt'
                          : '',
                      style: Styles.headLineStyle6,
                    ),
                  ],
                ),
       InkWell(
       key: ValueKey('add_to_cart_button'), // Ajoutez cette ligne
  onTap: () async {
    _analytics.logEvent(
      name: 'button_addToCart_clicked',
      parameters: {'screen': 'home'},
    );

    // Check if the product is in stock
    if (!widget.product.availableInStock || widget.product.stockQuantity == 0) {
      // Product is out of stock, show snackbar
      Get.snackbar(
        'Rupture de stock',
        'Désolé, ${widget.product.title} est en rupture de stock.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Styles.whiteColor,
        duration: const Duration(seconds: 3),
      );
    } else {
      // Check if the product is already in the cart
      bool isInCart = await cartController.isProductInCart(widget.product);

      if (isInCart) {
        // Product is already in the cart, show snackbar
        Get.snackbar(
          'Article déjà dans le panier',
          '${widget.product.title} existe déjà dans votre panier',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Styles.whiteColor,
          duration: const Duration(seconds: 3),
        );
      } else {
        // Product is not in the cart, add it
        cartController.addProduct(widget.product);
        Get.snackbar(
          'Ajouté au panier',
          '${widget.product.title} ajouté au panier',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Styles.whiteColor,
          duration: const Duration(seconds: 2),
        );

        // Optionally, you can show a different snackbar for successful addition
      }
    }
  },
  child: Container(
    height: AppLayout.getHeight(30),
    width: AppLayout.getWidth(30),
    decoration: BoxDecoration(
      color: Styles.orangeColor,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Icon(Icons.add, color: Colors.white),
  ),
),
              ],
            ),
          ],
        ),
      ),
    );
  }
}