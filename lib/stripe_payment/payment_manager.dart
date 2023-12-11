import 'package:dio/dio.dart';
import 'package:epigo_project/stripe_payment/stripe_keys.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

abstract class PaymentManager{
 static Future<void> makePayment(double amount,String currency )async{
try{
String clientSecret = await _getClientSecret((amount*100).toString(), currency);
await _initializePaymentSheet(clientSecret);
await Stripe.instance.presentPaymentSheet();
}catch(error){
  throw Exception(error.toString());
}
 }

 static Future<void>_initializePaymentSheet(String clientSecret)async{
  await Stripe.instance.initPaymentSheet(
    paymentSheetParameters: SetupPaymentSheetParameters(
      paymentIntentClientSecret: clientSecret,
      merchantDisplayName: "EpiGo",

    ),
    );
 }

 static Future<String> _getClientSecret(String amount, String currency) async {
  Dio dio = Dio();
  try {
    var response = await dio.post(
      'https://api.stripe.com/v1/payment_intents',
      options: Options(
        headers: {
          'Authorization': 'Bearer ${ApiKeys.secretKey}',
          "Content-Type": "application/x-www-form-urlencoded"
        },
      ),
      data: {
        'amount': calculateAmount(amount),
        'currency': currency,
      },
    );
    return response.data["client_secret"];
  } catch (error) {
    print('Error creating payment intent: $error');
    throw error; // Rethrow the error to propagate it up the call stack.
  }
}
  static String calculateAmount(String amount) {
    final calculatedAmount = (double.parse(amount) * 100).toInt();
    return calculatedAmount.toString();
  }
}