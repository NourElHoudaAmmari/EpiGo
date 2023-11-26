

import 'package:epigo_project/models/address_model.dart';
import 'package:epigo_project/services/firestore_db.dart';
import 'package:epigo_project/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdressController extends GetxController{
  final _addresses = <Address>[].obs;
  List<Address> get addressList => _addresses;
    List<Map<String, dynamic>> get myAdress => _addresses.map((e) => e.toMap()).toList();

  @override
  void onReady() {
    _addresses.bindStream(FirestoreDB().getAddress());
  }
Future addAddress(Address address) async {
    await FirestoreDB().addAddress(address);

   return;
   
}
Future updateAddress(String addressId, Address newAddress) async {
    await FirestoreDB().UpdateAddress(addressId, newAddress);

  }

  Future deleteAddress(String addressId) async {
    await FirestoreDB().deleteAddress(addressId);

 SnackBar(
    backgroundColor: Colors.red,
    content: Text(
      'Adresse supprimée avec succés',
      style: TextStyle(color: Colors.white),
      
    ),
  );
  }

  getAddresses()async {
await FirestoreDB().getAddress();
  }
}