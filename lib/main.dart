import 'package:epigo_project/Utils/app_routes.dart';
import 'package:epigo_project/config/constants.dart';
import 'package:epigo_project/controllers/cart_controller.dart';
import 'package:epigo_project/controllers/favorite_controller.dart';
import 'package:epigo_project/controllers/product_controller.dart';
import 'package:epigo_project/controllers/search_controller.dart';
import 'package:epigo_project/controllers/theme_controller.dart';
import 'package:epigo_project/controllers/user_controller.dart';
import 'package:epigo_project/repository/authentification_repository.dart';
import 'package:epigo_project/screens/User/Home_Screen/home_screen.dart';
import 'package:epigo_project/screens/User/Login/login_screen.dart';
import 'package:epigo_project/screens/User/Welcome/welcome_screen.dart';
import 'package:epigo_project/stripe_payment/stripe_keys.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import'package:firebase_core/firebase_core.dart';
import 'package:epigo_project/controllers/profile_controller.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

void main()async {
    Get.put(ThemeController());
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
   await FirebasePerformance.instance;
 //GetIt.I.registerSingleton<FirebaseAnalytics>(FirebaseAnalytics());
    Stripe.publishableKey = ApiKeys.publishableKey;
      FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  runApp(MyApp());
 //  FirebaseCrashlytics.instance.crash();
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
 SearchControllerapp searchController = Get.put(SearchControllerapp());
    ProductController productController = Get.put(ProductController());
 CartController cartController = Get.put(CartController());
  FavoriteController favoriteController = Get.put(FavoriteController());
UserController userController =Get.put(UserController());
ProfileController profileController = Get.put(ProfileController());
  final ThemeController themeController = Get.find();
final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
 final FirebaseAnalyticsObserver _observer =
      FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance);


 @override
  Widget build(BuildContext context){
     return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EpiGo',
      theme:// themeController.theme,
      ThemeData(
          primaryColor: primaryColor,
          scaffoldBackgroundColor: Colors.white,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              elevation: 0, 
              backgroundColor: primaryColor,
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
          navigatorObservers: [_observer],     
     home: LoginScreen(),
        initialBinding: BindingsBuilder(() {
        Get.put(AuthentificationRepository());
   
      }),
        getPages: appRoutes(),
     
    );   

}
}
