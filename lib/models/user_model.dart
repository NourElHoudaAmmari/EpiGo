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

  }

}