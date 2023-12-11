
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epigo_project/config/constants.dart';
import 'package:epigo_project/controllers/adressController.dart';
import 'package:epigo_project/models/address_model.dart';
import 'package:epigo_project/styles/styles.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class Add_EditAdress extends StatefulWidget {
   final bool isEdit;
  final Address? addressToEdit;
  const Add_EditAdress({super.key, this.isEdit = false, this.addressToEdit});

  @override
  State<Add_EditAdress> createState() => _AddAdressState();
}

class _AddAdressState extends State<Add_EditAdress> {
    final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
  final AdressController adressController = Get.put(AdressController());
  final FirebaseAuth auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
 final _phoneController = TextEditingController();
 final _codePostaleController=TextEditingController();
   final _adresseController = TextEditingController();
  final _regionController = TextEditingController();
   final _paysController = TextEditingController();
  bool _isLoading = false;
   String selectedRegion="0";
      bool _isNotValidate = false;
bool _isregionSelected = false;

   // String id = FirebaseFirestore.instance.collection('adresses').doc().id;
     String email ='';
      @override
  void dispose() {
    _nameController.dispose();
    _adresseController.dispose();
    _phoneController.dispose();
    _codePostaleController.dispose();
_regionController.dispose();
_paysController.dispose();
    super.dispose();
  }
    @override
  void initState() {
    super.initState();

    if (widget.isEdit && widget.addressToEdit != null) {
      // Remplissez les champs avec les données de l'adresse à éditer
      _nameController.text = widget.addressToEdit!.name;
      _phoneController.text = widget.addressToEdit!.phoneNumber;
      _adresseController.text = widget.addressToEdit!.address;
      _codePostaleController.text = widget.addressToEdit!.codePostale;
      _regionController.text = widget.addressToEdit!.region;
    }
  }
  
  @override
  Widget build(BuildContext context) {
    String id = widget.isEdit ? widget.addressToEdit!.id : FirebaseFirestore.instance.collection('adresses').doc().id;
    return Scaffold(
          appBar: AppBar(
        title:  Text(
     widget.isEdit ? "Modifier Adresse" : "Ajouter Adresse",
          style: TextStyle(color: Colors.black, fontSize: 20,fontWeight: FontWeight.bold),
        ),
        elevation: 0.0,
        backgroundColor:Styles.primaryColor,
        leading: IconButton(
          icon: Icon(CupertinoIcons.arrowtriangle_left,color: Colors.black,), onPressed: () {  Navigator.of(context).pop();},
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Form(
               key: _formKey,
            child: Column(
            children: [
              TextFormField(controller: _nameController,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            cursorColor: Colors.black12,
            onSaved: (name) {},
            decoration: InputDecoration(
          errorText: _isNotValidate ?"Veuillez entrer UserName":null,
              hintText: "NomPrenom",
              prefixIcon: Padding(
                padding:  EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.person_outline,color:Color.fromARGB(255, 189, 188, 188),
                  ),
              ),
              border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
  borderSide: BorderSide(color: Colors.transparent)
       ),
       focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide(color: Colors.transparent), 
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0), 
      borderSide: BorderSide(color: Colors.transparent), 
    ),
            ),
              validator: (name)=>name!.length <3
              ? 'Le nom doit contenir au moins 3 caractéres':null,
              autovalidateMode: AutovalidateMode.onUserInteraction,),
              SizedBox(height: 12,),
           IntlPhoneField(
               validator: (phoneNumber) {
    if (phoneNumber == null) {
      return 'Veuillez entrer votre numéro de téléphone';
    }

    String phoneNumberStr = phoneNumber.toString();
    
    if (phoneNumberStr.length > 8) {
      return 'Le numéro de téléphone ne doit pas dépasser 8 chiffres';
    }
    
    return null;
  },
  autovalidateMode: AutovalidateMode.onUserInteraction,
            initialCountryCode: "TN",
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.next,
              cursorColor: Colors.black26,
              decoration: InputDecoration(
               errorText: _isNotValidate ?"Veuillez entrer votre numero de telephone":null,
                hintText: "Numero de telephone",
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
             child: Icon(Icons.numbers,color:Color.fromARGB(255, 189, 188, 188),),
             
                ),
                
                         border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
  borderSide: BorderSide(color: Colors.transparent)
       ),
       focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide(color: Colors.transparent), 
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0), 
      borderSide: BorderSide(color: Colors.transparent), 
    ),
              ), 
                 
             onChanged: (phone) {
          setState(() {
            _isNotValidate = false;
          });
        },
            ),
               SizedBox(height: 12,),
                  TextFormField(
            controller: _adresseController,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            cursorColor: Colors.black12,
            onSaved: (adresse) {},
            decoration: InputDecoration(
          errorText: _isNotValidate ?"Veuillez entrer adresse":null,
              hintText: "Adresse",
              prefixIcon: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.location_city_outlined,color:Color.fromARGB(255, 189, 188, 188),
                  ),
              ),
              border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
  borderSide: BorderSide(color: Colors.transparent)
       ),
       focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide(color: Colors.transparent), 
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0), 
      borderSide: BorderSide(color: Colors.transparent), 
    ),
            ),
              validator: (adresse)=>adresse!.length <3
              ? "L'adresse doit contenir au moins 3 caractéres":null,
              autovalidateMode: AutovalidateMode.onUserInteraction,
          ),
         SizedBox(height: 12,),
Row(
  children: [
     Expanded(
                      child: TextFormField(
                        controller: _codePostaleController,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        cursorColor: Colors.black12,
                        onSaved: (codePostale) {},
                        decoration: InputDecoration(
                          errorText: _isNotValidate ? "Veuillez entrer un code postal" : null,
                          hintText: "Code Postal",
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(defaultPadding),
                            child: Icon(
                              Icons.person_outline,
                              color: Color.fromARGB(255, 189, 188, 188),
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                        ),
                        validator: (codePostale) {
                     if (codePostale!.isEmpty) {
                            return 'Veuillez entrer un code postal';
                          }
                          if (codePostale.length != 4) {
                            return 'Le code postal doit avoir exactement 4 chiffres';
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                         child: TextFormField(
        controller: _regionController,
        readOnly: true,
        onTap: () {
          // Ouvrir la liste déroulante ou une boîte de dialogue pour sélectionner la région
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('regions').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator();
                  }
                  final regions = snapshot.data?.docs.reversed.toList();
                  return ListView(
                    children: regions!.map((region) {
                      final regionName = region["libelle"];
                      return ListTile(
                        title: Text(regionName),
                        onTap: () {
                          setState(() {
                            selectedRegion = regionName;
                            _isregionSelected = true;
                            _regionController.text = regionName;
                          });
                          Navigator.pop(context);
                        },
                      );
                    }).toList(),
                  );
                },
              );
            },
          );
        },
        decoration: InputDecoration(
          hintText: "Région",
         // errorText: !_isNotValidate? "Veuillez sélectionner une région" : null,
          prefixIcon: Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: Icon(
              Icons.maps_home_work,
              color: Color.fromARGB(255, 189, 188, 188),
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: Colors.transparent),
          ),
        ),
              validator: (_isregionSelected) {
                     if (_isregionSelected!.isEmpty) {
                            return 'Veuillez sélectionner une région';
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
      ),
    ),
                  ],
                ),
                 SizedBox(height: 12,),
               TextFormField(   controller: _paysController,
                        enabled: false,
                        decoration: InputDecoration(
                          hintText: "Tunisie",
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(defaultPadding),
                            child: Icon(
                              Icons.location_on,
                              color: Color.fromARGB(255, 189, 188, 188),
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                        ),
                      ),
     SizedBox(height: 20,),
SizedBox(
  width: double.infinity,
  child: ElevatedButton(
  onPressed: () async {
    _analytics.logEvent(name: 'button_adding_shipping_adresse_clicked',
    parameters: {'screen':'CartScreen'},
    );
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      final name = _nameController.text.trim();
      final phoneNumber = _phoneController.text.trim();
      final address = _adresseController.text.trim();
      final codePostal = _codePostaleController.text.trim();
      final region = selectedRegion;
      final pays = "Tunisie"; // Vous pouvez ajouter la logique pour le pays si nécessaire

      if (widget.isEdit) {
        // Mode de modification
        final newAddress = Address(
          id: widget.addressToEdit!.id, 
          name: name,
          phoneNumber: phoneNumber,
          address: address,
          codePostale: codePostal,
          region: region,
          pays: pays,
         // isSelected: isSelected,
        );

        await adressController.updateAddress(widget.addressToEdit!.id, newAddress);
        Get.snackbar(
          'Adresse mise à jour avec succès',
          '$address',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Styles.whiteColor,
          duration: const Duration(seconds: 2),
        );
      } else {
        // Mode d'ajout
        final newAddress = Address(
          id: id, 
          name: name,
          phoneNumber: phoneNumber,
          address: address,
          codePostale: codePostal,
          region: region,
          pays: pays,
        );

        await adressController.addAddress(newAddress);
        Get.snackbar(
          'Adresse ajoutée avec succès',
          '$address',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Styles.whiteColor,
          duration: const Duration(seconds: 2),
        );
      }

      _formKey.currentState!.reset();
     Navigator.of(context).pop();
    } else {
    }
  },
child: Text(widget.isEdit ? "Modifier" : "Ajouter".toUpperCase(), style: Styles.headLineStyle4),
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(primaryColor),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: BorderSide(color: primaryColor),
        ),
      ),
    ),
),
),
                ],
               ),
          ),
        ),
      ),
    );
  }
}