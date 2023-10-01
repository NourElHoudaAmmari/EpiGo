import 'package:epigo_project/config/constants.dart';
import 'package:epigo_project/repository/authentification_repository.dart';
import 'package:epigo_project/screens/Login/login_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryColor,
        centerTitle: false,
        title: Text("Accueil"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Welcome"),
            SizedBox(height: 20), // Espacement entre le texte et le bouton
            ElevatedButton(
              onPressed: () {
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
                              child: Text('Oui',style: TextStyle(color: textColor),)),
                            ],
                          ),
                        );
                      });
              },
              child: Text("Mon Bouton"),
            ),
          ],
        ),
      ),
    );
  }
}