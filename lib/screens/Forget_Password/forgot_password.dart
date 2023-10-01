
import 'package:epigo_project/config/constants.dart';
import 'package:epigo_project/screens/Forget_Password/forg_pass_complete.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';


final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController forgetPasswordController=TextEditingController();
  String? validateEmail(String? email){
  RegExp emailRegex = RegExp(r'^[\w\.-]+@[\w-]+\.\w{2,3}(\.\w{2,3})?$');
  final isEmailValid = emailRegex.hasMatch(email ??'');
  if(!isEmailValid){
    return "Veuillez entrer un email valide";
  }
  return null;
 }
  @override
  void dispose(){
    forgetPasswordController.dispose();
    super.dispose();
  }
  Future passwordReset()async{
    try{
    await FirebaseAuth.instance
    .sendPasswordResetEmail(email: forgetPasswordController.text.trim());
  }on FirebaseAuthException catch (e){
    print(e);
    showDialog(
      context: context,
       builder: (context){
        return AlertDialog(
          content: Text('Mot de passe envoyé! verifier votre email'),
        );
       },
       );
  }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.black),
    backgroundColor: primaryColor,
        centerTitle: false,
        title: Text("Mot de passe oublié",style: TextStyle(color: Colors.black),),
      ),
      
      body: SingleChildScrollView(
        
        child: Container(
          child: Column(
            
            children: [
              
              Padding(
                padding: const EdgeInsets.all(40),
             child: Text('Entrez votre email et nous vous enverrons un lien de réinitialisation de mot de passe',
             textAlign: TextAlign.center,
             style: TextStyle(fontSize: 15,fontStyle: FontStyle.italic),),
              ),
              SizedBox(height: 10,),
              Container(
                padding:const EdgeInsets.all(20),
                alignment: Alignment.center,
                height: 350.0,
                width: 200.0,
                child:Image.asset("assets/images/forgetpassword.png"),
              ),
              SizedBox(
                height: 10.0,
              ),
              Form(
                 key: _formKey,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 30.0),
                  child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                         cursorColor: scaffoldBackgroundColor,
                    controller: forgetPasswordController,
                    decoration: InputDecoration(
                            prefixIcon: Padding(
                    padding: const EdgeInsets.all(defaultPadding),
                         child: Icon(Icons.email_outlined,color:Color.fromARGB(255, 189, 188, 188),),
                  ),
                      hintText: 'Email',
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
                     validator: validateEmail,
              autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
  Container(
  width: 250,
  height: 50,
  child: MaterialButton(
    onPressed: (){
     if (_formKey.currentState!.validate()) {
    passwordReset();
    Navigator.push(context, MaterialPageRoute(builder: (context) => EmailSent()));
  }
},
    child: Text("Soumettre",
    style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
    ),
    color: primaryColor,
    textColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
       side: BorderSide(color:primaryColor), 
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