import 'package:epigo_project/Utils/app_routes.dart';
import 'package:epigo_project/config/constants.dart';
import 'package:epigo_project/controllers/cart_controller.dart';
import 'package:epigo_project/controllers/favorite_controller.dart';
import 'package:epigo_project/controllers/product_controller.dart';
import 'package:epigo_project/controllers/search_controller.dart';
import 'package:epigo_project/controllers/user_controller.dart';
import 'package:epigo_project/repository/authentification_repository.dart';
import 'package:epigo_project/screens/Login/login_screen.dart';
import 'package:epigo_project/screens/Welcome/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:provider/provider.dart';
import 'package:epigo_project/controllers/profile_controller.dart';
void main()async {
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
 SearchController searchController = Get.put(SearchController());
    ProductController productController = Get.put(ProductController());
 CartController cartController = Get.put(CartController());
  FavoriteController favoriteController = Get.put(FavoriteController());
UserController userController =Get.put(UserController());
ProfileController profileController = Get.put(ProfileController());

 @override
  Widget build(BuildContext context){
        final userController = Get.put(UserController());
     return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EpiGo',
      theme: ThemeData(
          primaryColor: primaryColor,
          scaffoldBackgroundColor: Colors.white,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              primary: primaryColor,
              shape: const StadiumBorder(),
              maximumSize: const Size(double.infinity, 56),
              minimumSize: const Size(double.infinity, 56),
            ),
          ),
          inputDecorationTheme: const InputDecorationTheme(
            filled: true,
            fillColor: kPrimaryLightColor,
           // iconColor: scaffoldBackgroundColor,
           // prefixIconColor: kPrimaryColor,
            contentPadding: EdgeInsets.symmetric(
                horizontal: defaultPadding, vertical: defaultPadding),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              borderSide: BorderSide.none,
            ),
          )),
          
     home: const WelcomeScreen(),
        initialBinding: BindingsBuilder(() {
        Get.put(AuthentificationRepository());
   
      }),
        getPages: appRoutes(),
     
    );   

}
}
