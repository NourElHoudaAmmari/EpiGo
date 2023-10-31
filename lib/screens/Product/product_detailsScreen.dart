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
   return Scaffold(
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.all(20),
            child: BuildAppBar(title: 'Détails du produit'),
          ),
          Center(
            child: SizedBox(
              height: AppLayout.getHeight(300),
              width: AppLayout.getHeight(300),
              child: Hero(
                transitionOnUserGestures: true,
                tag: widget.product,
                child: AspectRatio(
                  aspectRatio: 1.1,
                  child: ClipPath(
                    clipper: MyClipper(),
                    child: Container(
                      height: AppLayout.getHeight(350),
                      // color: Styles.whiteColor,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Styles.whiteColor,
                            Styles.whiteColor,
                            // Styles.orangeColor,
                          ],
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(50),
                        child: Image.network(widget.product.imageUrl),
                        
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
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
                    Text(' ${widget.product.price.toString()}\Dt',
                        style: Styles.headLineStyle2),
                    Text('  ${widget.product.unit}', style: Styles.headLineStyle3)
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
                const Gap(10),
                Text(widget.product.description, style: TextStyle(color: Colors.black),),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30),
            child: SizedBox(
              height: AppLayout.getHeight(55),
              child: ElevatedButton(
                onPressed: () {
                   cartController.addProduct(widget.product);
                },
                child: Text('Ajouter au panier'),
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
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    path.lineTo(0, size.height - 60);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 60);
    path.lineTo(size.width, 0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}