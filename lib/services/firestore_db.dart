import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epigo_project/controllers/profile_controller.dart';
import 'package:epigo_project/controllers/user_controller.dart';
import 'package:epigo_project/models/address_model.dart';
import 'package:epigo_project/models/delivery_methods.dart';
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
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String userId = user.uid;

      final userDoc = FirebaseFirestore.instance.collection('users').doc(userId);

      try {
        final DocumentSnapshot documentSnapshot =
            await userDoc.collection('favorite').doc(product.id).get();

        if (documentSnapshot.exists) {
          userDoc.collection('favorite').doc(product.id).delete();
          print('Article supprimé des favoris');
        } else {
          userDoc.collection('favorite').doc(product.id).set(product.toMap());
          print('Article ajouté aux favoris');
        }
      } catch (e) {
        print('Erreur : $e');
      }
    }
  }
Future<bool> isFavorite(Product product) async {
  final User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    String userId = user.uid;
    DocumentReference userDoc = FirebaseFirestore.instance.collection('users').doc(userId);

    try {
      DocumentSnapshot userSnapshot = await userDoc.get();
      if (userSnapshot.exists) {
        Map<String, dynamic>? userData = userSnapshot.data() as Map<String, dynamic>?;
        if (userData != null && userData.containsKey('favorites')) {
          List<dynamic> favorites = userData['favorites'] as List<dynamic>;
          return favorites.contains(product.id);
        }
      }
    } catch (e) {
      print(e);
    }
  }

  return false;
}

Stream<List<Product>> getFavorites() {
  final User? user = FirebaseAuth.instance.currentUser;

  if (user != null) {
    String userId = user.uid;
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('favorite')
        .snapshots()
        .map((QuerySnapshot query) {
      List<Product> retVal = [];
      query.docs.forEach((element) {
        retVal.add(Product.fromQueryDocumentSnapshot(element));
      });
      return retVal;
    });
  } else {
    return Stream.value([]); // Return an empty list if no user is logged in
  }
}
//cart
Future<void> addToCart(Product product) async {
  try {
    final User? user = FirebaseAuth.instance.currentUser;
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
      if (!product.availableInStock || product.stockQuantity == null || product.stockQuantity! < product.quantity!) {
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

      // Decrease stock quantity
      int newStockQuantity = (product.stockQuantity! - product.quantity!).clamp(0, product.stockQuantity!);
      product.stockQuantity = newStockQuantity;

      // Update stock quantity in the products collection
      await _firestore
          .collection('products')
          .doc(product.id)
          .update({'stockQuantity': newStockQuantity});

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

       /* Get.snackbar(
          'Article déjà dans le panier',
          '${product.title} existe déjà dans votre panier',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Styles.whiteColor,
          duration: const Duration(seconds: 3),
        );*/

        return;
      } else {
        userDoc
            .doc(uid)
            .collection('cart')
            .doc(product.id)
            .set(product.toMap());
       /* Get.snackbar(
          'Ajouté au panier',
          '${product.title} ajouté au panier',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Styles.whiteColor,
          duration: const Duration(seconds: 2),
        );*/
      }
    }
  } catch (e) {
    print(e);
  }
}
 Future<bool> isProductInCart(String productId) async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final String uid = user.uid;
        final DocumentReference productRef = FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .collection('cart')
            .doc(productId);

        final DocumentSnapshot documentSnapshot = await productRef.get();

        if (documentSnapshot.exists) {
          int currentQuantity = documentSnapshot['quantity'] ?? 0;
          int newQuantity = currentQuantity + 1;

          await productRef.update({'quantity': newQuantity});

          return true; // Product is in the cart
        } else {
          return false; // Product is not in the cart
        }
      }
      return false; // User is not logged in
    } catch (e) {
      print(e);
      return false;
    }
  }
Future<void> deleteFromCart(Product product) async {
  try {
  final User? user = FirebaseAuth.instance.currentUser; 
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
            // Increment stock quantity when removing from cart
            int newStockQuantity = (product.stockQuantity! + product.quantity!).clamp(0, product.stockQuantity!);
            product.stockQuantity = newStockQuantity;

            // Update stock quantity in the products collection
            _firestore
                .collection('products')
                .doc(product.id)
                .update({'stockQuantity': newStockQuantity});
          }
          });
    }
  } catch (e) {
    print(e);
  }
}
Stream<List<Product>> getCart() {
  try {
  final User? user = FirebaseAuth.instance.currentUser; 
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
    return Stream<List<Product>>.empty(); 
  }
}

//address
Future<void> addAddress(Address adresse) async {
  try {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userUid = user.uid;
      final firestore = FirebaseFirestore.instance;
      await firestore.collection('users').doc(userUid).collection('adresses').add(adresse.toMap());

      print("Adresse ajoutée avec succès");
    } else {
      print("Utilisateur non connecté.");
    }
  } catch (error) {
    print("Erreur lors de l'ajout de l'adresse : $error");
  }
}
Future<void> UpdateAddress(String adresseId, Address nouvelleAdresse) async {
  try {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userUid = user.uid;
      final firestore = FirebaseFirestore.instance;
      await firestore.collection('users').doc(userUid).collection('adresses').doc(adresseId).update(nouvelleAdresse.toMap());

      print("Adresse mise à jour avec succès");
    } else {
      print("Utilisateur non connecté.");
    }
  } catch (error) {
    print("Erreur lors de la mise à jour de l'adresse : $error");
  }
}
Future<void> deleteAddress(String adresseId) async {
  try {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userUid = user.uid;
      final firestore = FirebaseFirestore.instance;
      await firestore.collection('users').doc(userUid).collection('adresses').doc(adresseId).delete();

      print("Adresse supprimée avec succès");
    } else {
      print("Utilisateur non connecté.");
    }
  } catch (error) {
    print("Erreur lors de la suppression de l'adresse : $error");
  }
}
Stream<List<Address>> getAddress() {
  final User? user = FirebaseAuth.instance.currentUser;

  if (user != null) {
    final userUid = user.uid;
    final firestore = FirebaseFirestore.instance;
    return firestore.collection('users').doc(userUid).collection('adresses').snapshots().map((querySnapshot) {
      List<Address> adresses = [];
      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        final Address adresse = Address.fromDocumentSnapshot(snapshot: doc);
        adresses.add(adresse);
      }
      return adresses;
    });
  } else {
    print("Utilisateur non connecté.");
    return Stream.value([]);
  }
}
Future<void> deselectAllAddresses(String currentAddressId) async {
    final addresses = await getAddress().first; // Attendez la première valeur du Stream (la liste d'adresses)
    for (var address in addresses) {
      if (address.id != currentAddressId) { // Vérifiez si ce n'est pas l'adresse actuelle
        final updatedAddress = address.copyWith(isSelected: false);
        await UpdateAddress(address.id, updatedAddress);
      }
    }
  }
  //DeliveryMethods 
  Stream<List<DeliveryMethod>> deliveryMethodsStream() {
    return _firestore
        .collection('deliveryMethods')
        .snapshots()
        .map((QuerySnapshot query) {
      List<DeliveryMethod> retVal = [];
      query.docs.forEach((element) {
        retVal.add(DeliveryMethod.fromDocumentSnapshot(element));
      });

      return retVal;
    });
  }
}

