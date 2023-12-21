
import 'package:epigo_project/screens/User/Home_Screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:epigo_project/main.dart' as app;
import 'package:patrol/patrol.dart';

void main() {
  testWidgets('Test login functionality', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    app.main();
    await tester.pumpAndSettle();

    // Mock user credentials
    final String mockEmail = 'test@example.com';
    final String mockPassword = 'testpassword';

    // Find email and password text fields
    final Finder emailField = find.byKey(Key('emailField'));
    final Finder passwordField = find.byKey(Key('passwordField'));

    // Enter mock email and password
    await tester.enterText(emailField, mockEmail);
    await tester.enterText(passwordField, mockPassword);

    // Find and tap the login button
    final Finder loginButton = find.text('Se Connecter');
    await tester.tap(loginButton);
    await tester.pumpAndSettle();

    // Wait for Firebase authentication to complete
    await tester.runAsync(() async {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: mockEmail, password: mockPassword);
    });

    // Verify that the HomeScreen is displayed after successful login
    expect(find.byType(HomeScreen), findsOneWidget);
  });
}