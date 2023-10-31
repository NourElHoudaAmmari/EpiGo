import 'dart:io';

import 'package:epigo_project/config/constants.dart';
import 'package:epigo_project/repository/authentification_repository.dart';
import 'package:epigo_project/repository/user_repository.dart';
import 'package:epigo_project/screens/Home_Screen/home_screen.dart';
import 'package:epigo_project/screens/Login/login_screen.dart';
import 'package:epigo_project/screens/Profile/components/profile_item.dart';
import 'package:epigo_project/screens/Profile/helpSupport.dart';
import 'package:epigo_project/screens/Profile/settings.dart';
import 'package:epigo_project/screens/Profile/user_details.dart';
import 'package:epigo_project/styles/app_layout.dart';
import 'package:epigo_project/styles/styles.dart';
import 'package:epigo_project/widgets/profile_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:unicons/unicons.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
final _authRepo = Get.put(AuthentificationRepository());
  final _userRepo = Get.put(UserRepository());
     String name = '';
     String email ='';
     String imageUrl = '';
 File? _imageFile;
 @override
void  initState(){
  super.initState;
   getUserData();
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
   var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Styles.primaryColor,
        leading: IconButton(
          onPressed: (){
             Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
          }, icon: const Icon(CupertinoIcons.arrowtriangle_left,color: Colors.black,)),
          title: Text("Profile", style: TextStyle(color: Colors.black,fontStyle: FontStyle.italic)),
    
        ),
      body: ListView(
            children: [
          Gap(AppLayout.getHeight(50)),
          Container(
                height: AppLayout.getHeight(150),
                width: AppLayout.getWidth(150),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Styles.orangeColor,
                ),
                
      child: Center(
  child: CircleAvatar(
    backgroundImage: imageUrl != null
      ? NetworkImage(imageUrl)
      : AssetImage('assets/images/profile_pic.png') as ImageProvider,
    radius: 130.0,
  ),
)),
          Gap(AppLayout.getHeight(20)),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
             name,
                style: Styles.textStyle,
              ),
              Text(
             email,
                style: Styles.headLineStyle4,
              ),
            ],
          ),
          Gap(AppLayout.getHeight(20)),
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              height: AppLayout.getHeight(70),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Styles.secondaryColor.withOpacity(0.1),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(UniconsLine.clipboard_notes,
                          color: Styles.primaryColor),
                      Text('Ordres', style: Styles.textStyle),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(UniconsLine.location_point, color: Styles.primaryColor),
                      Text('Addresses', style: Styles.textStyle),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(UniconsLine.wallet,
                          color: Styles.primaryColor),
                      Text('Paiement', style: Styles.textStyle),
                    ],
                  ),
                ],
              )),
          Gap(AppLayout.getHeight(20)),
          ProfileItem(
            icon: UniconsLine.user,
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: ((context) => UserDetailScreen()))),
            title: 'Détails',
          ),
          ProfileItem(
            icon: UniconsLine.setting,
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: ((context) => Settings()))),
            title: 'Réglages',
          ),
          ProfileItem(
            icon: UniconsLine.info_circle,
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: ((context) => HelpSupport()))),
            title: 'Aide et Assistance',
          ),
          ProfileItem(
            icon: UniconsLine.sign_out_alt,
            onTap: () {
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
                              child: Text('Oui',style: TextStyle(color: primaryColor),)),
                            ],
                          ),
                        );
                      });
          
            },
            title: 'Logout',
          ),
            ],
      )
    );
  }
}