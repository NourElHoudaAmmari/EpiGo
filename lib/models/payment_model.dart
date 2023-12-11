import 'package:flutter/material.dart';

class PaymentModal {
 late String date;
 late String? details;
 late double amount;
 late Color textColor;

  PaymentModal({required this.date, this.details, required this.amount, required this.textColor});

  PaymentModal.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    details = json['details'];
    amount = json['amount'];
    textColor = json['textColor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['details'] = this.details;
    data['amount'] = this.amount;
    data['textColor'] = this.textColor;
    return data;
  }
}