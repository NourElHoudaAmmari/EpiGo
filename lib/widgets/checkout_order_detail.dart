
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epigo_project/controllers/cart_controller.dart';
import 'package:epigo_project/models/CodePromo_model.dart';
import 'package:epigo_project/services/firestore_db.dart';
import 'package:epigo_project/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class CheckoutOrderDetails extends StatefulWidget {
  CheckoutOrderDetails({super.key});

  @override
  State<CheckoutOrderDetails> createState() => _CheckoutOrderDetailsState();
}

class _CheckoutOrderDetailsState extends State<CheckoutOrderDetails> {
    double calculateDiscountAmount(double subTotal, int discountPercentage) {
    return subTotal * (discountPercentage / 100.0);
  }

  var _couponText = TextEditingController();
 void _applyCoupon(String couponCode) async {
    // Fetch the coupon details from Firebase based on the provided coupon code
    List<CouponModel> coupons = await getCouponsFromFirebase();
    
    // Find the coupon with the provided code
    CouponModel? appliedCoupon;
    for (CouponModel coupon in coupons) {
      if (coupon.title == couponCode) {
        appliedCoupon = coupon;
        break;
      }
    }

    if (appliedCoupon == null) {
      // Coupon not found, show an error message
      print("Coupon not found or expired.");
     AwesomeDialog(
context: context,
dialogType: DialogType.warning,
animType: AnimType.topSlide,
showCloseIcon: true,
title: "Avertissement",
desc: 'Coupon introuvable ou expiré',
     ).show();
      // TODO: Show an error message to the user
      return;
    }

    if (appliedCoupon.isActivated == false) {
      // Coupon is not activated, show an error message
      print("Coupon is not activated.");
        AwesomeDialog(
context: context,
dialogType: DialogType.warning,
animType: AnimType.topSlide,
showCloseIcon: true,
title: "Avertissement",
desc: "Le coupon n'est pas activé",
     ).show();
      // TODO: Show an error message to the user
      return;
    }

    if (appliedCoupon.expiryDate != null) {
      // Check if the coupon has expired
      DateTime expiryDate = DateTime.parse(appliedCoupon.expiryDate!);
      if (DateTime.now().isAfter(expiryDate)) {
        // Coupon has expired, show an error message
        print("Coupon has expired.");
            AwesomeDialog(
context: context,
dialogType: DialogType.warning,
animType: AnimType.topSlide,
showCloseIcon: true,
title: "Avertissement",
desc: 'Le coupon a expiré',
     ).show();
        // TODO: Show an error message to the user
        return;
      }
    }
      final CartController cartController = Get.put(CartController());

    double discountPercentage = appliedCoupon.discount / 100.0;
    double subTotalAsDouble = double.parse(cartController.subTotal);
    double discountAmount = subTotalAsDouble * discountPercentage;

// Update the total and discount amount in the cart controller
cartController.updateTotal(subTotalAsDouble - discountAmount);
cartController.updateDiscountAmount(discountAmount);

       AwesomeDialog(
context: context,
dialogType: DialogType.success,
animType: AnimType.topSlide,
showCloseIcon: true,
title: "Info",
desc: 'Coupon appliqué avec succès!',
     ).show();
//show message to the user
print("Coupon applied successfully!");
print(discountAmount);
  }


  

  @override
  Widget build(BuildContext context) {
      final CartController cartController = Get.put(CartController());
       return Column(
      children: [
Container(
  padding: EdgeInsets.only(top: 8,bottom: 8,right: 8,left: 16),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(10.0), // Ajustez le rayon de la bordure selon vos besoins
    border: Border.all(
      color: Colors.black, // Couleur de la bordure
      width: 1.0, // Largeur de la bordure
    ),
  ),
       child: Row(
          children: [
         Flexible(
  child: TextFormField(
    controller: _couponText,
    decoration: InputDecoration(
      hintText: 'Code Promo',
      filled: true,
      fillColor: Colors.transparent,
      focusedBorder: InputBorder.none,
      enabledBorder: InputBorder.none,
      errorBorder: InputBorder.none,
      disabledBorder: InputBorder.none,
    ),
  ),
),
        SizedBox(
  width: 98,
  child: ElevatedButton(
    onPressed: () {
      print("coupn code");
   _applyCoupon(_couponText.text);
    },
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0), // Ajustez le rayon de la bordure du bouton rectangulaire
      ),
      foregroundColor: Colors.black.withOpacity(0.5),
      backgroundColor: Colors.grey.withOpacity(0.2),
      side: BorderSide(
        color: Colors.grey.withOpacity(0.1),
      ),
    ),
    child: Text('Ajouter'),
  ),
),
          ],
        ),
),
        const Gap(20),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 241, 240, 240),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Sous-Total: ', style: Styles.textStyle),
                  Text('${cartController.subTotal.toString()} DT',
                      style: Styles.headLineStyle4),
                ],
              ),
              const Gap(10),
                  Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
      Text('Remise: ', style: Styles.textStyle),
                  Obx(() => Text('${cartController.discountAmount.value} DT', style: Styles.headLineStyle4)),
                ],
              ),
      const Gap(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Livraison: ', style: Styles.textStyle),
                  Text('${cartController.calculateShippingFee()} DT',
                      style: Styles.headLineStyle4),
                ],
              ),
              Divider(color: Styles.primaryColor),
              const Gap(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total: ', style: Styles.textStyle),
                  Text('${cartController.total.toString()} DT',
                      style: Styles.headLineStyle4),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

  Future<List<CouponModel>> getCouponsFromFirebase() async {
  try {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('coupons')
        .get();

    List<CouponModel> coupons = querySnapshot.docs
        .map((DocumentSnapshot doc) => CouponModel.fromDocumentSnapshot(doc))
        .toList();

    return coupons;
  } catch (e) {
    print("Error fetching coupons from Firebase: $e");
    // Handle the error as needed, e.g., show an error message to the user
    throw e;
  }
}