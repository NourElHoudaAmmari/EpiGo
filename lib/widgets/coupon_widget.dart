import 'package:flutter/material.dart';

class CouponWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
              padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Enter coupon code',
                  ),
                ),
              ),
              SizedBox(width: 16.0),
              ElevatedButton(
                onPressed: () {
                  // Add your logic for applying the coupon code here
                },
                child: Text('Apply'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}