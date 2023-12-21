import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epigo_project/config/constants.dart';
import 'package:epigo_project/models/review_model.dart';
import 'package:epigo_project/styles/styles.dart';
import 'package:epigo_project/widgets/reviewUi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

class Reviews extends StatefulWidget {
  const Reviews({super.key});

  @override
  State<Reviews> createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<List<ReviewModal>> getReviews() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('reviews').get();
      List<ReviewModal> reviews = [];

      querySnapshot.docs.forEach((DocumentSnapshot document) {
        ReviewModal review = ReviewModal.fromDocumentSnapshot(snapshot: document);
        reviews.add(review);
      });

      return reviews;
    } catch (e) {
      print('Error getting reviews: $e');
      return [];
    }
  }
 bool isMore = false;
  List<double> ratings = [0.1, 0.3, 0.5, 0.7, 0.9];
    late List<ReviewModal> reviews = []; // Initialize the list

  @override
  void initState() {
    super.initState();
    // Fetch reviews when the widget is initialized
    fetchReviews();
  }

  // Fetch reviews from Firestore
  Future<void> fetchReviews() async {
    List<ReviewModal> fetchedReviews = await getReviews();
    setState(() {
      reviews = fetchedReviews;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar:  AppBar(
        title:  Text(
          "Notes et Avis",
          style: TextStyle(color: Colors.black, fontSize: 20,fontWeight: FontWeight.bold),
        ),
        elevation: 0.0,
        backgroundColor:Styles.primaryColor,
        leading: IconButton(
          icon: Icon(CupertinoIcons.arrowtriangle_left,color: Colors.black,), onPressed: () {  Navigator.of(context).pop();},
        ),
      ),
      body: Column(
        children: [
          Container(
            color: kAccentColor,
            padding: EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 16.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: "4.5",
                            style: TextStyle(fontSize: 48.0),
                          ),
                          TextSpan(
                            text: "/5",
                            style: TextStyle(
                              fontSize: 24.0,
                              color: kLightColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SmoothStarRating(
                      starCount: 5,
                      rating: 4.5,
                      size: 28.0,
                      color: Colors.orange,
                      borderColor: Colors.orange,
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      "${reviews.length} Avis",
                      style: TextStyle(
                        fontSize: 20.0,
                        color: kLightColor,
                      ),
                    ),
                  ],
                ),
                Container(
                  width: 200.0,
                  child: ListView.builder(
                    shrinkWrap: true,
                    reverse: true,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          Text(
                            "${index + 1}",
                            style: TextStyle(fontSize: 18.0),
                          ),
                          SizedBox(width: 4.0),
                          Icon(Icons.star, color: Colors.orange),
                          SizedBox(width: 8.0),
                          LinearPercentIndicator(
                            lineHeight: 6.0,
                            // linearStrokeCap: LinearStrokeCap.roundAll,
                            width: MediaQuery.of(context).size.width / 2.8,
                            animation: true,
                            animationDuration: 2500,
                            percent: ratings[index],
                            progressColor: Colors.orange,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
             child: ListView.separated(
              padding: EdgeInsets.only(bottom: 8.0, top: 8.0),
              itemCount: reviews.length,
              itemBuilder: (context, index) {
                ReviewModal review = reviews[index];
                return ReviewUI(
                  onPressed: () => print("Plus d'action $index"),
                  onTap: () => setState(() {
                    isMore = !isMore;
                  }),
                  isLess: isMore,
                  review: review,
                );
              },
              separatorBuilder: (context, index) {
                return Divider(
                  thickness: 2.0,
                  color: kAccentColor,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}