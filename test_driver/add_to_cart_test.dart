

import 'package:epigo_project/models/product_model.dart';
import 'package:epigo_project/screens/User/Product/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

/*void main() {
  testWidgets('Add product to cart and show toast', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ProductCard(
            key: Key('productCard'), // Replace with the actual key if you set one
            product: Product(
              // Set necessary properties for your Product model
              title: 'Test Product',
              price: 10.0,
              discount: 5,
              availableInStock: true,
              stockQuantity: 10,
              imageUrl: 'https://example.com/image.jpg',
              unit: 'unit',
            ),
          ),
        ),
      ),
    );

    // Ensure that the product details screen is not shown initially
    expect(find.text('Test Product'), findsNothing);

    // Tap on the product card to go to the details screen
    await tester.tap(find.byType(ProductCard));
    await tester.pumpAndSettle();

    // Ensure that the product details screen is now shown
    expect(find.text('Test Product'), findsOneWidget);

    // Go back to the product card screen
    await tester.tap(find.byKey(Key('productDetailsBackButton')));
    await tester.pumpAndSettle();

    // Ensure that we are back on the product card screen
    expect(find.text('Test Product'), findsOneWidget);

    // Tap on the "Add to Cart" button
    await tester.tap(find.byKey(Key('addToCartButton')));
    await tester.pumpAndSettle();

    // Ensure that the "Ajouté au panier" toast is shown
    expect(find.text('Ajouté au panier'), findsOneWidget);
  });
}*/