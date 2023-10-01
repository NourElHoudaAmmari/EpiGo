import 'package:epigo_project/config/constants.dart';
import 'package:epigo_project/screens/Signup/components/or_divider.dart';
import 'package:epigo_project/screens/Home_Page/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../../../components/already_have_an_account_acheck.dart';
//import 'package:http/http.dart' as http;
import '../../Login/login_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState()=> _SignUpFormState();
}
class _SignUpFormState extends State<SignUpForm>{
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void dispose(){
    emailController.dispose();
    nameController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    super.dispose();
  }
Future<void> addUserDetails(String name, String email, String phone,String address,String password, String profilePick,  bool isBlocked) async {
  final time = DateTime.now().microsecondsSinceEpoch.toString();
  final snapshot = await FirebaseFirestore.instance
      .collection('users')
      .where('email', isEqualTo: email)
      .limit(1)
      .get();
FirebaseFirestore.instance.collection('users').doc(auth.currentUser!.uid);
  if (snapshot.docs.isNotEmpty) {
    Fluttertoast.showToast(
      msg: "un compte existe déjà pour cet e-mail",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP_RIGHT,
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
    throw Exception("Cet e-mail est déjà enregistré, veuillez en utiliser un autre.");
  } else {
    await FirebaseFirestore.instance.collection('users').doc(auth.currentUser!.uid).set({
      'name': name,
      'email': email,
      'phone': phone,
      'address':address,
      'password': password,
      'profilePick': profilePick,
      'id': auth.currentUser!.uid,
      'isBlocked': isBlocked,
    });
  }
}
   String uid = "";
    String name = "";
    String email = "";
    String phoneNumber="";
    String addres="";
    String password = "";
    String profilePick="";
    bool isBlocked = false;
    String? validateEmail(String? email){
  RegExp emailRegex = RegExp(r'^[\w\.-]+@[\w-]+\.\w{2,3}(\.\w{2,3})?$');
  final isEmailValid = emailRegex.hasMatch(email ??'');
  if(!isEmailValid){
    return "Veuillez entrer un email valide";
  }
  return null;
 }
 String? validatePhoneNumber(String? value) {
  if (value == null || value.isEmpty) {
    return 'Veuillez saisir votre numéro de téléphone.';
  } else if (value.length != 8 || !value.trim().contains(RegExp(r'^[0-9]+$'))) {
    return 'Le numéro de téléphone doit contenir exactement 8 chiffres.';
  }

  return null; 
}
bool _isPasswordVisible = false; 
 TextEditingController emailController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController profilePickController = TextEditingController();
    TextEditingController adressController= TextEditingController();
 TextEditingController passwordController = TextEditingController();
   TextEditingController nameController = TextEditingController();
   TextEditingController phoneController = TextEditingController();
   TextEditingController isBlockedController = TextEditingController();
   bool _isNotValidate = false;
   Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );
  return await FirebaseAuth.instance.signInWithCredential(credential);
}
  @override
  Widget build(BuildContext context) {
    return Form(
         key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: nameController,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            cursorColor: Colors.black12,
            onSaved: (name) {},
            decoration: InputDecoration(
          errorText: _isNotValidate ?"Veuillez entrer UserName":null,
              hintText: "NomPrenom",
              prefixIcon: Padding(
                padding: const EdgeInsets.all(defaultPadding),
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
              autovalidateMode: AutovalidateMode.onUserInteraction,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
            onSaved: (email){},
              cursorColor: Colors.black26,
              decoration: InputDecoration(
               errorText: _isNotValidate ?"Veuillez entrer votre email":null,
                hintText: "Adresse email",
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
             child: Icon(Icons.email_outlined,color:Color.fromARGB(255, 189, 188, 188),),
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
              validator: validateEmail,
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
          ),
               Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: IntlPhoneField(
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
              controller: phoneController,
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
          ),
              Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: TextFormField(
              controller: passwordController,
              textInputAction: TextInputAction.done,
            obscureText: !_isPasswordVisible,
              cursorColor: Colors.black26,
              decoration: InputDecoration(
                   errorText: _isNotValidate ?"Veuillez entrer un mot de passe (au moins 6 caractéres)":null,
                hintText: "Mot de passe",
           prefixIcon: Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Icon(
        Icons.lock_outline,
        color: Color.fromARGB(255, 189, 188, 188),
      ),
    ),
    suffixIcon: IconButton(
      // IconButton to toggle password visibility
      onPressed: () {
        setState(() {
          _isPasswordVisible = !_isPasswordVisible;
        });
      },
      icon: Icon(
        _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
        color: Colors.grey, // Adjust the color as needed
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
                 validator: (password)=>password!.length <6
              ? 'Mot de passe doit contenir au moins 6 caractéres':null,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
            ),
          
          const SizedBox(height: defaultPadding / 2),
          ElevatedButton(
             onPressed: () {
    if (_formKey.currentState!.validate()) {
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text,
          )
          .then((UserCredential userCredential) {
            String uid = userCredential.user!.uid;
            addUserDetails(
              nameController.text.trim(),
              emailController.text.trim(),
              phoneController.text.trim(),
              adressController.text.trim(),
              passwordController.text.trim(),
              profilePickController.text.trim(),
              isBlocked,
            );

            // Display a success message to the user
            Fluttertoast.showToast(
              msg: "Compte créé avec succès",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.TOP_RIGHT,
              backgroundColor: Colors.green,
              textColor: Colors.white,
            );

            // Navigate to the login screen after successful registration
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => LoginScreen()));
          })
          .onError((error, stackTrace) {
            // Handle registration error
            Fluttertoast.showToast(
              msg: "Informations d'identification invalides",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.TOP_RIGHT,
              backgroundColor: Colors.red,
              textColor: Colors.white,
            );

            print("Error: ${error.toString()}");
          });
    }
  },
  child: Text("S'inscrire".toUpperCase()),
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
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            login: false,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return LoginScreen();
                  },
                ),
              );
            },
          ),
                    OrDivider (),
            ElevatedButton(
  onPressed: () async{
    try{
   await signInWithGoogle();
   Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
        );
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Une erreur est survenue lors de la connexion avec Google.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      print(e);
    }
  },
  style: ButtonStyle(
    backgroundColor: MaterialStateProperty.all(Colors.white),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: Colors.black),
      ),
    ),
  ),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset(
        "assets/images/icongoogle.png",
        height: 20,
      ),
      SizedBox(width: defaultPadding / 2),
      Text(
        "Se connecter avec Google",
        style: TextStyle(color: Colors.black,fontSize: 16),
      ),
    ],
  ),
),
        ],
      ),
    );
  }

}
