

// ignore_for_file: unnecessary_null_comparison

import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main(){
  group('epigo app',(){

    //login screen
    final emailField = find.byValueKey('email');
    final passwordField = find.byValueKey('password');
    final signInButton = find.byValueKey('connecter');
  


     late FlutterDriver driver;

    // Connect to the Flutter driver
    setUpAll(() async {
      // Connect to a running Flutter application instance.
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      await driver.close();
    });

    // Your tests go here
    test('login account with valid credentials ', () async {
     
      await driver.tap(emailField);
      await driver.enterText("nourammari15@gmail.com");

       await driver.tap(passwordField);
      await driver.enterText("123456789");

     
       await driver.tap(signInButton);
    }, timeout: Timeout.none); // Increase or set a specific duration

  /*  test('login account with invalid credentials', () async {
      await driver.tap(emailField);
      await driver.enterText("nourammari15@gmail.com");

      await driver.tap(passwordField);
      await driver.enterText("123456");

      await driver.tap(signInButton);

      // Wait for the toast to appear
      final toastFinder = find.text("Les informations d'identification sont invalides");
      print("Waiting for toast to appear...");
await driver.waitFor(toastFinder, timeout: Duration(seconds: 10));
// Print toast text
final toastText = await driver.getText(toastFinder);
print("Toast Text: $toastText");
expect(toastText, "Les informations d'identification sont invalides");
}, timeout: Timeout.none);*/// Increase or set a specific duration
  });
}