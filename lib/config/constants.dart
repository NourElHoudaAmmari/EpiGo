import 'package:epigo_project/models/payment_model.dart';
import 'package:epigo_project/models/review_model.dart';
import 'package:flutter/material.dart';


Color primaryColor = Color(0xffd1ad17);
Color scaffoldBackgroundColor = Color.fromARGB(255, 224, 223, 223);
const beigeColor = Color(0xFFF2A961);
const marronColor = Color(0xFF79301B);
const orangeColor = Color(0xFFFF7043);
const greenColor = Color(0xFF595224);
const kPrimaryLightColor = Color(0xFFF5F5F5);
const secondaryColor = Color(0xFF2A2D3E);
const bgColor = Color(0xFF212332);
Color textColor = Colors.black87;
 //Color kPrimaryLightColor = Color(0xFFF5F5F5);
const double defaultPadding = 16.0;
const kPrimaryColor = Color(0xFFFF8084);
const kAccentColor = Color(0xFFF1F1F1);
const kWhiteColor = Color(0xFFFFFFFF);
const kLightColor = Color(0xFF808080);
const kDarkColor = Color(0xFF303030);
const kTransparent = Colors.transparent;

const kDefaultPadding = 24.0;
const kLessPadding = 10.0;
const kFixPadding = 16.0;
const kLess = 4.0;

const kShape = 30.0;

const kRadius = 0.0;
const kAppBarHeight = 56.0;

const kHeadTextStyle = TextStyle(
  fontSize: 24.0,
  fontWeight: FontWeight.bold,
);

const kSubTextStyle = TextStyle(
  fontSize: 18.0,
  color: kLightColor,
);

const kTitleTextStyle = TextStyle(
  fontSize: 20.0,
  color: kPrimaryColor,
);

const kDarkTextStyle = TextStyle(
  fontSize: 20.0,
  color: kDarkColor,
);

const kDivider = Divider(
  color: kAccentColor,
  thickness: kLessPadding,
);

const kSmallDivider = Divider(
  color: kAccentColor,
  thickness: 5.0,
);

final paymentDetailList = [
  PaymentModal(
      date: "Oct 01",
      amount: 1000.0,
      textColor: Colors.red),
  PaymentModal(
      date: "Nov 15",
      amount: 650.0,
      textColor: Colors.green),
  PaymentModal(
      date: "Dec 03",
      amount: 180.0,
      textColor: Colors.green),
  PaymentModal(
      date: "Nov 14",
      amount: 540.0,
      textColor: Colors.red),
  PaymentModal(
      date: "Oct 08",
      amount: 210.0,
      textColor: Colors.red),
  PaymentModal(
      date: "Dec 01",
      amount: 375.0,
      textColor: Colors.green),
];