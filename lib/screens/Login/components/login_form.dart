
import 'package:epigo_project/config/constants.dart';
import 'package:epigo_project/screens/Signup/components/or_divider.dart';
import 'package:epigo_project/screens/Forget_Password/forgot_password.dart';
import 'package:epigo_project/screens/Home_Screen/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../components/already_have_an_account_acheck.dart';
import '../../Signup/signup_screen.dart';
import 'dart:async';
import 'package:fluttertoast/fluttertoast.dart';

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState()=> _LoginFormState();
}
class _LoginFormState extends State<LoginForm>{
  bool isLoggedIn = false;
TextEditingController emailController = TextEditingController();
 TextEditingController passwordController =TextEditingController();
 String? validateEmail(String? email){
  RegExp emailRegex = RegExp(r'^[\w\.-]+@[\w-]+\.\w{2,3}(\.\w{2,3})?$');
  final isEmailValid = emailRegex.hasMatch(email ??'');
  if(!isEmailValid){
    return "Veuillez entrer un email valide";
  }
  return null;
 }
bool _isPasswordVisible = false; 
    bool _isNotValidate = false;
    int loginAttempts =0;
    bool isBlocked = false;
    Timer? timer;
     bool isLoginButtonDisabled = false;
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

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}
void init() {
  super.initState;

  // Get the isLoggedIn value from shared preferences
  SharedPreferences.getInstance().then((prefs) {
    setState(() {
      isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    });

    // If the user is already logged in, navigate to the home page
    if (isLoggedIn) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      });
    }
  });
}
  @override
  void dispose(){
    emailController.dispose();
    passwordController.dispose();
    timer?.cancel();
    super.dispose(); 
  }
  void loginUser() {
    // Check if the user is blocked
    if (isBlocked) {
      Fluttertoast.showToast(
        msg: "Vous avez été bloqué. Veuillez réessayer dans 20 secondes.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      return;
    }
    // Perform the login action
    setState(() {
      isLoginButtonDisabled = true; // Disable the login button
    });

    FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    )
        .then((value) async {
      isLoggedIn = true;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('isLoggedIn', isLoggedIn);
      Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
    }).catchError((error) {
      Fluttertoast.showToast(
        msg: "Les informations d'identification sont invalides.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      print("Error ${error.toString()}");
      // Increment the login attempts
      loginAttempts++;
      // Check if the maximum number of attempts is reached
      if (loginAttempts >= 3) {
        // Block the user for 20 seconds
        blockUser();
      }
      setState(() {
        isLoginButtonDisabled = false; // Enable the login button
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
           controller: emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            cursorColor: Colors.black26,
            onSaved: (email) {},
            decoration: InputDecoration(
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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
           controller: passwordController,
  textInputAction: TextInputAction.done,
  obscureText: !_isPasswordVisible, // Toggle password visibility
  cursorColor: Colors.black26,
  decoration: InputDecoration(
    errorText: _isNotValidate ? "Veuillez entrer votre mot de passe" : null,
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
  validator: (password) =>
      password!.length < 6 ? 'Mot de passe doit contenir au moins 6 caractères' : null,
  autovalidateMode: AutovalidateMode.onUserInteraction,
),
          ),
          Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: InkWell(
                    onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ForgotPasswordScreen()),
        );
      },
                    child: const Text("Mot de passe oublié?",
                        style: TextStyle(
                          color: Color.fromARGB(255, 77, 132, 243),
                          fontSize: 15,
                        )),
                  ),
                ),
          ),
          const SizedBox(height: defaultPadding),
          Hero(
            tag: "login_btn",
            child: ElevatedButton (
              onPressed:(){
                 if (_formKey.currentState!.validate()) {
      if (!isLoginButtonDisabled) {
        loginUser();
      }
    }
              },
              style: ButtonStyle(
    backgroundColor: MaterialStateProperty.all(primaryColor), // Couleur de fond
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0), // Rayon de la bordure
        side: BorderSide(color:primaryColor), // Couleur et épaisseur de la bordure
      ),
    ),
  ),
              child: Text(
                "Se Connecter".toUpperCase(),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return SignUpScreen();
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
  
  void blockUser() {
     setState(() {
      isBlocked = true;
        isLoginButtonDisabled = true;
    });

    // Show the countdown message
    Fluttertoast.showToast(
      msg: "Trop de tentatives de connexion échouées.Veuillez réessayer dans 20 secondes.",
        toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );

    // Start the timer for unblocking the user after 20 seconds
    timer = Timer(Duration(seconds: 20), () {
      setState(() {
        isBlocked = false;
        loginAttempts = 0;
        isLoginButtonDisabled =false;
        timer = null;
      });
    });
  }
 
}
