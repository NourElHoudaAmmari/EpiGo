import 'package:epigo_project/controllers/order_controller.dart';
import 'package:epigo_project/models/order_model.dart';
import 'package:epigo_project/screens/User/Order/component/orderComponenet.dart';
import 'package:epigo_project/services/firestore_db.dart';
import 'package:epigo_project/styles/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  OrderController orderController = Get.put(OrderController());

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Mes Commandes",
            style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          elevation: 0.0,
          backgroundColor: Styles.primaryColor,
          leading: IconButton(
            icon: Icon(CupertinoIcons.arrowtriangle_left, color: Colors.black),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          bottom: TabBar(
               indicatorColor: Styles.textColor,
                  indicatorSize: TabBarIndicatorSize.label,
                  labelColor: Styles.textColor,
            controller: _tabController,
            tabs: [
              Tab(text: 'En préparation'),
              Tab(text: 'En expédition'),
              Tab(text: 'Livrée'),
            ],
          ),
        ),
        body: StreamBuilder<List<Orders>>(
          stream: FirestoreDB().getOrdersByUser(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator.adaptive());
            } else if (snapshot.hasError) {
              return Text('Erreur : ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/noorderfound.png',
                      width: 200,
                      height: 200,
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Aucune commande trouvée",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              );
            } else {
              List<Orders> ordres = snapshot.data!;
              return Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          _buildOrdersList(ordres, 'En préparation'),
                          _buildOrdersList(ordres, 'En expédition'),
                          _buildOrdersList(ordres, 'Livrée'),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }

Widget _buildOrdersList(List<Orders> orders, String status) {
  List<Orders> filteredOrders = orders.where((order) => order.status == status).toList();

  // Sort the filteredOrders list by the date of the command (assuming the date is a DateTime property in the Orders class)
  filteredOrders.sort((a, b) => b.date!.compareTo(a.date!));

  return filteredOrders.isEmpty
      ? Center(
          child: Text(
            'Aucune commande $status',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        )
      : ListView.builder(
          itemCount: filteredOrders.length,
          // itemExtent: 300, 
          itemBuilder: (context, index) {
            return SingleOrderComponent(
              ordres: filteredOrders[index],
            );
          },
        );
}
}