

import 'package:epigo_project/models/review_model.dart';
import 'package:epigo_project/services/firestore_db.dart';
import 'package:get/get.dart';

class ReviewController extends GetxController {
  final _isLoading = false.obs;
  final _isError = false.obs;
  final _errorMessage = ''.obs;
  bool get isLoading => _isLoading.value;
  bool get isError => _isError.value;
  String get errorMessage => _errorMessage.value;

  var isOpen = false.obs;

  final reviews = <ReviewModal>[].obs;
  List<ReviewModal> get reviewList => reviews;

  final newOrders = {}.obs;
  //List<Order> get orderList => reviews;
   @override
  void onReady() {
   reviews.bindStream(FirestoreDB().getReviews() as Stream<List<ReviewModal>>);
  }




  Future addReview(ReviewModal review) async {
    _isLoading.value = true;
    try {
      FirestoreDB().addReview(review: review);
    } catch (e) {
      _isError.value = true;
      _errorMessage.value = e.toString();
    } finally {
      _isLoading.value = false;
  
    }
  }
  getReviews()async {
await FirestoreDB().getReviews();
}
}