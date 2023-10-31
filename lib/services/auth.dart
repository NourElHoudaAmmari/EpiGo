import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epigo_project/controllers/user_controller.dart';
import 'package:epigo_project/models/user_model.dart';
import 'package:epigo_project/repository/authentification_repository.dart';
import 'package:epigo_project/screens/User/Home_Screen/home_screen.dart';
import 'package:epigo_project/screens/User/Welcome/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Auth {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
 // final FirebaseAuth _auth = FirebaseAuth.instance;
 static AuthentificationRepository get instance => Get.find();
  final  _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;
   var isLoading = false.obs;
  final UserController _userController = Get.put(UserController());

    @override
  void onReady(){
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);

  }
    _setInitialScreen(User? user){
    user == null ? Get.offAll(()=> const WelcomeScreen()): Get.offAll(()=>HomeScreen());
  }
  /*Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    _auth.authStateChanges().listen((User? user) {
      if (user != null && googleUser != null) {
        MyUser userModel = MyUser(
            uid: user.uid,
            name: googleUser.displayName,
            email: googleUser.email,
            phone: 'phone',
            address: 'address',
            imageUrl: googleUser.photoUrl,
            isAdmin: false);
        createUser(userModel);

        _userController.myUser = userModel;
      }
    });
    return await _auth.signInWithCredential(credential);
  }*/

  Future createUser(MyUser user) async {
    _db.collection('users').doc(user.id).set(user.toMap());
  }

  Future<MyUser> getUser(String id) async {
    DocumentSnapshot _doc = await _db.collection('users').doc(id).get();
    final userModel = MyUser.fromDocumentSnapshot(snapshot: _doc);
    _userController.myUser = userModel;
    return MyUser.fromDocumentSnapshot(snapshot: _doc);
  }

  Future<void> updateUser(MyUser user) async {
    return await _db.collection('users').doc(user.id).update(user.toMap());
    // DocumentSnapshot _doc = await _db.collection('users').doc(user.uid).update(user.toMap());
  }

  Future signOut() async {
    await _auth.signOut();
    await GoogleSignIn().signOut();
  }
}