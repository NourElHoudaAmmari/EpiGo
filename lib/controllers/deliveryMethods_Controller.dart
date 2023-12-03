

import 'package:get/get.dart';

class DeliveryController extends GetxController {
    final _deliveryMethod = 1.obs;
  get deliveryMethod => _deliveryMethod.value;
  set deliveryMethod(value) => _deliveryMethod.value = value;

  final _deliveryMethodMethod = 'Poste Tunisienne'.obs;
  get deliveryMethodMethod => _deliveryMethodMethod.value;
  set deliveryMethodMethod(value) => _deliveryMethodMethod.value = value;

  String getdeliveryMethodMethodName(String? deliveryMethodMethod) {
  // Add your logic to get the deliveryMethod method name based on the selected option
  return (deliveryMethodMethod == "Aramex") ? "Aramex" : "Poste Tunisienne";
}
}