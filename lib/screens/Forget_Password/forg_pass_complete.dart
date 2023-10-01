import 'package:epigo_project/config/constants.dart';
import 'package:epigo_project/screens/Login/login_screen.dart';
import 'package:flutter/material.dart';

class EmailSent extends StatefulWidget {
  const EmailSent({super.key});

  @override
  State<EmailSent> createState() => _EmailSentState();
}

class _EmailSentState extends State<EmailSent> {
 TextEditingController forgetPasswordController=TextEditingController();
  @override
  void dispose(){
    forgetPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
   elevation: 0,
     iconTheme: IconThemeData(color: Colors.black),
  backgroundColor: primaryColor,
  centerTitle: false,
  leading: IconButton(
    icon: Icon(Icons.arrow_back),
    onPressed: () {
      Navigator.pop(context); // Code pour revenir en arrière lorsque le bouton est cliqué
    },
  ),
  title: Text("Mot de passe oublié",style: TextStyle(color: Colors.black),),
      ),
      
      body: SingleChildScrollView(
        
        child: Container(
          child: Column(
            
            children: [
              
              Padding(
                padding: const EdgeInsets.all(40),
             child: Text("L'email a été envoyé!",
             textAlign: TextAlign.center,
             style: TextStyle(fontSize: 20,fontStyle: FontStyle.italic,fontWeight: FontWeight.bold),),
              ),
              SizedBox(height: 10,),
              Text("Veuillez vérifier votre boîte de réception et cliquer sur le lien reçu pour réinitialiser le mot de passe."
              ,style: TextStyle(fontSize: 15,fontStyle: FontStyle.italic),textAlign: TextAlign.center,),
              SizedBox(height: 20,),
              Container(
                padding:const EdgeInsets.all(20),
                alignment: Alignment.center,
                height: 200.0,
              child: Image.asset(
              "assets/images/emailsent.png",),
              ),
              SizedBox(
                height: 30.0,
              ),
          
  Container(
  width: 250,
  height: 50,
  child: MaterialButton(
    onPressed: (){
          Navigator.push(context,
    MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    },
    child: Text("Se Connecter",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
    color: primaryColor,
    textColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0),
    ),
    
  ),
  
),

            ],
          ),
        ),
      ),
    );
  }
}