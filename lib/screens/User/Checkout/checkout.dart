

import 'package:epigo_project/config/constants.dart';
import 'package:epigo_project/controllers/cart_controller.dart';
import 'package:epigo_project/models/address_model.dart';
import 'package:epigo_project/models/delivery_methods.dart';
import 'package:epigo_project/models/product_model.dart';
import 'package:epigo_project/screens/User/Adresses/add_edit_adress.dart';
import 'package:epigo_project/screens/User/Cart/cart_card.dart';
import 'package:epigo_project/screens/User/Checkout/cart_items.dart';
import 'package:epigo_project/screens/User/Checkout/shipping_address_component.dart';
import 'package:epigo_project/services/firestore_db.dart';
import 'package:epigo_project/styles/styles.dart';
import 'package:epigo_project/widgets/checkout_order_detail.dart';
import 'package:epigo_project/widgets/delivery_method_item.dart';
import 'package:epigo_project/widgets/payment_componenet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Checkout_Page extends StatefulWidget {
  const Checkout_Page({super.key});

  @override
  State<Checkout_Page> createState() => _Checkout_PageState();
}

class _Checkout_PageState extends State<Checkout_Page> {
    final CartController cartController = Get.put(CartController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title:  Text(
          "Paiement",
          style: TextStyle(color: Colors.black, fontSize: 20,fontWeight: FontWeight.bold),
        ),
        elevation: 0.0,
        backgroundColor:Styles.primaryColor,
        leading: IconButton(
          icon: Icon(CupertinoIcons.arrowtriangle_left,color: Colors.black,), onPressed: () {  Navigator.of(context).pop();},
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Adresse de livraison',
                style: Theme.of(context).textTheme.headline6,
              ),
              const SizedBox(height: 8.0),
              StreamBuilder<List< Address>>(
                  stream: FirestoreDB().getAddress(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      final shippingAddresses = snapshot.data;
                      if (shippingAddresses == null ||
                          shippingAddresses.isEmpty) {
                        return Center(
                          child: Column(
                            children: [
                              const Text('Aucune adresse de livraison !'),
                              const SizedBox(height: 6.0),
                              InkWell(
                                onTap: () =>   Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Add_EditAdress()),
            ),
                                child: Text(
                                  'Ajouter un nouveau',
                                  style: Theme.of(context)
                                      .textTheme
                                      .button!
                                      .copyWith(
                                        color: Colors.redAccent,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      //  We need to filter the data to chosse the default one only
                      final shippingAddress = shippingAddresses.first;
                      return ShippingAddressComponent(adress: shippingAddress,
                       );
                    }
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  }),
              const SizedBox(height: 24.0),
           StreamBuilder<List<Product>>(
  stream: FirestoreDB().getCart(),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.active) {
      final cartList = snapshot.data ?? [];
      return ExpansionTile(
        children: cartList.map((product) {
          return CartItems(
            product: product,
          );
        }).toList(),
        title: Text("Articles commandés",style: Theme.of(context).textTheme.headline6,),
      );
    } else if (snapshot.connectionState == ConnectionState.waiting) {
      return CircularProgressIndicator.adaptive();
    } else {
      return Text('Error loading cart');
    }
  },
),
                        const SizedBox(height: 24.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Paiement',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  InkWell(
                    onTap: () {},
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
              PaymentComponent(),
              const SizedBox(height: 24.0),
           
              Text(
                'Méthode de livraison',
                style: Theme.of(context).textTheme.headline6,
              ),
              //const SizedBox(height: 8.0),
           StreamBuilder<List<DeliveryMethod>>(
                stream: FirestoreDB().deliveryMethodsStream(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    final deliveryMethods = snapshot.data;

                    if (deliveryMethods == null || deliveryMethods.isEmpty) {
                      return Center(
                        child: Text('Aucune méthode de livraison disponible !'),
                      );
                    }
                    return SizedBox(
                      height:100,
                      child: ListView.builder(
                        itemCount: deliveryMethods.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (_, i) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DeliveryMethodItem(
                            deliveryMethod: deliveryMethods[i],
                          ),
                        ),
                      ),
                    );
                  }

                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                },
              ),
              const SizedBox(height: 16.0),
              CheckoutOrderDetails(),
              const SizedBox(height: 16.0),
           ElevatedButton(
                      onPressed: () {
                   
                      },
                      child: Text('Confirmer',style: TextStyle(color: Colors.black),),
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
            ],
          ),
        ),
      ),
    );
  }
}