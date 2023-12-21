import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:epigo_project/main.dart' as app;
import 'package:epigo_project/screens/User/Home_Screen/home_screen.dart';

void main() {
  testWidgets('Test login functionality', (WidgetTester tester) async {
    LoginRobot loginRobot = LoginRobot(tester);
    await loginRobot.launchApp();

    // Test successful login
    await loginRobot.enterValidCredentials();
    await loginRobot.tapLoginButton();
    await loginRobot.waitForHomeScreen();

    // Test unsuccessful login
    await loginRobot.enterInvalidCredentials();
    await loginRobot.tapLoginButton();
    await loginRobot.waitForToastMessage();
  });
}

class LoginRobot {
  final WidgetTester tester;

  LoginRobot(this.tester);

  Future<void> launchApp() async {
    app.main();
    await tester.pumpAndSettle();
  }

  Future<void> enterValidCredentials() async {
    await tester.enterText(find.byKey(Key('emailField')), 'nourammari15@gmail.com');
    await tester.enterText(find.byKey(Key('passwordField')), '1234567890');
  }

  Future<void> enterInvalidCredentials() async {
    await tester.enterText(find.byKey(Key('emailField')), 'nourammari15@gmail.com');
    await tester.enterText(find.byKey(Key('passwordField')), '1234567');
  }

  Future<void> tapLoginButton() async {
    await tester.tap(find.text('Se Connecter'));
    await tester.pumpAndSettle();
  }

  Future<void> waitForHomeScreen() async {
    await tester.pumpAndSettle();
    expect(find.byType(HomeScreen), findsOneWidget);
  }

  Future<void> waitForToastMessage() async {
    await tester.pumpAndSettle();
    expect(find.text('Les informations d\'identification sont invalides.'), findsOneWidget);
  }
}