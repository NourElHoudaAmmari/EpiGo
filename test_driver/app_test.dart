

// ignore_for_file: unnecessary_null_comparison

import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main(){
  group('epigo app',(){

    //login screen
    final emailField = find.byValueKey('email');
    final passwordField = find.byValueKey('password');
    final signInButton = find.byValueKey('connecter');
 final addToCartButtonFinder = find.byValueKey('add_to_cart_button');
 final backToHomeScreenButton = find.byValueKey('back_button');
 final searchButtonFinder = find.byValueKey('search_icon');
    final homeScreenFinder = find.text('Tous');
     final searchScreenFinder = find.text('Rechercher');// Adjust this based on your home screen
     final searchField = find.byValueKey('text_search');
  
     late FlutterDriver driver;

    // Connect to the Flutter driver
    setUpAll(() async {
      // Connect to a running Flutter application instance.
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      await driver.close();
    });

    test('login account with valid credentials ', () async {
     
      await driver.tap(emailField);
      await driver.enterText("nourammari15@gmail.com");

       await driver.tap(passwordField);
      await driver.enterText("1234567890");

     
       await driver.tap(signInButton);
          // Wait for the home screen to appear
      await driver.waitFor(homeScreenFinder);
    }, timeout: Timeout.none); // Increase or set a specific duration

      test('add product to cart test', () async {
     
       int productIndexToTap = 4;
   await driver.tap(find.byValueKey('product_card_$productIndexToTap'));

     await driver.tap(addToCartButtonFinder);

        //aWait for the snackbar to appear
      await driver.waitFor(find.text('Ajouté au panier'));
         expect(await driver.getText(find.text('Ajouté au panier')), 'Ajouté au panier');
         await driver.tap(backToHomeScreenButton);
           await driver.waitFor(homeScreenFinder);

       
    }, timeout: Timeout.none);

test('adding existing product in cart test', () async {
       int productIndexToTap = 1;
   await driver.tap(find.byValueKey('product_card_$productIndexToTap'));

     await driver.tap(addToCartButtonFinder);

        //aWait for the snackbar to appear
      await driver.waitFor(find.text('Article déjà dans le panier'));
         expect(await driver.getText(find.text('Article déjà dans le panier')), 'Article déjà dans le panier');
       await driver.tap(backToHomeScreenButton);
           await driver.waitFor(homeScreenFinder);
    }, timeout: Timeout.none);

 test('adding out of stock product in cart test', () async {
       int productIndexToTap = 2;
   await driver.tap(find.byValueKey('product_card_$productIndexToTap'));

     await driver.tap(addToCartButtonFinder);

        //aWait for the snackbar to appear
      await driver.waitFor(find.text('Rupture de stock'));
         expect(await driver.getText(find.text('Rupture de stock')), 'Rupture de stock');
       await driver.tap(backToHomeScreenButton);
           await driver.waitFor(homeScreenFinder);
    }, timeout: Timeout.none);

 test('search Product', () async {
       
     await driver.tap(searchButtonFinder);
         await driver.waitFor(searchScreenFinder);
          await driver.tap(searchField);
      await driver.enterText('Tomate');
     await driver.tap(backToHomeScreenButton);
           await driver.waitFor(homeScreenFinder);
    }, timeout: Timeout.none);

     test('search Product with inexistant terms', () async {
       
     await driver.tap(searchButtonFinder);
         await driver.waitFor(searchScreenFinder);
          await driver.tap(searchField);
      await driver.enterText('Produit');

      // Wait for the no results message and image to load.
      final noResultsMessage = find.text("Le produit recherché n'existe pas");
      final noResultsImage = find.byValueKey('search_fail_image');

      await driver.waitFor(noResultsMessage);
      await driver.waitFor(noResultsImage);
     await driver.tap(backToHomeScreenButton);
           await driver.waitFor(homeScreenFinder);
           await driver.close();
    }, timeout: Timeout.none);

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