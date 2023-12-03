import 'package:epigo_project/repository/authentification_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';


class MockUser extends Mock implements User {}

final MockUser _mockUser = MockUser();

class MockFirebaseAuth extends Mock implements FirebaseAuth {
  @override
  Stream<User> authStateChanges() {
    return Stream.fromIterable([
      _mockUser,
    ]);
  }
}

void main() {
  final MockFirebaseAuth mockFirebaseAuth = MockFirebaseAuth();
  final AuthentificationRepository auth = AuthentificationRepository();
 

  setUp(() => {});
  tearDown(() => {});

  test("emit occurs", () async {
    expectLater(auth.firebaseUser, emitsInOrder([_mockUser]));
  });

test("create account", () async {
    // Mocking createUserWithEmailAndPassword to return a Future<UserCredential>
    when(mockFirebaseAuth.createUserWithEmailAndPassword(
      email: "nourammari15@gmail.com",
      password: "1234567890",
    )).thenAnswer((realInvocation) async {
      // You can create a mock UserCredential for testing purposes
      return MockUserCredential();
    });

    // Expecting the result to be "Success"
    expect(await auth.createUserWithEmailAndPassword("nourammari15@gmail.com", "123456789"),
        "Success");
  });
  test("sign out", () async{
    await auth.logout();
    verify(mockFirebaseAuth.signOut());
});
}

// MockUserCredential class for testing purposes
class MockUserCredential extends Mock implements UserCredential {}