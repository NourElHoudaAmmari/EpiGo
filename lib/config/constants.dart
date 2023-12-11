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
final reviewList = [
  ReviewModal(
    image: "assets/images/mensFashion.jpg",
    name: "Ahmed Ben Hssine",
    rating: 3.5,
    date: "01 Nov 2023",
    comment:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
  ),
  ReviewModal(
    image: "assets/images/girlsFashion.jpg",
    name: "Asma Ben Ahmed",
    rating: 2.5,
    date: "21 Oct 2023",
    comment:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
  ),
  ReviewModal(
    image: "assets/images/user1.jpg",
    name: "Maissa Jbeli",
    rating: 4.5,
    date: "17 Nov 2023",
    comment:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
  ),
  ReviewModal(
    image: "assets/images/user11.jpg",
    name: "Aya Ben Salih",
    rating: 1.5,
    date: "12 Oct 2023",
    comment:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
  ),
  ReviewModal(
    image: "assets/images/user2.jpg",
    name: "Mostfa chaabane",
    rating: 2.0,
    date: "28 Nov 2023",
    comment:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
  ),
  ReviewModal(
    image: "assets/images/user10.jpg",
    name: "Salma Mahjoub",
    rating: 4.0,
    date: "14 Nov 2023",
    comment:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
  ),
  ReviewModal(
    image: "assets/images/user3.jpg",
    name: "Haythem Abidi",
    rating: 1.0,
    date: "14 Nov 2023",
    comment:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
  ),
  ReviewModal(
    image: "assets/images/user9.jpg",
    name: "Mohaned Ben Hssine",
    rating: 3.0,
    date: "19 Nov 2023",
    comment:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
  ),
  ReviewModal(
    image: "assets/images/user4.jpg",
    name: "Emna Gatri",
    rating: 5.0,
    date: "28 Nov 2023",
    comment:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
  ),
  ReviewModal(
    image: "assets/images/user8.jpg",
    name: "Mohamed Ahmed",
    rating: 3.5,
    date: "16 Nov 2023",
    comment:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
  ),
  ReviewModal(
    image: "assets/images/user5.jpg",
    name: "Nadia Fourati",
    rating: 3.5,
    date: "11 Nov 2023",
    comment:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
  ),
  ReviewModal(
    image: "assets/images/user7.jpg",
    name: "Nairouz Abdi",
    rating: 3.5,
    date: "14 Nov 2023",
    comment:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
  ),
  ReviewModal(
    image: "assets/images/user6.jpg",
    name: "Hedi Jerbi",
    rating: 3.5,
    date: "14 Nov 2023",
    comment:
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
  ),
];
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