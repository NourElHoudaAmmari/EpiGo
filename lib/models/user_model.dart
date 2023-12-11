import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
class MyUser{
late final String? id;
late final String? name;
late final  String? email;
late final String? phone;
late final String? address;
late final String? password;
late final String? profilePick;
late final bool isBlocked;
  String? stripeCustomerId;

     
 static MyUser? currentUser;
  MyUser({
    this.id,
       this.name,
      this.email, 
         this.phone, 
        this.address, 
        this.password,
       this.profilePick,
    this.isBlocked=false,
    this.stripeCustomerId,
    
  
    
     });
     
toJson(){
  return {
    "name":name,
  "email":email,
   "phone":phone,
   "address":address,
    "password":password,
      "profilePick":profilePick,
       "isBlocked":isBlocked,
       "stripeCustomerId":stripeCustomerId,

    };
}
 Map<String, dynamic> toMap() => {
        'uid': id,
        'name': name,
        'email': email,
         'phone': phone,
          'address':address,
           'password':password,
        'profilePick':profilePick,   
          'isBlocked':isBlocked,
          'stripeCustomerId':stripeCustomerId,
          
       
      };

factory MyUser.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document){
  final data = document.data()!;
  return MyUser(
     id:document.id,
       name: data["name"],
    email:data["email"],
     phone: data["phone"],
      address: data["address"],
    password: data["password"],
      profilePick: data["profilePick"],
      isBlocked: data["isBlocked"],
      stripeCustomerId: data['stripeCustomerId'],

     );
}
 
  MyUser.fromDocumentSnapshot({required DocumentSnapshot snapshot}) {
    id = snapshot['uid'];
    name = snapshot['name'];
    email = snapshot['email'];
      phone = snapshot['phone'];
        address = snapshot['address'];
            password = snapshot['password'];
   profilePick= snapshot['profilePick'];
    isBlocked = snapshot['isBlocked'];
    stripeCustomerId =snapshot['stripeCustomerId'];

  }

MyUser.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        email = json['email'],
        name = json['name'],
        phone = json['phone'],
        address = json['address'],
        password = json['password'],
        profilePick = json['profilePick'],
        isBlocked = json['isBlocked'] ,
         stripeCustomerId = json['stripeCustomerId'];


        
      
}