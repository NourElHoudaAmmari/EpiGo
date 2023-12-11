import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PaymentController extends GetxController {

    Map<String, dynamic>? paymentIntentData;
  final _payment = 1.obs;
  get payment => _payment.value;
  set payment(value) => _payment.value = value;

  final _paymentMethod = 'Paiement à la livraison'.obs;
  get paymentMethod => _paymentMethod.value;
  set paymentMethod(value) => _paymentMethod.value = value;

  String getPaymentMethodName(String? paymentMethod) {
  // Add your logic to get the payment method name based on the selected option
  return (paymentMethod == "Payer par carte") ? "Payer par carte" : "Paiement à la livraison";
}


}