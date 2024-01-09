
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  late FlutterDriver driver;

  setUpAll(() async {
    driver = await FlutterDriver.connect();
  });

  tearDownAll(() async {
    if (driver != null) {
      driver.close();
    }
  });

  test('Add product to cart test', () async {
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
  });
}