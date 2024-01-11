
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
/*void main(){
  group('epigo app',(){

    //login screen
    final emailField = find.byValueKey('email');
    final passwordField = find.byValueKey('password');
    final signInButton = find.byValueKey('connecter');
 final addToCartButtonFinder = find.byValueKey('add_to_cart_button');
   
    final homeScreenFinder = find.text('Tous'); // Adjust this based on your home screen


     late FlutterDriver driver;

    // Connect to the Flutter driver
    setUpAll(() async {
      // Connect to a running Flutter application instance.
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      await driver.close();
    });
      test('login and add product to cart  test', () async {
      // Login with valid credentials
      await driver.tap(emailField);
      await driver.enterText("nourammari15@gmail.com");

      await driver.tap(passwordField);
      await driver.enterText("1234567890");

      await driver.tap(signInButton);

      // Wait for the home screen to appear
      await driver.waitFor(homeScreenFinder);
       int productIndexToTap = 0;
   await driver.tap(find.byValueKey('product_card_$productIndexToTap'));

     await driver.tap(addToCartButtonFinder);

        //aWait for the snackbar to appear
      await driver.waitFor(find.text('Ajouté au panier'));
         expect(await driver.getText(find.text('Ajouté au panier')), 'Ajouté au panier');
      // await driver.close();

      // Validate that the snackbar contains the correct message
     // expect(await driver.getText(find.text('Ajouté au panier')), 'Ajouté au panier');




    }, timeout: Timeout.none);

/*test('Add product to cart test', () async {
    // Find the product card by its key or some other identifier
    final productCardFinder = find.byValueKey('product_card_key');

    // Find the add to cart button
    final addToCartButtonFinder = find.byValueKey('add_to_cart_button');

    // Wait for the product card to appear
    await driver.waitFor(productCardFinder);

    // Tap on the add to cart button
    await driver.tap(addToCartButtonFinder);

    // Wait for the snackbar to appear
    await driver.waitFor(find.text('Ajouté au panier'));

    // Validate that the snackbar contains the correct message
    expect(await driver.getText(find.text('Ajouté au panier')), 'Ajouté au panier');
  });*/
    
  });
}*/