import 'package:cloud_firestore/cloud_firestore.dart';

class Address{
  late String id;
  late String name;
  late String phoneNumber;
  late String address;
  late String codePostale;
  late String region;
    late String? pays;
  late bool? isSelected;

 


 Address({
   required this.id,
    required this.name,
    required this.phoneNumber,
    required this.address,
    required this.codePostale,
    required this.region,
    this.pays,
    this.isSelected =false,


       
  });

 Address.fromDocumentSnapshot({required DocumentSnapshot snapshot}) {
    id = snapshot.id;
    name= snapshot['name'];
   phoneNumber = snapshot['phoneNumber'];
    address= snapshot['address'];
   codePostale = snapshot['codePostale'];
   region = snapshot['region'];
    isSelected= snapshot['isSelected'];
    pays=snapshot['pays'];
 
  }
  Address.fromMap(Map<String, dynamic> map) {
    id = map['id'];
   name = map['name'];
    phoneNumber = map['phoneNumber'];
   address = map['address'];
   codePostale = map['codePostale'];
    region = map['region'];
   isSelected = map['isSelected'];
   pays = map['pays'];
  
  }
  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'phoneNumber': phoneNumber,
        'address': address,
        'codePostale': codePostale,
        'region': region,
        'isSelected': isSelected,
        'pays': pays,
      };

  static fromSnapshot(DocumentSnapshot<Object?> doc) {}
    Address copyWith({
    String? id,
    String? name,
    String? phoneNumber,
    String? address,
    String? codePostale,
    String? region,
    String? pays,
    bool? isSelected,
  }) {
    return Address(
      id: id ?? this.id,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      codePostale: codePostale ?? this.codePostale,
      region: region ?? this.region,
      pays: pays ?? this.pays,
      isSelected: isSelected ?? this.isSelected,
    );
  }

}