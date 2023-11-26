import 'package:epigo_project/config/constants.dart';
import 'package:epigo_project/controllers/cart_controller.dart';
import 'package:epigo_project/controllers/favorite_controller.dart';
import 'package:epigo_project/controllers/product_controller.dart';
import 'package:epigo_project/controllers/user_controller.dart';
import 'package:epigo_project/models/product_model.dart';
import 'package:epigo_project/styles/app_layout.dart';
import 'package:epigo_project/styles/styles.dart';
import 'package:epigo_project/widgets/build_appbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';

class  ProductDetails extends StatefulWidget {
 ProductDetails({Key? key, required this.product}) : super(key: key) {

 }
  final Product product;


  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
 late final Product product;
  final ProductController productController = Get.put(ProductController());
 CartController cartController = Get.find();
  FavoriteController favoriteController = Get.put(FavoriteController());
UserController userController =Get.put(UserController());
   List fav = [];
    final auth = FirebaseAuth.instance;
  var loginUser =FirebaseAuth.instance.currentUser;
  double rating = 5;

@override
void initState() {
  super.initState();
 product = widget.product;
 // updateIsLiked();
   getCurrentUser();
}
 getCurrentUser(){
  final user = FirebaseAuth.instance.currentUser;
  if(user !=null){
    loginUser =user;
  }
}


 /* void updateIsLiked() {
    _isLiked = favoriteController.isFavorite(product.id);
  }*/

  @override
  Widget build(BuildContext context) {
      var media = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  width: double.maxFinite,
                  height: media.width * 0.9,
                  decoration: BoxDecoration(
                     // color: const Color(0xffF2F3F2),
                      borderRadius: BorderRadius.circular(15)),
                  alignment: Alignment.center,
                  child: Image.network(widget.product.imageUrl),
                ),
                SafeArea(
                  child: AppBar(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      leading: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Image.asset(
                            "assets/images/back.png",
                            width: 20,
                            height: 20,
                          )),
                      actions: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Image.asset(
                              "assets/images/share.png",
                              width: 20,
                              height: 20,
                            )),
                      ]),
                ),
              ],
            ),
SizedBox(height: 16,),
                Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.product.title, style: Styles.headLineStyle2),
SizedBox(height: 8,),
                     Text(
  widget.product.availableInStock
      ? 'Disponible en stock'
      : 'En rupture de stock',
  style: TextStyle(
    color: widget.product.availableInStock
        ? Colors.black 
        : Colors.red,  
  ),
),
                            SizedBox(height: 8,),
                        GFRating(
                          color: Styles.orangeColor,
                          borderColor: Styles.orangeColor,
                          size: AppLayout.getHeight(20),
                          value: rating,
                          onChanged: (value) {},
                        ),
                      ],
                    )
                  ],
                ),
                Row(
                  children: [
      IconButton(
              onPressed: () {
  favoriteController.addToFavorite(widget.product);
  },
  icon: Obx(() => Icon(
    favoriteController.isFavorite(widget.product) ? Icons.favorite : Icons.favorite_border,
    color: favoriteController.isFavorite(widget.product) ? Colors.red : Colors.black,
  )),
              ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
              
                          
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(' ${widget.product.price.toStringAsFixed(3)} \Dt / ${widget.product.unit}',
                        style: Styles.headLineStyle3),
                   // Text('  ${widget.product.unit}', style: Styles.headLineStyle3)
                  ],
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Divider(color: Colors.blueGrey),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Description du produit', style: Styles.headLineStyle2),
                const Gap(18),
                Text(widget.product.description, style: TextStyle(color: Colors.black),),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(40),
            child: SizedBox(
              height: AppLayout.getHeight(55),
              child: ElevatedButton(
                onPressed: () {
                   cartController.addProduct(widget.product);
                },
                child: Text('Ajouter au panier',style: TextStyle(color: Colors.black),),
                 style: ButtonStyle(
    backgroundColor: MaterialStateProperty.all(primaryColor), // Couleur de fond
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0), // Rayon de la bordure
        side: BorderSide(color:primaryColor), // Couleur et épaisseur de la bordure
      ),
    ),
  ),
              ),
            ),
          ),
          const Gap(20),
         
          ],
        ),
      ),
    );
  }
}