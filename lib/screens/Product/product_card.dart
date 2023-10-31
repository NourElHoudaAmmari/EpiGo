import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epigo_project/controllers/cart_controller.dart';
import 'package:epigo_project/models/product_model.dart';
import 'package:epigo_project/controllers/favorite_controller.dart';
import 'package:epigo_project/controllers/product_controller.dart';
import 'package:epigo_project/controllers/user_controller.dart';
import 'package:epigo_project/repository/user_repository.dart';
import 'package:epigo_project/screens/Product/product_detailsScreen.dart';
import 'package:epigo_project/styles/app_layout.dart';
import 'package:epigo_project/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

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
  
  final ProductController productController = Get.put(ProductController());

 CartController cartController = Get.find();

FavoriteController favoriteController = Get.put(FavoriteController());
UserController userController =Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => ProductDetails(product: widget.product));
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 241, 240, 240),
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
                    width: AppLayout.getHeight(200),
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
            Text(widget.product.unit, style: Styles.headLineStyle4),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      '${widget.product.price.toString()}\Dt',
                      style: Styles.headLineStyle4.copyWith(
                        decoration: widget.product.discount.isGreaterThan(0)
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        color: Styles.orangeColor,
                      ),
                    ),
                    const Gap(4),
                    Text(
                      widget.product.discount.isGreaterThan(0)
                          ? '${(widget.product.price - (widget.product.price * widget.product.discount / 100)).toStringAsFixed(2)}\Dt'
                          : '',
                      style: Styles.headLineStyle4,
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
       cartController.addProduct(widget.product);
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