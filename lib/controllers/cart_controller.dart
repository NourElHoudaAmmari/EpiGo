import 'package:epigo_project/models/cart_model.dart';
import 'package:epigo_project/models/product_model.dart';
import 'package:epigo_project/services/firestore_db.dart';
import 'package:epigo_project/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class CartController extends GetxController {
  final _cart = <Cart>[].obs;
  List<Map<String, dynamic>> get myCart => _cart.map((e) => e.toMap()).toList();
  final dynamic _products = [].obs;
  var shippingFee = 5.00;

  final products = <Product>[].obs;
  List<Product> get cartList => products;

  @override
  void onReady() {
    products.bindStream(FirestoreDB().getCart());
  }

Future addProduct(Product product) async {
    await FirestoreDB().addToCart(product);

    if (product.quantity! > 1) return;
  /*  Get.snackbar(
      'Ajouté au panier',
      '${product.title} ajouté au panier',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green,
      colorText: Styles.whiteColor,
      duration: const Duration(seconds: 1),
    );*/
}
  Future removeProduct(Product product) async {
    await FirestoreDB().deleteFromCart(product);

    if (product.quantity! < 1) {
      _products.remove(product);
      Get.snackbar(
        'Retiré du panier',
        '${product.title} Retiré du panier',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Styles.orangeColor,
        colorText: Styles.whiteColor,
        duration: const Duration(seconds: 1),
      );
    }
  }
    double calculateShipping() {
    double shipping = 0.0;
    if (cartList.isEmpty) {
      shipping = 0.0;
      return shipping;
    } else if (cartList.length <= 4) {
      shipping = 2.5;
      return shipping;
    } else {
      shipping = 5.5;
      return shipping;
    }
  }

  get subTotal => cartList
      .map((e) => (e.price - (e.price * e.discount / 100)) * e.quantity!)
      .reduce((a, b) => a + b)
      .toStringAsFixed(2);

  get total {
    var total = cartList
            .map((e) => (e.price - (e.price * e.discount / 100)) * e.quantity!)
            .reduce((a, b) => a + b) +
     shippingFee;
    return total.toStringAsFixed(2);
  }
}