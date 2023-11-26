

import 'package:epigo_project/models/address_model.dart';
import 'package:epigo_project/screens/User/Adresses/add_edit_adress.dart';
import 'package:epigo_project/screens/User/Adresses/ShippingAddressStateItem.dart';
import 'package:epigo_project/services/firestore_db.dart';
import 'package:epigo_project/styles/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdressList extends StatefulWidget {
  const AdressList({super.key,});

  @override
  State<AdressList> createState() => _AdressListState();
}

class _AdressListState extends State<AdressList> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
  floatingActionButton: FloatingActionButton(
    backgroundColor: Styles.primaryColor,
    onPressed: () => Get.to(() => Add_EditAdress()),
    child: Icon(Icons.add, color: Colors.black),
  ),
  appBar: AppBar(
    title: Text(
      "Adresses",
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
  ),
  body: StreamBuilder<List<Address>>(
    stream: FirestoreDB().getAddress(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child:CircularProgressIndicator.adaptive());
      } else if (snapshot.hasError) {
        return Text('Erreur : ${snapshot.error}');
      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/noaddress.png',
                width: 200,
                height: 200,
              ),
              SizedBox(height: 10),
              Text(
                "Aucune adresse trouvée",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        );
      } else {
        List<Address> adresses = snapshot.data!;
        return SingleChildScrollView(
       child: Column(
  children: [
    Padding(padding: EdgeInsets.all(8)),
    SizedBox(height: 16),
   Padding(
  padding: EdgeInsets.only(left: 16), 
  child: Container(
    constraints: BoxConstraints(
      maxWidth: 383,
    ),
    child: ListView.builder(
      shrinkWrap: true,
      itemCount: adresses.length,
      itemBuilder: (context, index) {
        return ShippingAddressStateItem(
          // selectedAdress: adresses[index].isSelected ?? false,
          adress: adresses[index],
        );
      },
    ),
  ),
),
  ],
),
        );
      }
    },
  ),
);
                
          }
        }
    