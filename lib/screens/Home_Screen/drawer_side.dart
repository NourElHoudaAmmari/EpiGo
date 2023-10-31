import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epigo_project/repository/authentification_repository.dart';
import 'package:epigo_project/repository/user_repository.dart';
import 'package:epigo_project/screens/Cart/cart_screen.dart';
import 'package:epigo_project/screens/Home_Screen/home_screen.dart';
import 'package:epigo_project/screens/Login/components/login_form.dart';
import 'package:epigo_project/screens/Login/login_screen.dart';
import 'package:epigo_project/screens/Profile/profile_screen.dart';
import 'package:epigo_project/screens/Wishlist/favorite_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';

import '../../config/constants.dart';
class DrawerSide extends StatefulWidget {
  const DrawerSide({super.key});

  @override
  State<DrawerSide> createState() => _DrawerSideState();
}

class _DrawerSideState extends State<DrawerSide> {
  

   final _authRepo = Get.put(AuthentificationRepository());
  final _userRepo = Get.put(UserRepository());
     String name = '';
     String email ='';
       String imageUrl = '';
 File? _imageFile;
 bool _isBlocked = false;
       @override
void initState(){
  super.initState;
    getUserData();
    fetchBlockedStatus();
  }
  Future<void> fetchBlockedStatus() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (userSnapshot.exists) {
        setState(() {
          _isBlocked = userSnapshot.get('isBlocked') ?? false;
        });
      }
    }
  }
  
void getUserData() async {
    final userEmail = _authRepo.firebaseUser.value?.email;
    if (userEmail != null) {
      final user = await _userRepo.getUserDetails(userEmail);
      setState(() {
        name = user.name!;
        email = userEmail;
        imageUrl = user.profilePick!;
      });
    } 
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      //backgroundColor: primaryColor,
        child: Column(
        children:<Widget> [
Container(
  width: double.infinity,
  padding: EdgeInsets.all(20),
  color: primaryColor,
  child: Center(
    child: Column(
      children: <Widget> [
        Container(
          width: 100,
          height: 100,
          margin: EdgeInsets.only(
            top: 30,
            bottom: 10,
          ),
            child: ClipRRect(
  borderRadius: BorderRadius.circular(150),
  child: Container(
    width: double.infinity,
    height: double.infinity,
    decoration: BoxDecoration(
      image: DecorationImage(
        image: _imageFile != null
            ? FileImage(_imageFile!)
            : imageUrl.isNotEmpty
                ? NetworkImage(imageUrl)
                : AssetImage('assets/images/profile_pic.png') as ImageProvider,
        fit: BoxFit.cover,
      ),
    ),
  ),
)

        ),
    
        Text(  
  name,
   style: TextStyle(
   fontSize: 20,
  color: Colors.black,
 fontWeight: FontWeight.bold,),
    ),
 Text(  
email,
   style: TextStyle(
    color: Colors.black,
   fontWeight: FontWeight.normal,),
     ),
      ],
    ),
  ),
),
ListTile(
  leading: Icon(Icons.home_outlined),
  title: Text(
    "Page d'accueil",
    style: TextStyle(
      fontSize: 18,
    ),
  ),
  onTap:(){
     Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
  },
),
ListTile(

  leading: Icon(Icons.shop_outlined),
  title: Text(
    "Panier",
    style: TextStyle(
      fontSize: 18,
    ),
  ),
  onTap:(){
     Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>CartScreen()),
            );
  },
),
ListTile(
  leading: Icon(Icons.person_outlined),
  title: Text(
    'Profile',
    style: TextStyle(
      fontSize: 18,
    ),
  ),
  onTap: (){
      Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfileScreen()),
            );
  },
),
ListTile(
  leading: Icon(Icons.notifications_outlined),
  title: Text(
    'Notifications',
    style: TextStyle(
      fontSize: 18,
    ),
  ),
  onTap: (){},
),
ListTile(
  leading: Icon(Icons.star_outline),
  title: Text(
    'Note et Avis',
    style: TextStyle(
      fontSize: 18,
    ),
  ),
  onTap: (){ },
),
ListTile(
  leading: Icon(Icons.favorite_outline),
  title: Text(
    'Favoris',
    style: TextStyle(
      fontSize: 18,
    ),
  ),
  onTap: (){
     Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FavoritesScreen()),
            );
  },
),
ListTile(
  leading: Icon(Icons.power_settings_new),
  title: Text(
    'Se déconnecter',
    style: TextStyle(
      fontSize: 18,
      color: Colors.red,
    ),
  ),
  onTap:  (){
                    showDialog(
                      context: context,
                      builder: (context){
                        return Container(
                          child: AlertDialog(
                            title: Text('Voulez-vous déconnectez ?'),
                            actions: [
                       TextButton(onPressed:(){
                        Navigator.pop(context);
                              }, 
                              child: Text('Non')),
                              TextButton(onPressed:(){
          print("pressed here");
          AuthentificationRepository.instance.logout().
                      then((value) {
            print("signed out");
            Navigator.push(context, 
            MaterialPageRoute(builder: (context)=>LoginScreen()));
          });
                              }, 
                              child: Text('Oui',style: TextStyle(color: primaryColor,fontWeight: FontWeight.bold),)),
                            ],
                          ),
                        );
                      });
          
                  }
),

        ],
      ),
    );
  }
}