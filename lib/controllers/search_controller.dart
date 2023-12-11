import 'package:epigo_project/models/product_model.dart';
import 'package:epigo_project/services/firestore_db.dart';
import 'package:get/get.dart';

class SearchControllerapp extends GetxController {
   RxString _searchText = ''.obs;
  var products = <Product>[].obs;
  List<Product> get productList => products;
  String get searchText => _searchText.value;
  set searchText(String value) {
    _searchText.value = value;
    searchProduct(value);
    if (value.isEmpty) {
      // Réinitialiser la liste des produits
      products.clear();
    }
  }

  void clearSearchText() {
    // Effacer le texte de recherche
    _searchText.value = '';
    // Réinitialiser la liste des produits
    products.clear();
  }

  @override
  void onClose() {
    clearSearchText();
    super.onClose();
  }

  Future searchProduct(String searchText) async {
    products.bindStream(FirestoreDB().searchProduct(searchText));
  }
 /* Future<Stream<List<Product>>> getDiscountedProducts() async {
    return FirestoreDB.getDiscountedProducts();
  }

  Future<Stream<List<Product>>> sortProductsByPriceAscending() async {
    return FirestoreDB.sortProductsByPriceAscending();
  }

  Future<Stream<List<Product>>> sortProductsByPriceDescending() async {
    return FirestoreDB.sortProductsByPriceDescending();
  }*/
}