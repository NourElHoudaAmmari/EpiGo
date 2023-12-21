import 'package:epigo_project/Utils/size_config.dart';
import 'package:epigo_project/controllers/reviewController.dart';
import 'package:epigo_project/controllers/user_controller.dart';
import 'package:epigo_project/models/review_model.dart';
import 'package:epigo_project/repository/authentification_repository.dart';
import 'package:epigo_project/repository/user_repository.dart';
import 'package:epigo_project/screens/User/Home_Screen/home_screen.dart';
import 'package:epigo_project/services/firestore_db.dart';
import 'package:epigo_project/widgets/defaultButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../../config/constants.dart';

class ReviewDialog extends StatefulWidget {
  final ReviewModal review;

  const ReviewDialog({Key? key, required this.review}) : super(key: key);

  @override
  State<ReviewDialog> createState() => _ReviewDialogState();
}

class _ReviewDialogState extends State<ReviewDialog> {
  final TextEditingController commentController = TextEditingController();
  ReviewController reviewController = Get.put(ReviewController());
       UserController userController = Get.put(UserController());
         final _authRepo = Get.put(AuthentificationRepository());

  final _userRepo = Get.put(UserRepository());
             String name = '';
     String email ='';
     String phone ='';
     
      @override
void initState(){
  super.initState;
    getUserData();
    }
    void getUserData() async {
    final userEmail = _authRepo.firebaseUser.value?.email;
    if (userEmail != null) {
      final user = await _userRepo.getUserDetails(userEmail);
      setState(() {
        name = user.name!;
        email = userEmail;
        phone = user.phone!;
    
      });
    } 
  }
  @override
  Widget build(BuildContext context) {
     
    return AlertDialog(
      title: Center(
        child: Text("Avis"),
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Center(
              child: RatingBar.builder(
                initialRating:
                    widget.review.rating != null ? widget.review.rating!.toDouble() : 0.0,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: false,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  widget.review.rating = rating;
                },
              ),
            ),
            SizedBox(height: 28),
         Center(
  child: TextFormField(
     controller: commentController,

    decoration: InputDecoration(
      hintText: "Donner avis",
      labelText: "Commentaire (optionnel)",
      floatingLabelBehavior: FloatingLabelBehavior.always,
      contentPadding: EdgeInsets.symmetric(vertical: 40),
       border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
  borderSide: BorderSide(color: Colors.transparent)
       ),
       focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide(color: Colors.transparent), 
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0), 
      borderSide: BorderSide(color: Colors.transparent), 
    ), 
    ),
    onChanged: (value) {
       widget.review.comment = value;
    },
    maxLines: null,
    maxLength: 150,
  ),
),
            SizedBox(height: 25),

ElevatedButton(
  style: ButtonStyle(
    backgroundColor: MaterialStateProperty.all(primaryColor),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: BorderSide(color: primaryColor),
      ),
    ),
  ),
  onPressed: () async {
    try {
      ReviewModal newReview = ReviewModal(
        id: '',
      rating: widget.review.rating ?? 0.0,
       comment: commentController.text,
        date: DateTime.now().toString(),
        user: {
          'uid': userController.userFirebase?.uid,
          'email': userController.userFirebase?.email,
          'name': name,
          'phone': phone,
        } ?? {},
      );
      await reviewController.addReview(newReview);

      // Show toast
      showToast('Review ajouté avec succès', Toast.LENGTH_SHORT);
      Navigator.of(context).pop(); 
     Get.to(HomeScreen());
    } catch (e) {
      // Handle errors if necessary
      print('Erreur lors de l\'ajout de la revue : $e');
      showToast('Erreur lors de l\'ajout de la revue', Toast.LENGTH_SHORT);
    }
  },
  child: Text('Ajouter', style: TextStyle(color: Colors.black)),
)
          ],
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }

void showToast(String message, Toast toastLength) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: toastLength,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: const Color.fromARGB(255, 125, 124, 124),
    textColor: Colors.white,
    fontSize: 16.0,
  );
}
}