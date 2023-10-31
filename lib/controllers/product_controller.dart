


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epigo_project/controllers/image_controller.dart';
import 'package:epigo_project/models/product_model.dart';
import 'package:epigo_project/services/firestore_db.dart';
import 'package:epigo_project/styles/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
  ImageController imageController = Get.put(ImageController());
  final _isLoading = false.obs;
  final _isError = false.obs;
  final _errorMessage = ''.obs;
  bool get isLoading => _isLoading.value;
  bool get isError => _isError.value;
  String get errorMessage => _errorMessage.value;
  final formKey = GlobalKey<FormState>();
  final products = <Product>[].obs;
  List<Product> get productList => products;

  var newProduct = {}.obs;
  // Map<dynamic, dynamic> get newProduct => _newProduct
  //     .map((key, value) => MapEntry(key.toString(), value.toString()));
  // set newProduct(newProduct) {
  //   _newProduct.value = newProduct;
  // }

  // Category
  List<String> category = [
    'Choisir une catégorie',
    'Fruits',
    'Légumes',
    'Herbes',
  ];
  final _selectedCategory = 'Fruits'.obs;
  String get selectedCategory => _selectedCategory.value;
  set selectedCategory(String value) {
    _selectedCategory.value = value;
    newProduct.update('category', (_) => value, ifAbsent: () => value);
  }

  // Available in Stock
  final _availableInStock = 1.obs;
  int get availableInStock => _availableInStock.value;
  set availableInStock(int value) {
    _availableInStock.value = value;
    newProduct.update('availableInStock', (_) => value == 1 ? true : false,
        ifAbsent: () => value == 1 ? true : false);
    print(newProduct);
  }

  // Selected Unit
  final _selectedUnits = 1.obs;
  int get selectedUnits => _selectedUnits.value;
  set selectedUnits(int value) {
    _selectedUnits.value = value;
    newProduct.update('unit', (_) => value == 1 ? '1kg' : '1pcs',
        ifAbsent: () => value == 1 ? '1kg' : '1pcs');
    print(newProduct);
  }

  @override
  void onReady() {
    newProduct.update('category', (_) => selectedCategory,
        ifAbsent: () => selectedCategory);
    newProduct.update('unit', (_) => selectedUnits == 1 ? '1kg' : '1pcs',
        ifAbsent: () => selectedUnits == 1 ? '1kg' : '1pcs');
    newProduct.update(
        'availableInStock', (_) => availableInStock == 1 ? true : false,
        ifAbsent: () => availableInStock == 1 ? true : false);

    products.bindStream(FirestoreDB().getAllProducts());
    print(newProduct);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    onClose();
    super.onInit();
  }

  @override
  void onClose() {
    print(newProduct);
    newProduct = {}.obs;
    print(newProduct);
    super.onClose();
  }

  void updateProductPrice(Product product, double price) {
    product.price = price;
  }

  Future uploadProduct() async {
    _isLoading.value = true;
    print(newProduct);
    try {
      if (formKey.currentState!.validate()) {
        Product product = Product(
          id: '',
          title: newProduct['Title'],
          price: double.parse(newProduct['Price']),
          description: newProduct['Description'],
          discount: int.parse(newProduct['Discount']),
          imageUrl: imageController.imagePath,
          category: newProduct['category'],
          unit: newProduct['unit'],
          quantity: newProduct['quantity'] = 1,
          availableInStock: newProduct['availableInStock'],
      
        );

        await FirestoreDB().addProduct(product: product);
      }
    } catch (e) {
      _isError.value = true;
      _errorMessage.value = e.toString();
    } finally {
      _isLoading.value = false;
    }
  }

  Future updateProduct(Product product) async {
    // _isLoading.value = true;

    print(newProduct);
    try {
      Product updateProduct = Product(
        id: product.id,
        title: newProduct['Title'] ?? product.title,
        price: newProduct['Price'] == null
            ? product.price
            : double.parse(newProduct['Price']),
        description: newProduct['Description'] ?? product.description,
        discount: newProduct['Discount'] == null
            ? product.discount
            : int.parse(newProduct['Discount']),
        imageUrl: imageController.image == null
            ? product.imageUrl
            : imageController.imagePath,
        category: newProduct['category'] ?? product.category,
        unit: newProduct['unit'],
        quantity: newProduct['quantity'] = 1,
        availableInStock: newProduct['availableInStock'],
      
      );
      print(updateProduct);
      await FirestoreDB().updateProduct(updateProduct);
      newProduct = {}.obs;
    } catch (e) {
      _isError.value = true;
      _errorMessage.value = e.toString();
    } finally {
      _isLoading.value = false;

      Get.snackbar(
        'produit modifié',
        'produit modifié avec succés!',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Styles.orangeColor,
        colorText: Styles.whiteColor,
        duration: const Duration(seconds: 1),
      );
    }
  }

  Future deleteProduct(String id) async {
    _isLoading.value = true;
    try {
      await FirestoreDB().deleteProduct(id);
    } catch (e) {
      _isError.value = true;
      _errorMessage.value = e.toString();
    } finally {
      _isLoading.value = false;
      Get.snackbar(
        'Produit supprimé',
        'produit supprimé avec succés!',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Styles.orangeColor,
        colorText: Styles.whiteColor,
        duration: const Duration(seconds: 1),
      );
    }
  }
  Future<Product?> getProductById(String productId) async {
    try {
      DocumentSnapshot productDoc = await _firestore
          .collection('products')
          .doc(productId)
          .get();
      if (productDoc.exists) {
        return Product.fromMap(productDoc.data() as Map<String, dynamic>);
      }
      return null;
    } catch (e) {
      print("Erreur lors de la récupération du produit : $e");
      return null;
    }
  }
}

  // void _getProducts() async {
  //   _isLoading.value = true;
  //   try {
  //     products.value =  FirestoreDB().getAllProducts();
  //   } catch (e) {
  //     _isError.value = true;
  //     _errorMessage.value = e.toString();
  //   } finally {
  //     _isLoading.value = false;
  //   }
  // }
