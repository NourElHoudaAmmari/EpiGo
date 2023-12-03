import 'package:epigo_project/screens/User/Home_Screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SuccessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Delay the redirection
    Future.delayed(Duration(seconds: 6), () {
      Get.to(HomeScreen());
    });

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Adjusted the alignment of Lottie animation and text
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Additional text widget
              
             // Adjust the spacing between the image and text
              Center(child: Lottie.asset('animations/ordersuccess.json', width: 400, height: 400)),
              SizedBox(height: 13), 
              Text(
                'Félicitations!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green),
              ),
                SizedBox(height: 8),// Adjust the spacing between the image and text
              Center(
                child: Text(
                  'Commande passée avec succès',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}