import 'package:epigo_project/models/cart_model.dart';
import 'package:epigo_project/models/product_model.dart';
import 'package:epigo_project/services/firestore_db.dart';
import 'package:epigo_project/styles/styles.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  final _cart = <Cart>[].obs;
  List<Map<String, dynamic>> get myCart => _cart.map((e) => e.toMap()).toList();
  final dynamic _products = [].obs;
  //var shippingFee = 5.000;

  final products = <Product>[].obs;
  List<Product> get cartList => products;

  @override
  void onReady() {
    products.bindStream(FirestoreDB().getCart());
  }
   Future<void> clearCart() async {
    await FirestoreDB().clearCart();
        update();
  }

Future addProduct(Product product) async {
    await FirestoreDB().addToCart(product);
    

    if (product.quantity! > 1) return;
 
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
  double calculateShippingFee() {
    double shipping = 0.0;

    if (cartList.isEmpty) {
      shipping = 0.0;
    } else {
      // Calculer la quantité totale des produits dans le panier
      int totalQuantity = cartList.fold(0, (sum, product) => sum + product.quantity!);

      // Vérifier si le total de la commande est égal à 100.000 dt
      double totalAmount = double.parse(subTotal);

   if (totalAmount >= 100.00) {
       shipping = 0.0;
      } else {
        // Appliquer les règles de calcul des frais de livraison en fonction de la quantité totale
        if (totalQuantity >= 1 && totalQuantity <= 4) {
          shipping = 3.500;
        } else if (totalQuantity >= 5) {
          shipping = 7.500;
        }
      }
    }

    return shipping;
  }
 get subTotal {
    if (cartList.isEmpty) {
      return '0.000';
    }

    return cartList
      .map((e) => (e.price - (e.price * e.discount / 100)) * e.quantity!)
      .reduce((a, b) => a + b)
      .toStringAsFixed(3);
 }
  get total {
    if (cartList.isEmpty) {
      return '0.000';
    }

    var total = cartList
            .map((e) => (e.price - (e.price * e.discount / 100)) * e.quantity!)
            .reduce((a, b) => a + b) +
     calculateShippingFee();
    return total.toStringAsFixed(3);
  }
Future<Stream<List<Product>>> getCart() async {
  final cartList = await FirestoreDB().getCart();
  products.assignAll(cartList as Iterable<Product>);
  return cartList;
}
Future<bool> isProductInCart(Product product) async {
  return await FirestoreDB().isProductInCart(product.id);
}
}