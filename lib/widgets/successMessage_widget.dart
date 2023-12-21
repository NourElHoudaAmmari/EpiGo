import 'package:epigo_project/models/review_model.dart';
import 'package:epigo_project/screens/User/Home_Screen/home_screen.dart';
import 'package:epigo_project/styles/styles.dart';
import 'package:epigo_project/widgets/roundButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../screens/User/Order/component/review_dialog.dart';

class SuccessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    ReviewModal review = ReviewModal();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
        /*  Image.asset(
            "assets/images/bottom_bg.png",
            width: media.width,
            height: media.height,
            fit: BoxFit.cover,
          ),*/
          SafeArea(
            child: SingleChildScrollView(  // Wrap the Column with SingleChildScrollView
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  children: [
                    const SizedBox(height: 35),  // Adjusted SizedBox height
                  Center(child: Lottie.asset('animations/animation.json',)),
                    const SizedBox(
                      height: 25,
                    ),
                    Text(
                      "Félicitations!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 28,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Commande passée avec succès",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 20),
                    RoundButton(
                      title: "Donner Avis",
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return ReviewDialog(review: review);
                          },
                        );
                      },
                    ),
                    TextButton(
                      onPressed: () {
                        Get.to(HomeScreen());
                      },
                      child: Text(
                        "Retour à l'accueil",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Styles.textColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
    // Delay the redirection
    /*Future.delayed(Duration(seconds: 6), () {
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
  }*/
