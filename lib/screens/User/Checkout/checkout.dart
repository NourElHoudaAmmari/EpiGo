

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epigo_project/config/constants.dart';
import 'package:epigo_project/controllers/cart_controller.dart';
import 'package:epigo_project/controllers/deliveryMethods_Controller.dart';
import 'package:epigo_project/controllers/order_controller.dart';
import 'package:epigo_project/controllers/paymentController.dart';
import 'package:epigo_project/controllers/user_controller.dart';
import 'package:epigo_project/models/address_model.dart';
import 'package:epigo_project/models/delivery_methods.dart';
import 'package:epigo_project/models/order_model.dart';
import 'package:epigo_project/models/product_model.dart';
import 'package:epigo_project/screens/User/Adresses/add_edit_adress.dart';
import 'package:epigo_project/screens/User/Cart/cart_card.dart';
import 'package:epigo_project/screens/User/Checkout/cart_items.dart';
import 'package:epigo_project/screens/User/Checkout/shipping_address_component.dart';
import 'package:epigo_project/screens/User/Home_Screen/home_screen.dart';
import 'package:epigo_project/services/firestore_db.dart';
import 'package:epigo_project/services/stripe_service.dart';
import 'package:epigo_project/styles/styles.dart';
import 'package:epigo_project/widgets/checkout_order_detail.dart';
import 'package:epigo_project/widgets/delivery_method_item.dart';
import 'package:epigo_project/widgets/paymentMethods.dart';
import 'package:epigo_project/widgets/payment_componenet.dart';
import 'package:epigo_project/widgets/successMessage_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:epigo_project/repository/authentification_repository.dart';
import 'package:epigo_project/repository/user_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:unicons/unicons.dart';

class Checkout_Page extends StatefulWidget {
  const Checkout_Page({super.key});

  @override
  State<Checkout_Page> createState() => _Checkout_PageState();
}

class _Checkout_PageState extends State<Checkout_Page> {
      final CartController cartController = Get.put(CartController());
        PaymentController paymentController = Get.put(PaymentController());
        OrderController orderController = Get.put(OrderController());
        UserController userController = Get.put(UserController());
    DeliveryController  deliveryController = Get.put(DeliveryController());
    //  StripePaymentService _paymentService=StripePaymentService();
   final _authRepo = Get.put(AuthentificationRepository());

  final _userRepo = Get.put(UserRepository());
             String name = '';
     String email ='';
     String phone ='';
     
      @override
void initState(){
  super.initState;
    getUserData();
    }
    void getUserData() async {
    final userEmail = _authRepo.firebaseUser.value?.email;
    if (userEmail != null) {
      final user = await _userRepo.getUserDetails(userEmail);
      setState(() {
        name = user.name!;
        email = userEmail;
        phone = user.phone!;
    
      });
    } 
  }
/*String getPaymentMethodName(String? paymentMethod) {
  // Add your logic to get the payment method name based on the selected option
  return (paymentMethod == "Payer par carte") ? "Payer par carte" : "Paiement à la livraison";
}


     Future<void> addOrder({required Orders order}) async {
  try {
    // Check if the user is authenticated
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Fetch necessary data
      List<Product> cartList = await FirestoreDB().getCart().first;
List<Address>? shippingAddressList = await FirestoreDB().getAddress().first;

      // Assume you want to use the first address in the list
      List<Address> shippingAddress = shippingAddressList?.isNotEmpty == true ? [shippingAddressList![0]] : [];

      // Create an Order instance
      Orders newOrder = Orders(
        cart: cartList,
        user: {'id': user.uid},
        total: double.parse(cartController.total),
        status: "Pending",
        date: DateTime.now().toString(),
        paymentMethod: getPaymentMethodName(order.paymentMethod),
        paymentStatus: "En attente",
        deliveryStatus: "En attente",
        address: shippingAddress, // Use the corrected shippingAddress variable here
      );

      // Perform the necessary actions to add the order
      if (paymentController.payment == 1) {
        // Payment with a card
        order.id = await FirestoreDB().saveOrder(newOrder);
        // Placeholder: Replace the following comment with your actual Stripe integration code
        // StripeService.initiatePayment(cartList, shippingAddress);
      } else {
        // Payment cash on delivery
        order.id = await FirestoreDB().saveOrder(newOrder);
      }

      // Clear the cart after the order is placed
      cartController.clearCart();

      // Optionally, you can navigate to a success screen or show a confirmation message
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => OrderConfirmationScreen(order)),
      // );
    } else {
      // User is not authenticated, handle accordingly
      print("User is not authenticated");
    }
  } catch (e) {
    print("Error adding order: $e");
    // Handle the error as needed
  }
}*/
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
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 28.0),
        child: SingleChildScrollView(
          child: Expanded(
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
                       
      // Filter the addresses to choose the default one
      final defaultShippingAddress = shippingAddresses.firstWhere(
        (address) => address.isSelected == true,
        orElse: () => shippingAddresses.first, // Choose the first if no default is found
      );

      return ShippingAddressComponent(adress: defaultShippingAddress);
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
                  ],
                ),
                const SizedBox(height: 8.0),
                PaymentComponentWidget (),
                const SizedBox(height: 24.0),
             
                Text(
                  ' Livraison',
                  style: Theme.of(context).textTheme.headline6,
                ),
                        const SizedBox(height: 8.0),
              DeliveryMethodItem(),
               /*StreamBuilder<List<DeliveryMethod>>(
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
                        height: 100,
                        child: ListView.builder(
                          itemCount: deliveryMethods.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (_, i) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                               
                              ],
                            ),
                          ),
                        ),
                      );
                    }

                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  },
                ),*/
                const SizedBox(height: 16.0),
                CheckoutOrderDetails(),
                const SizedBox(height: 16.0),
  ElevatedButton(
  onPressed: () async {
    List<Address>? shippingAddressList = await FirestoreDB().getAddress().first;

    // Assume you want to use the first address in the list
    List<Address> shippingAddress = shippingAddressList?.isNotEmpty == true ? [shippingAddressList![0]] : [];

    List<dynamic> cartItems = cartController.cartList.map((cartItem) {
      return {
        'title': cartItem.title,
        'price': cartItem.price,
        'quantity': cartItem.quantity,
        // Add other properties as needed
      };
    }).toList();

    Orders newOrder = Orders(
      cart: cartController.cartList,
      user: {
        'uid': userController.userFirebase?.uid,
        'email': userController.userFirebase?.email,
        'name': name,
        'phone': phone,
      } ?? {},
      total: double.parse(cartController.total),
      status: 'En préparation',
      date:  DateTime.now().toString(),
      paymentMethod: paymentController.payment == 1 ? 'Payer par carte' : 'Paiement à la livraison',
      paymentStatus: 'En attente',
      deliveryStatus: 'En attente',
      deliveryAddress: shippingAddress,
      deliverymethods: deliveryController.deliveryMethod == 1 ? 'Aramex' : 'Poste Tunisienne',
    );

    // Condition to check the payment method
    if (paymentController.payment == 1) {
    // await _paymentService.makePayment(context,double.parse(cartController.total));
      await orderController.addOrder(newOrder);
    } else {
      await orderController.addOrder(newOrder);
    }

    cartController.clearCart();
    Get.to(() => SuccessPage());
  },
  child: Text('Confirmer', style: TextStyle(color: Colors.black, fontSize: 18)),
  style: ButtonStyle(
    backgroundColor: MaterialStateProperty.all(primaryColor),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: BorderSide(color: primaryColor),
      ),
    ),
  ),
),
              ],
            ),
          ),
        ),
      ),
    );
  }
}