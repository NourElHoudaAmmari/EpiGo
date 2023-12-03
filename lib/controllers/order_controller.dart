
import 'package:epigo_project/models/order_model.dart';
import 'package:epigo_project/services/firestore_db.dart';
import 'package:epigo_project/styles/styles.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  final _isLoading = false.obs;
  final _isError = false.obs;
  final _errorMessage = ''.obs;
  bool get isLoading => _isLoading.value;
  bool get isError => _isError.value;
  String get errorMessage => _errorMessage.value;

  var isOpen = false.obs;

  final orders = <Orders>[].obs;
  List<Orders> get productList => orders;

  final newOrders = {}.obs;
  //List<Order> get orderList => orders;
   @override
  void onReady() {
    orders.bindStream(FirestoreDB().getOrdersByStatus('En attente'));
  }

  Future getOrdersByStatus(String status) async {
    orders.bindStream(FirestoreDB().getOrdersByStatus(status));
  }


  Future addOrder(Orders order) async {
    _isLoading.value = true;
    try {
      FirestoreDB().addOrder(order: order);
    } catch (e) {
      _isError.value = true;
      _errorMessage.value = e.toString();
    } finally {
      _isLoading.value = false;
  
    }
  }
    getOrdres()async {
await FirestoreDB().getOrdersByUser();
}
}