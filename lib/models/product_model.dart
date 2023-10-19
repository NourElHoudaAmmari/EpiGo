class ProductModel {
  late String productName;
late String productImage;
 late int productPrice;
  late String productId;
late int? productQuantity;
 List<dynamic>productUnit;
 late String productDescription;
  ProductModel(
      {
     this.productQuantity,
      required this.productId,
      required this.productUnit,
      required this.productImage,
      required this.productName,
    required this.productPrice,
    required this.productDescription});
}