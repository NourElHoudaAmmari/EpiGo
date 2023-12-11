import 'dart:async';
import 'package:epigo_project/config/constants.dart';
import 'package:epigo_project/models/order_model.dart';
import 'package:epigo_project/services/firestore_db.dart';
import 'package:epigo_project/styles/styles.dart';
import 'package:epigo_project/widgets/stickylabel_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

class PaymentDetails extends StatefulWidget {
   final String cardNumber;
  final String expiryDate;
  final String cardHolderName;
  final String cvvCode;
  PaymentDetails({super.key, required this.cardNumber, required this.expiryDate, required this.cardHolderName, required this.cvvCode});

  @override
  _PaymentDetailsState createState() => _PaymentDetailsState();
}

class _PaymentDetailsState extends State<PaymentDetails> {
final StreamController<List<Orders>> _ordersController =
      StreamController<List<Orders>>();

  @override
  void initState() {
    super.initState();
    FirestoreDB().getCardPaymentsByUser().listen((filteredOrders) {
      _ordersController.add(filteredOrders);
    });
  }

  @override
  void dispose() {
    _ordersController.close();
    super.dispose();
  }
 
  bool isCvvFocused = false;
  bool useGlassMorphism = false;
  bool useBackgroundImage = false;
  OutlineInputBorder? border;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
   appBar: AppBar(
        title:  Text(
          "Détails de la carte",
          style: TextStyle(color: Colors.black, fontSize: 20,fontWeight: FontWeight.bold),
        ),
        elevation: 0.0,
        backgroundColor:Styles.primaryColor,
        leading: IconButton(
          icon: Icon(CupertinoIcons.arrowtriangle_left,color: Colors.black,), onPressed: () {  Navigator.of(context).pop();},
        ),
      ),
      body: SingleChildScrollView(
        
        child: Column(
          children: [
            SizedBox(height: 18,),
          CreditCardWidget(
                                cardBgColor: Colors.black,
                                cardNumber: widget.cardNumber,
                                expiryDate: widget.expiryDate,
                                cardHolderName: widget.cardHolderName,
                                cvvCode: widget.cvvCode,
                                bankName: '',
                                showBackView: isCvvFocused,
                                obscureCardNumber: true,
                                obscureCardCvv: true,
                                isHolderNameVisible: true,
                                isSwipeGestureEnabled: true,
                                onCreditCardWidgetChange:
                                    (CreditCardBrand creditCardBrand) {},
                              ),
            SizedBox(height: 14,),
            StickyLabel(text: "Informations sur la carte"),
            SizedBox(height: 8.0),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 24.0),
              decoration: BoxDecoration(
                color: kWhiteColor,
                border: Border.all(
                  width: 0.5,
                  color: kLightColor,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 8.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Ma carte personnelle",
                            style: TextStyle(fontSize: 18.0)),
                        Container(
                            width: 60.0,
                            child: Icon(Icons.payment,
                                color: kPrimaryColor, size: 40.0)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Numéro de carte",
                              style: TextStyle(
                                fontSize: 16.0,
                                color: kLightColor,
                              ),
                            ),
                            Text(
                              widget.cardNumber,
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ],
                        ),
                        Container(
                          width: 38.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Exp.",
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: kLightColor,
                                ),
                              ),
                                SizedBox(width: 9.0),
                              Text(
                             widget.expiryDate,
                                style: TextStyle(fontSize: 16.0),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 8.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Nom de la carte",
                              style: TextStyle(
                                fontSize: 16.0,
                                color: kLightColor,
                              ),
                            ),
                            Text(
                             widget.cardHolderName,
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ],
                        ),
                        Container(
                          width: 45.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "CVV",
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: kLightColor,
                                ),
                              ),
                              Text(
                         widget.cvvCode,
                                style: TextStyle(fontSize: 16.0),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 48.0,
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                    style: ButtonStyle(
    backgroundColor: MaterialStateProperty.all(primaryColor),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: BorderSide(color: primaryColor),
      ),
    ),
  ),
                      child: Text(
                        "Modifier les détails",
                        style: TextStyle(fontSize: 16.0,color: textColor),
                      ),
                      onPressed: () => print("Modifier les détails"),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 12,),
            StickyLabel(text: "Détails des transactions"),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              decoration: BoxDecoration(
                color: kWhiteColor,
                border: Border.all(
                  width: 0.5,
                  color: kLightColor,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: StreamBuilder<List<Orders>>(
                stream: _ordersController.stream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Orders> filteredOrders = snapshot.data!;
                    return ListView.separated(
                      shrinkWrap: true,
                      itemCount: filteredOrders.length,
                      itemBuilder: (context, index) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
Text(
  DateFormat('dd.MM.yyyy HH:mm:ss')
      .format(DateTime.parse(filteredOrders[index].date!)),
  style: TextStyle(
    fontSize: 16.0,
    color: kLightColor,
  ),
),
                            Text(
                              "${filteredOrders[index].total?.toStringAsFixed(3)} Dt",
                          style: TextStyle(
    fontWeight: FontWeight.bold,
   
  ),
                            ),
                          ],
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Divider(
                          thickness: 0.5,
                          color: kLightColor,
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}");
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
            ),
            SizedBox(height: 8.0),
          ],
        ),
      ),
    );
  }
}