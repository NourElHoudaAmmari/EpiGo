



import 'dart:async';

import 'package:epigo_project/models/CodePromo_model.dart';
import 'package:epigo_project/services/couponCode_Service.dart';
import 'package:get/get.dart';

/*class CouponCodeController extends GetxController {
    final RxList<PromoCodeModel> listArr = <PromoCodeModel>[].obs;
  final _couponCode = <CouponModel>[];
  final RxList<CouponModel> _couponCodeRx = <CouponModel>[].obs;
  late String couponCode; // Add this line to declare couponCode

  List<CouponModel> get couponList => _couponCodeRx;
  List<Map<String, dynamic>> get mycoupon =>
      _couponCodeRx.map((e) => e.toMap()).toList();

  @override
  void onReady() {
    _couponCodeRx.bindStream(_getCouponsStream());
  }

  Stream<List<CouponModel>> _getCouponsStream() async* {
    final controller = StreamController<List<CouponModel>>();

    try {
      final coupon = await CouponService().getCouponByCode(couponCode);

      if (coupon != null) {
        _couponCode.add(coupon);
        controller.add(_couponCode);
      }
    } catch (e) {
      print("Error fetching coupon: $e");
      controller.addError(e);
    }

    controller.close();
    yield* controller.stream;
  }

  getCouponByCode() async {
    await CouponService().getCouponByCode(couponCode);
  }
}*/