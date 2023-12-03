

import 'package:epigo_project/controllers/cart_controller.dart';
import 'package:epigo_project/screens/User/Home_Screen/home_screen.dart';
import 'package:epigo_project/screens/User/Login/login_screen.dart';
import 'package:epigo_project/screens/User/Welcome/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';


class AuthentificationRepository extends GetxController{
 CartController cartController = Get.find();

  AuthentificationRepository();
  static AuthentificationRepository get instance => Get.find();
  
  final  _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;
   var isLoading = false.obs;

  @override
  void onReady(){
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);

  }

  _setInitialScreen(User? user){
    user == null ? Get.offAll(()=>  LoginScreen()): Get.offAll(()=>HomeScreen());
  }

  Future<String?> createUserWithEmailAndPassword(String email,String password)async{
try{
      await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
         password: password.trim(),
         );
         return "Success";
}on FirebaseAuthException catch (e){
  return e.message;
}catch(e){
  rethrow;
}
  }
  
   Future<String?> loginWithEmailAndPassword(String email,String password)async{
  try{
      await _auth.signInWithEmailAndPassword(
        email: email.trim(), 
      password: password.trim(),
      );
   return "Success";
}on FirebaseAuthException catch (e){
  return e.message;
}catch(e){
  rethrow;
}
  }
  
  

Future<String?> logout() async {
  try{
  print('Logout button pressed');
  await _auth.signOut();
  return "Success";
}on FirebaseAuthException catch (e){
 return e.message;
}catch(e){
  rethrow;
}
}
}