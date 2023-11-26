import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  late String id;
  late String title;
  late double price;
  late int discount;
  late String category;
  late String unit;
  late String description;
  late String imageUrl;
  late bool availableInStock;
  late int? quantity;
  late int? stockQuantity;



  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.discount,
    required this.category,
    required this.unit,
    required this.description,
    required this.imageUrl,
    this.quantity,
    required this.availableInStock,    
    this.stockQuantity,

  });

  Product.fromDocumentSnapshot({required DocumentSnapshot snapshot}) {
    id = snapshot.id;
    title = snapshot['title'];
    price = snapshot['price'];
    discount = snapshot['discount'];
    category = snapshot['category'];
    unit = snapshot['unit'];
    description = snapshot['description'];
    imageUrl = snapshot['imageUrl'];
    quantity = snapshot['quantity'];
    availableInStock = snapshot['availableInStock'];
    stockQuantity = snapshot['stockQuantity'];
  
 
  }
  Product.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    title = map['title'];
    price = map['price'];
    discount = map['discount'];
    category = map['category'];
    unit = map['unit'];
    description = map['description'];
    imageUrl = map['imageUrl'];
    quantity = map['quantity'];
    availableInStock = map['availableInStock'];
    stockQuantity = map['stockQuantity'];

  
  }
  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'price': price,
        'discount': discount,
        'category': category,
        'unit': unit,
        'description': description,
        'imageUrl': imageUrl,
        'quantity': quantity,
        'availableInStock': availableInStock,
        'stockQuantity': stockQuantity,
      
     
      };
 factory Product.fromQueryDocumentSnapshot(QueryDocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return Product(
      // Initialize fields based on the data from the snapshot
      id: snapshot.id,
      title: data['title'],
      price: data['price'],
      discount: data['discount'],
      category: data['category'],
      unit: data['unit'],
      description: data['description'],
      imageUrl: data['imageUrl'],
      quantity: data['quantity'],
      availableInStock: data['availableInStock'],
      stockQuantity: data['stockQuantity'],
    );
  }
  static fromSnapshot(DocumentSnapshot<Object?> doc) {}
}