

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epigo_project/models/user_model.dart';
import 'package:epigo_project/repository/user_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class MockFirestoreInstance extends Mock implements FirebaseFirestore {
  MockFirestoreInstance();
}

void main() {
  group('UserRepository Tests', () {
    late UserRepository userRepository;
    late FirebaseFirestore mockFirestore;

    setUpAll(() async {
      // Initialize Firebase once before running tests
      await Firebase.initializeApp();
    });

    setUp(() {
      mockFirestore = MockFirestoreInstance();
      userRepository = UserRepository();
    });

    test('getUserDetails returns user details', () async {
      // Arrange
      final mockSnapshot = MockQuerySnapshot();
      when(mockFirestore.collection('users').where('email', isEqualTo: anyNamed('isEqualTo')).get())
          .thenAnswer((_) => Future.value(mockSnapshot as FutureOr<QuerySnapshot<Map<String, dynamic>>>?));

      final mockDocument = MockQueryDocumentSnapshot();
      when(mockSnapshot.docs).thenReturn([mockDocument]);
      when(mockDocument.data()).thenReturn({'email': 'test@example.com', 'otherField': 'value'});

      // Act
      final result = await userRepository.getUserDetails('test@example.com');

      // Assert
      expect(result, isA<MyUser>());
      expect(result.email, 'test@example.com');
      // Add more assertions based on your MyUser model structure
    });

    // Add more tests for other UserRepository methods if needed
  });
}

// Mock QuerySnapshot
class MockQuerySnapshot extends Mock implements QuerySnapshot {}

// Mock QueryDocumentSnapshot
class MockQueryDocumentSnapshot extends Mock implements QueryDocumentSnapshot {}

// Mock DocumentReference
class MockDocumentReference extends Mock implements DocumentReference {}