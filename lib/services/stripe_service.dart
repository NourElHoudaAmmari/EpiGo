import 'package:epigo_project/Utils/apikey.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

/*class StripePaymentService {
  Map<String, dynamic>? paymentIntent;
  Future<void> makePayment(BuildContext context, double total) async {
    try {
      //STEP 1: Create Payment Intent
     paymentIntent = await createPaymentIntent(total.toString(), 'USD');

if (paymentIntent != null && paymentIntent!['client_secret'] != null) {
  await Stripe.instance.initPaymentSheet(
    paymentSheetParameters: SetupPaymentSheetParameters(
      customFlow: true,
      paymentIntentClientSecret: paymentIntent!['client_secret'],
      style: ThemeMode.light,
      merchantDisplayName: 'EpiGo',
      googlePay: const PaymentSheetGooglePay(merchantCountryCode: "USD"),
      allowsDelayedPaymentMethods: true,
    ),
  );
  displayPaymentSheet(context);
} else {
  throw Exception('Invalid or missing client_secret');
}
    } catch (err) {
      throw Exception(err);
    }
  }

 Future<Map<String, dynamic>?> createPaymentIntent(String total, String currency) async {
  try {
    // Request body
    Map<String, dynamic> body = {
      'amount': calculateAmount(total),
      'currency': currency
    };

    // Make post request to Stripe
    var response = await http.post(
      Uri.parse('https://api.stripe.com/v1/payment_intents'),
      headers: {
        'Authorization': 'Bearer ${APIKey.STRIPE_SECRET}',
        'Content-Type': 'application/x-www-form-urlencoded'
      },
      body: body,
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      // Handle the error case
      print('Error creating PaymentIntent: ${response.body}');
      return null;
    }
  } catch (err) {
    print('Error creating PaymentIntent: $err');
    return null;
  }
}
  displayPaymentSheet(BuildContext context) async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) {
        showDialog(
            context: context,
            builder: (_) => const AlertDialog(
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 100.0,
                      ),
                      SizedBox(height: 10.0),
                      Text("Payment Successful!"),
                    ],
                  ),
                ));

        paymentIntent = null;
      }).onError((error, stackTrace) {
        throw Exception(error);
      });
    } on StripeException catch (e) {
      print('Error is:---> $e');
      const AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Icon(
                  Icons.cancel,
                  color: Colors.red,
                ),
                Text("Payment Failed"),
              ],
            ),
          ],
        ),
      );
    } catch (e) {
      print('$e');
    }
  }

  calculateAmount(String total) {
    final calculatedAmout = (double.parse(total) * 100).toInt();
    return calculatedAmout.toString();
  }
}*/