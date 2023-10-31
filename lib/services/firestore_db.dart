import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epigo_project/controllers/profile_controller.dart';
import 'package:epigo_project/controllers/user_controller.dart';
import 'package:epigo_project/repository/authentification_repository.dart';
import 'package:epigo_project/repository/user_repository.dart';
import 'package:epigo_project/styles/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/product_model.dart';



class FirestoreDB {
  final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final UserController _userController = Get.find();
    final _authRepo = Get.put(AuthentificationRepository());
  final _userRepo = Get.put(UserRepository());
  final ProfileController profileController =Get.put(ProfileController());

  Stream<List<Product>> getAllProducts() {
    return _firestore
        .collection('products')
        .snapshots()
        .map((QuerySnapshot query) {
      List<Product> retVal = [];
      query.docs.forEach((element) {
        retVal.add(Product.fromDocumentSnapshot(snapshot: element));
      });

      return retVal;
    });
  }

  Stream<List<Product>> getProductsByCategory(String category) {
    return _firestore
        .collection('products')
        .where('category', isEqualTo: category)
        .snapshots()
        .map((QuerySnapshot query) {
      List<Product> retVal = [];
      query.docs.forEach((element) {
        retVal.add(Product.fromDocumentSnapshot(snapshot: element));
      });
      return retVal;
    });
  }

  Stream<List<Product>> searchProduct(String searchText) {
    return _firestore
        .collection('products')
        .where('title', isGreaterThanOrEqualTo: searchText.toUpperCase())
        .snapshots()
        .map((QuerySnapshot query) {
      List<Product> retVal = [];
      query.docs.forEach((element) {
        retVal.add(Product.fromDocumentSnapshot(snapshot: element));
      });

      return retVal;
    });
  }

  Future<void> addProduct({required Product product}) async {
    final productDoc = _firestore.collection('products').doc();
    Product newProduct = Product(
      id: productDoc.id,
      title: product.title,
      price: product.price,
      imageUrl: product.imageUrl,
      description: product.description,
      category: product.category,
      discount: product.discount,
      unit: product.unit,
      quantity: product.quantity,
      availableInStock: product.availableInStock,

    );

    await productDoc.set(newProduct.toMap());
    Get.snackbar(
      'Added product',
      'product is added successfully!',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Styles.orangeColor,
      colorText: Styles.whiteColor,
      duration: const Duration(seconds: 1),
    );
  }

  Future<void> updateProduct(Product product) async {
    return await _firestore
        .collection('products')
        .doc(product.id)
        .update(product.toMap());
  }

  Future<void> deleteProduct(String id) async {
    await _firestore.collection('products').doc(id).delete();
  }
  //favorites
Future addToFavorite(Product product) async {
  final User? user = _auth.currentUser; // Obtenez l'utilisateur actuellement connecté
  if (user != null) {
    String userId = user.uid; // Obtenez l'ID de l'utilisateur
    CollectionReference userDoc = FirebaseFirestore.instance.collection('users');

    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('favorite')
          .doc(product.id)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
            if (documentSnapshot.exists) {
              userDoc.doc(userId).collection('favorite').doc(product.id).delete();
              print('Article supprimé des favoris');
            } else {
              userDoc
                  .doc(userId)
                  .collection('favorite')
                  .doc(product.id)
                  .set(product.toMap());
              print('Article ajouté aux favoris');
            }
          });
    } catch (e) {
      print('Erreur : $e');
    }
  }
}

Future isFavorite(Product product) async {
  final User? user = _auth.currentUser;
  if (user != null) {
    String userId = user.uid; // Obtenez l'ID de l'utilisateur
    CollectionReference userDoc = FirebaseFirestore.instance.collection('users');

    try {
      bool result = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('favorite')
          .doc(product.id)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
            return documentSnapshot.exists;
          });
      return result;
    } catch (e) {
      print(e);
    }
  }

  return false; // Si l'utilisateur n'est pas connecté ou s'il y a une erreur, renvoyez false.
}

Stream<List<Product>> getFavorites() {
  final User? user = _auth.currentUser; // Obtenez l'utilisateur actuellement connecté
  if (user != null) {
    String userId = user.uid; // Obtenez l'ID de l'utilisateur
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('favorite') // Accédez à la collection "favorite" de l'utilisateur
        .snapshots()
        .map((QuerySnapshot query) {
          List<Product> retVal = [];
          query.docs.forEach((element) {
            retVal.add(Product.fromDocumentSnapshot(snapshot: element));
          });
          return retVal;
        });
  } else {
    // Gérez le cas où l'utilisateur n'est pas connecté
    return Stream.value([]); // Si l'utilisateur n'est pas connecté, renvoyez une liste vide.
  }
}
//cart

Future<void> addToCart(Product product) async {
  try {
    final User? user = _auth.currentUser;
    if (user != null) {
      final String uid = user.uid;
      final CollectionReference userDoc = FirebaseFirestore.instance.collection('users');

      final DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('cart')
          .doc(product.id)
          .get();

      // Vérifier si le produit est en stock
      if (!product.availableInStock) {
        Get.snackbar(
          'Stock épuisé',
          'Désolé, ${product.title} est en rupture de stock.',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Styles.whiteColor,
          duration: const Duration(seconds: 3),
        );
        return;
      }

      if (documentSnapshot.exists) {
        documentSnapshot['quantity'];
        dynamic data = documentSnapshot.data();
        userDoc
            .doc(uid)
            .collection('cart')
            .doc(product.id)
            .update({'quantity': data['quantity'] = data['quantity'] + 1})
            .then((value) => print("User Updated"))
            .catchError((error) => print("Failed to update user: $error"));

        Get.snackbar(
          'Article déjà dans le panier',
          '${product.title} existe déjà dans votre panier',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Styles.whiteColor,
          duration: const Duration(seconds: 3),
        );

        return;
      } else {
        // L'article n'existe pas dans le panier, donc on l'ajoute
        userDoc
            .doc(uid)
            .collection('cart')
            .doc(product.id)
            .set(product.toMap());
        Get.snackbar(
          'Ajouté au panier',
          '${product.title} ajouté au panier',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Styles.whiteColor,
          duration: const Duration(seconds: 2),
        );
      }
    }
  } catch (e) {
    print(e);
  }
}
Future<void> deleteFromCart(Product product) async {
  try {
    final User? user = _auth.currentUser;
    if (user != null) {
      final String uid = user.uid;
      final CollectionReference userDoc = FirebaseFirestore.instance.collection('users');

      final QuerySnapshot qSnap = await userDoc.doc(uid).collection('cart').get();

      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('cart')
          .doc(product.id)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
            if (documentSnapshot.exists) {
              documentSnapshot['quantity'];
              dynamic data = documentSnapshot.data();
              if (data['quantity'] == 1) {
                userDoc.doc(uid).collection('cart').doc(product.id).delete();
              } else {
                userDoc
                    .doc(uid)
                    .collection('cart')
                    .doc(product.id)
                    .update({'quantity': data['quantity'] = data['quantity'] - 1})
                    .then((value) => print("User Updated"))
                    .catchError((error) => print("Failed to update user: $error"));
              }
            }
          });
    }
  } catch (e) {
    print(e);
  }
}
Stream<List<Product>> getCart() {
  try {
    final User? user = _auth.currentUser;
    if (user != null) {
      final String uid = user.uid;

      return FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('cart')
          .snapshots()
          .map((QuerySnapshot query) {
            List<Product> retVal = [];
      query.docs.forEach((element) {
        retVal.add(Product.fromDocumentSnapshot(snapshot: element));
      });
      return retVal;
    });
  
    } else {
      return Stream<List<Product>>.empty();
    }
  } catch (e) {
    print(e);
    return Stream<List<Product>>.empty(); // Ajoutez un return ici en cas d'erreur.
  }
}
}
