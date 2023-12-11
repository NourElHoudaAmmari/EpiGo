import 'package:epigo_project/config/constants.dart';
import 'package:epigo_project/screens/User/Payments_Cards/addCreditCards.dart';
import 'package:epigo_project/screens/User/Profile/components/payment_card.dart';
import 'package:epigo_project/services/firestore_db.dart';
import 'package:epigo_project/styles/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentHistoryScreen extends StatefulWidget {
  const PaymentHistoryScreen({super.key});

  @override
  State<PaymentHistoryScreen> createState() => _PaymentHistoryScreenState();
}

class _PaymentHistoryScreenState extends State<PaymentHistoryScreen> {
 String cardNumber = '4242 4242 4242 4242';
  String expiryDate = '12/25';
  String cardHolderName = 'Nour El Houda Ammari';
  String cvvCode = '123';
  bool isCvvFocused = false;
  bool useGlassMorphism = false;
  bool useBackgroundImage = false;
  OutlineInputBorder? border;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

FirestoreDB _firestoreDB = Get.put(FirestoreDB());

  @override
  void initState() {
   _firestoreDB.getUserCards();
    border = OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey.withOpacity(0.7),
        width: 2.0,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(
          "Paiement",
          style: TextStyle(color: Colors.black, fontSize: 20,fontWeight: FontWeight.bold),
        ),
        elevation: 0.0,
        backgroundColor:Styles.primaryColor,
        leading: IconButton(
          icon: Icon(CupertinoIcons.arrowtriangle_left,color: Colors.black,), onPressed: () {  Navigator.of(context).pop();},
        ),
      ),
     // resizeToAvoidBottomInset: false,
      body: Container(
        child: Stack(
          children: <Widget>[
            Obx(() => _firestoreDB.userCards.value.isEmpty
                ? const Center(child: Text("Aucun enregistrement trouvé",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)))
                : Positioned(
                     top: 17,  // Adjust this value to reduce space between AppBar and ListView
                    left: 0,
                    right: 0,
                    bottom: 50, 
                    child: Obx(() => ListView.builder(
                          shrinkWrap: true,
                          itemBuilder: (ctx, i) {
                            String cardNumber = '';
                            String expiryDate = '';
                            String cardHolderName = '';
                            String cvvCode = '';

                            try {
                              cardNumber = _firestoreDB.userCards.value[i]
                                  .get('number');
                            } catch (e) {
                              cardNumber = '';
                            }

                            try {
                              expiryDate = _firestoreDB.userCards.value[i]
                                  .get('expiry');
                            } catch (e) {
                              expiryDate = '';
                            }

                            try {
                              cardHolderName =
                                 _firestoreDB.userCards.value[i].get('name');
                            } catch (e) {
                              cardHolderName = '';
                            }

                            try {
                              cvvCode =
                                 _firestoreDB.userCards.value[i].get('cvv');
                            } catch (e) {
                              cvvCode = '';
                            }

                            return GestureDetector(
                         onDoubleTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => PaymentDetails(
        cardNumber: cardNumber,
        expiryDate: expiryDate,
        cardHolderName: cardHolderName,
        cvvCode: cvvCode,
      ),
    ),
  );
},
                              child: CreditCardWidget(
                                cardBgColor: Colors.black,
                                cardNumber: cardNumber,
                                expiryDate: expiryDate,
                                cardHolderName: cardHolderName,
                                cvvCode: cvvCode,
                                bankName: '',
                                showBackView: isCvvFocused,
                                obscureCardNumber: true,
                                obscureCardCvv: true,
                                isHolderNameVisible: true,
                                isSwipeGestureEnabled: true,
                                onCreditCardWidgetChange:
                                    (CreditCardBrand creditCardBrand) {},
                              ),
                            );
                          },
                          itemCount: _firestoreDB.userCards.length,
                        )),
                  )),
            Positioned(
                bottom: 10,
                right: 10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "",
                      style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: primaryColor),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    FloatingActionButton(
                      onPressed: () {
                        Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddCreditCard()),
            );
                      },
                      child: Icon(
                        Icons.add,
                        color: Colors.black,
                      ),
                      backgroundColor: primaryColor,
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}