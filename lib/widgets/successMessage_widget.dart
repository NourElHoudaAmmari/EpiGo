import 'package:epigo_project/screens/User/Home_Screen/home_screen.dart';
import 'package:epigo_project/styles/styles.dart';
import 'package:epigo_project/widgets/roundButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SuccessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     var media = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Image.asset(
            "assets/images/bottom_bg.png",
            width: media.width,
            height: media.height,
            fit: BoxFit.cover,
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: [
                  const Spacer(),
                  Image.asset(
                    "assets/images/order_accpeted.png",
                    width: media.width * 0.7,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Text(
                    "Votre commande a été bien acceptée",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 28,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Vos articles ont été placés et sont en cours de traitement",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  const Spacer(),
                  const Spacer(),
                  RoundButton(title: "Donner Avis", onPressed: () {}),
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
        ],
      ),
    );
  }
}
    // Delay the redirection
   /* Future.delayed(Duration(seconds: 6), () {
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
}*/