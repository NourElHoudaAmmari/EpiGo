import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epigo_project/models/product_model.dart';
import 'package:epigo_project/services/firestore_db.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:firebase_core/firebase_core.dart'; 

class MockFirebaseApp extends Mock implements FirebaseApp {}


class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

void main() async {

  setUpAll(() async {
    WidgetsFlutterBinding.ensureInitialized();
    FirebaseApp app = MockFirebaseApp();
    when(Firebase.initializeApp()).thenAnswer((_) async => app);
    MockFirebaseAuth mockFirebaseAuth = MockFirebaseAuth();
    when(FirebaseAuth.instance).thenReturn(mockFirebaseAuth);

    MockFirebaseFirestore mockFirebaseFirestore = MockFirebaseFirestore();
    when(FirebaseFirestore.instance).thenReturn(mockFirebaseFirestore);

    await Firebase.initializeApp();
  });

  group('Cart Service Tests', () {
    test('Adding product to cart updates quantity', () async {
      // Arrange
      final FirestoreDB cartService = FirestoreDB();
      final Product productToAdd = Product(
        id: 'your_product_id',
        title: '',
        description: '',
        price: 10,
        imageUrl: '',
        category: '',
        availableInStock: true,
        discount: 2,
        unit: '',
      );

      // Act
      await cartService.addToCart(productToAdd);

      // Assert
      // Add your assertions here
    });
  });
}