import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epigo_project/models/product_model.dart';
import 'package:epigo_project/services/firestore_db.dart';
import 'package:epigo_project/styles/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoriteController extends GetxController {
final _favorites = <Product>[].obs;
  List<Product> get favorites => _favorites;

  @override
  void onReady() {
    _favorites.bindStream(FirestoreDB().getFavorites());
  }

  Future getFavorites() async {
    _favorites.bindStream(FirestoreDB().getFavorites());
    print('getFavorites: ${favorites.length}');
  }

  Future addToFavorite(Product product) async {
    await FirestoreDB().addToFavorite(product);

    isFavorite(product)
        ? Get.snackbar(
            'Retiré du favoris',
            '${product.title} retiré de la listefavoris',
            snackPosition: SnackPosition.TOP,
            backgroundColor:  Styles.orangeColor,
            colorText: Styles.whiteColor,
            duration: const Duration(seconds: 1),
          )
        : Get.snackbar(
            'Ajouter au favoris',
            '${product.title} ajouter au favoris',
            snackPosition: SnackPosition.TOP,
            backgroundColor:Colors.green,
            colorText: Styles.whiteColor,
            duration: const Duration(seconds: 1),
          );
  }

  bool isFavorite(Product product) {
    bool isFavorite = false;
    favorites.forEach((element) {
      if (element.id == product.id) isFavorite = true;
    });
    return isFavorite;
  }
}