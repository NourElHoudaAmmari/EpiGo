class ProductModel {
  late String? productName;
late String? productImage;
 late int? productPrice;
  late String? productId;
late int? productQuantity;
  List<dynamic>productUnit;
  ProductModel(
      {
       this.productQuantity,
      this.productId,
      required this.productUnit,
      this.productImage,
      this.productName,
    this.productPrice});
}