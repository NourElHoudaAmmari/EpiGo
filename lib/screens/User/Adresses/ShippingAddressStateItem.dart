import 'package:epigo_project/config/constants.dart';
import 'package:epigo_project/controllers/adressController.dart';
import 'package:epigo_project/models/address_model.dart';
import 'package:epigo_project/screens/User/Adresses/add_edit_adress.dart';
import 'package:epigo_project/services/firestore_db.dart';
import 'package:epigo_project/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShippingAddressStateItem extends StatefulWidget {
    final Address adress;
  const ShippingAddressStateItem({super.key, required this.adress});
//final bool selectedAdress;


  @override
  State<ShippingAddressStateItem> createState() => _ShippingAddressStateItemState();
}

class _ShippingAddressStateItemState extends State<ShippingAddressStateItem> {
  late Address currentAddress;
  void setDefaultAddress() async {
    await FirestoreDB().deselectAllAddresses(currentAddress.id); // Désélectionnez toutes les autres adresses
    final newAddress = currentAddress.copyWith(isSelected: true);
    await FirestoreDB().UpdateAddress(currentAddress.id, newAddress);
  }
  final AdressController adressController = Get.put(AdressController());
  late bool checkedValue;
  @override
  void initState() {
    super.initState();
       currentAddress = widget.adress; // Stockez l'adresse actuelle dans la variable
    checkedValue = currentAddress.isSelected!;
  }
  @override
  Widget build(BuildContext context) {
      return InkWell(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: const [BoxShadow(color: Colors.black54, blurRadius: 2)]),
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child:   Text('${widget.adress.name}',maxLines: 1,
              overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Styles.textColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      
                      ],
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      "${widget.adress.address}, ${widget.adress.region}, ${widget.adress.pays},${widget.adress.codePostale} ",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Styles.textColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text('+(216) ${widget.adress.phoneNumber}',maxLines: 1,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Styles.secondaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                 CheckboxListTile(
                      title: Text("Adresse de livraison par défaut", style: Styles.headLineStyle6, textAlign: TextAlign.left,),
                      value: checkedValue,
                      onChanged: (newValue) async {
                        setState(() {
                          checkedValue = newValue!;
                        });
                        if (newValue!) {
                          setDefaultAddress();
                        }
                      },
                      activeColor: Styles.primaryColorDark,
                      contentPadding: EdgeInsets.zero,
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                IconButton(
                  onPressed: () async {
                 Get.to(() =>Add_EditAdress(isEdit: true, addressToEdit: widget.adress));
                  },
                  icon: Icon(
                    Icons.edit,
                    color: Styles.primaryColorDark,
                    size: 20,
                  ),
                ),
                IconButton(
                    onPressed: () {
                      showDialog(
                      context: context,
                      builder: (context){
                        return Container(
                          child: AlertDialog(
                         title: Text('Confirmation'),
              content: Text('Voulez-vous supprimer cette adresse ?'),
                            actions: [
                       TextButton(onPressed:(){
                        Navigator.pop(context);
                              }, 
                              child: Text('Non')),
                              TextButton(
                             onPressed: () {
                adressController.deleteAddress(widget.adress.id) 
                    .then((value) {
                  Navigator.pop(context);
                   SnackBar(
    backgroundColor: Colors.red,
    content: Text(
      'Adresse supprimée avec succés',
      style: TextStyle(color: Colors.white),
      
    ),
  );
                  
          });
                              }, 
                              child: Text('Oui',style: TextStyle(color: primaryColor,fontWeight: FontWeight.bold),)),
                            ],
                          ),
                        );
                      });
                    },
                    icon: Image.asset(
                      "assets/images/close.png",
                      width: 15,
                      height: 15,
                    )),

              ],
            )
          ],
        ),
      ),
    );
  }
}