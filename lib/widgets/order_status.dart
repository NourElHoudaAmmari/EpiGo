


import 'package:epigo_project/controllers/order_controller.dart';
import 'package:epigo_project/screens/User/Order/component/orderComponenet.dart';
import 'package:epigo_project/styles/app_layout.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class OrdersStatus extends StatelessWidget {
  const OrdersStatus({super.key, required this.status});
  final String status;

  @override
  Widget build(BuildContext context) {
    OrderController orderController = Get.put(OrderController());
    orderController.getOrdersByStatus(status);
    return Scaffold(
      body: Obx(
        () => Column(
          children: [
            Gap(AppLayout.getHeight(10)),
            Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(0),
                  child: ListView.separated(
                      itemCount: orderController.orders.length,
                      separatorBuilder: (context, index) => Gap(10),
                      itemBuilder: ((_, index) {
                        return SingleOrderComponent(
                          ordres: orderController.orders[index],
                          
                        );
                      }))),
            ),
          ],
        ),
      ),
    );
  }
}