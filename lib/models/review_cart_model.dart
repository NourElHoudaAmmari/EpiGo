class ReviewCartModel {
  late String? cartId;
 late String? cartImage;
 late String? cartName;
  late int cartPrice;
  late int cartQuantity;
  var cartUnit;
  ReviewCartModel({
    this.cartId,
    this.cartUnit,
    this.cartImage,
    this.cartName,
    required this.cartPrice,
    required this.cartQuantity,
  });
}