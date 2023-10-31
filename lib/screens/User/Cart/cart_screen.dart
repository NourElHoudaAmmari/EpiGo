import 'package:epigo_project/config/constants.dart';
import 'package:epigo_project/controllers/cart_controller.dart';
import 'package:epigo_project/screens/User/Cart/cart_card.dart';
import 'package:epigo_project/screens/User/Home_Screen/home_screen.dart';
import 'package:epigo_project/styles/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
  final CartController cartController = Get.put(CartController());
    return Scaffold(
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
        body: Obx(
      () => cartController.cartList.isNotEmpty
          ? Column(
              children: [
                Expanded(
                  child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: GridView.count(
                        shrinkWrap: true,
                        crossAxisCount: 1,
                        mainAxisSpacing: 4,
                        crossAxisSpacing: 20,
                        childAspectRatio: 4,
                        children: List.generate(
                          cartController.cartList.length,
                          (index) {
                            return CartCard(
                              product: cartController.cartList[index],
                            );
                          },
                        ),
                      )),
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
                             Text('${cartController.shippingFee.toString()} DT',
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
                     
                      },
                      child: Text('Paiement'),
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
            )
          : Stack(
  children: [
    Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/cartempty.png', // Assurez-vous que le chemin est correct
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
),
        ),
          );
        }
}