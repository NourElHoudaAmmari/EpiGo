import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epigo_project/config/constants.dart';
import 'package:epigo_project/controllers/cart_controller.dart';
import 'package:epigo_project/models/product_model.dart';
import 'package:epigo_project/screens/User/Cart/cart_card.dart';
import 'package:epigo_project/screens/User/Checkout/checkout.dart';
import 'package:epigo_project/screens/User/Home_Screen/home_screen.dart';
import 'package:epigo_project/styles/styles.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
  final CartController cartController = Get.put(CartController());
    final User? user = FirebaseAuth.instance.currentUser;
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    return Scaffold(
    /* bottomNavigationBar: Row(
        children: [
          bonntonNavigatorBar(
              backgroundColor: textColor,
              color: Colors.white70,
              title: "Ajouter article",
              onTap: () {
                  Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(),
                  ),
                );
              }),
          bonntonNavigatorBar(
              backgroundColor: primaryColor,
              color: textColor,
              title: "Commander",
             
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>  Checkout_Page(),
                  ),
                );
              }),
        ],
      ),*/
    
      
        appBar: AppBar(
        title:  Text(
          "Mon Panier",
          style: TextStyle(color: Colors.black, fontSize: 20,fontWeight: FontWeight.bold),
        ),
        elevation: 0.0,
        backgroundColor:Styles.primaryColor,
        leading: IconButton(
          icon: Icon(CupertinoIcons.arrowtriangle_left,color: Colors.black,), onPressed: () {  Navigator.of(context).pop();},
        ),
      ),
     body: StreamBuilder<QuerySnapshot>(
        stream: firestore.collection('users').doc(user!.uid).collection('cart').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Erreur : ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Stack(
             children: [
    Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/cartempty.png',
            width: 450,
            height: 300,
          ),
          SizedBox(height: 8),
          Text(
            "Votre panier est actuellement vide.",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ),
    Positioned(
      bottom: 150 ,
      left: 0,
      right: 0,
      child: Center(
        child: ElevatedButton.icon(
          onPressed: () {
           Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>HomeScreen()),
            );
          },
          icon: Icon(Icons.shopping_cart,color: Colors.black,),
          label: Text('Retour à l\'accueil',style: TextStyle(color: Colors.black),),
          style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(primaryColor), // Couleur de fond
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0), // Rayon de la bordure
        side: BorderSide(color:primaryColor), // Couleur et épaisseur de la bordure
      ),
    ),
            minimumSize: MaterialStateProperty.all(Size(100, 40)), // Ajustez la taille selon vos besoins
          ),
        ),
      ),
    ),
  ],
            );
          } else {
            // Affichez la liste des produits du panier de l'utilisateur actuel.
            final cartItems = snapshot.data!.docs;
            return Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: GridView.count(
                     shrinkWrap: true,
                        crossAxisCount: 1,
                        mainAxisSpacing: 4,
                        crossAxisSpacing: 20,
                        childAspectRatio: 4, // Adapté à votre mise en page
                    children: cartItems.map((cartItem) {
                          return CartCard(
                            product: Product.fromMap(cartItem.data() as Map<String, dynamic>), // Convertissez les données en un objet Product
                          );
                        }).toList(),
                    ),
                  ),
                ),
           Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                       color: Color.fromARGB(255, 241, 240, 240),
                        borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Total: ', style: Styles.textStyle),
                     Text('${cartController.total.toString()} DT',
                                style: Styles.headLineStyle4),
                          ],
                        ),
                        Divider(color: Styles.primaryColor),
                        const Gap(10),
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
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        _analytics.logEvent(name: 'button_addOrder_clicked',
    parameters: {'screen':'CartScreen'},
    );
                     Get.to(()=> Checkout_Page());
                      },
                      child: Text('Commander',style: TextStyle(color: Colors.black,fontSize: 18),),
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
            
              ],
            );
          }
        },
      ),
    );
  }
  Widget bonntonNavigatorBar({
   
    required Color backgroundColor,
    required Color color,
    required String title,
 
   required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(20),
          color: backgroundColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Text(
                title,
                style: TextStyle(color: color),
              ),
            ],
          ),
        ),
      ),
    );
  }
 
}