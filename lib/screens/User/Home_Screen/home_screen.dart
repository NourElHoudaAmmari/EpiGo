import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epigo_project/controllers/cart_controller.dart';
import 'package:epigo_project/controllers/category_controller.dart';
import 'package:epigo_project/controllers/product_controller.dart';
import 'package:epigo_project/controllers/search_controller.dart';
import 'package:epigo_project/controllers/user_controller.dart';
import 'package:epigo_project/screens/User/Cart/cart_screen.dart';
import 'package:epigo_project/screens/User/Home_Screen/drawer_side.dart';
import 'package:epigo_project/screens/User/Product/all_product.dart';
import 'package:epigo_project/screens/User/Product/category_product.dart';
import 'package:epigo_project/screens/User/Product/search_product.dart';
import 'package:epigo_project/screens/User/Profile/profile_screen.dart';
import 'package:epigo_project/screens/User/Search/search.dart';
import 'package:epigo_project/screens/User/Wishlist/favorite_screen.dart';
import 'package:epigo_project/styles/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:badges/badges.dart' as badges;




class HomeScreen extends StatefulWidget {
 
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool searchState = false;
  bool _isBlocked = false;
   ProductController productController = Get.put(ProductController());
 CategoryController categoryController = Get.put(CategoryController());
UserController userController = Get.put(UserController());
 SearchController searchController = Get.put(SearchController());
CartController carrtController = Get.put(CartController());
  @override
  void initState(){
   
    super.initState();
  }
Future<void> fetchBlockedStatus() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (userSnapshot.exists) {
        setState(() {
          _isBlocked = userSnapshot.get('isBlocked') ?? false;
        });
      }
    }
  }
  @override
  Widget build(BuildContext context) {
  
 SearchController searchController = Get.put(SearchController());
     return DefaultTabController(
          //backgroundColor: Color.fromARGB(255, 219, 219, 219),
      length: 4,
      child: Scaffold(
        backgroundColor: Colors.grey,
        drawer: DrawerSide(),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
        title: Text('EpiGo',style:GoogleFonts.lobster(textStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20)) ),
        actions: <Widget>[
    IconButton(
      icon: Icon(
        Icons.notifications_active_outlined, // L'icône de notification que vous souhaitez utiliser
        color: Colors.black, // Couleur de l'icône
      ),
      onPressed: () {
        // Action à effectuer lors de l'appui sur l'icône de notification
      },
    ),
  ],
        backgroundColor: Color(0xffd6b738),
        bottom: TabBar(
                
            isScrollable: true,
            indicatorColor: Styles.marronColor,
            indicatorSize: TabBarIndicatorSize.label,
            tabs: const [
              Tab(text: 'Tous'),
              Tab(text: 'Fruits'),
              Tab(text: 'Légumes'),
              Tab(text: 'Herbes'),
            ],
          ),
      ),
           body: 
           Obx(
          () => TabBarView(
            children: [
              searchController.searchText == ''
                  ? AllProducts()
                  : SearchProduct(),
              searchController.searchText == ''
                  ? CategoryProduct(category: 'Fruits')
                  : SearchProduct(),
              searchController.searchText == ''
                  ? CategoryProduct(category: 'Légumes')
                  : SearchProduct(),
              searchController.searchText == ''
                  ? CategoryProduct(category: 'Herbes')
                  : SearchProduct(),
            
            ],
          ),
        ),
     
bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        color: Colors.grey[100],
        child: IconTheme(
          data: IconThemeData(color: Colors.black),
         child: Padding(padding: const EdgeInsets.all(12.0),
         child: Row(
mainAxisAlignment: MainAxisAlignment.spaceAround,
children: [
  IconButton(
    
    onPressed:(){
      Navigator.push(context,
    MaterialPageRoute(builder: (context) => HomeScreen()),
  );
    },
   icon: const Icon(Icons.home_outlined),
//selectedIcon: Icon(Icons.home_filled),
   ),
      const SizedBox(width: 24,),
  IconButton(
    onPressed: (){
       if (_isBlocked) {
      final snackBar = SnackBar(
  content: Text(
  "cet utilisateur a été désactivé, veuillez contacter le support pour obtenir de l'aide",
    style: TextStyle(color: Colors.white),
  ),
  backgroundColor: Colors.red, // Définir la couleur d'arrière-plan comme rouge
);
ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }else{
          Navigator.push(context,
    MaterialPageRoute(builder: (context) => FavoritesScreen()),
  );
    }
    },
    icon: const Icon(Icons.favorite_border_outlined),
    //selectedIcon: Icon(Icons.favorite),
    ),
    const SizedBox(width: 24,),
     IconButton(
      onPressed: (){
         if (_isBlocked) {
      final snackBar = SnackBar(
  content: Text(
  "cet utilisateur a été désactivé, veuillez contacter le support pour obtenir de l'aide",
    style: TextStyle(color: Colors.white),
  ),
  backgroundColor: Colors.red, // Définir la couleur d'arrière-plan comme rouge
);
ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }else{
       Navigator.push(context,
    MaterialPageRoute(builder: (context) =>ProductSearchPage()),
  );
    }
      },
    icon: const Icon(Icons.search_rounded),
    ),
    const SizedBox(width: 24),
     IconButton(
      onPressed: (){
         if (_isBlocked) {
      final snackBar = SnackBar(
  content: Text(
  "cet utilisateur a été désactivé, veuillez contacter le support pour obtenir de l'aide",
    style: TextStyle(color: Colors.white),
  ),
  backgroundColor: Colors.red, // Définir la couleur d'arrière-plan comme rouge
);
ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }else{
                 Navigator.push(context,
    MaterialPageRoute(builder: (context) => CartScreen()),
  );
    }
      },
    icon: BadgeIcon(),
    
    ),
    const SizedBox(width: 24),
     IconButton(onPressed: (){
      Navigator.push(context,
    MaterialPageRoute(builder: (context) => ProfileScreen()),
  );
     },
    icon: const Icon(Icons.person_outline),
    ),

],
         ),
         ),
         )
      ),

      ),
    );
  }
}
class BadgeIcon extends StatelessWidget {
  BadgeIcon({
    Key? key,
  }) : super(key: key);

  final CartController cartController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() => cartController.products.length > 0
        ? badges.Badge(
            // Utilisez le widget Badge avec le paramètre badgeContent pour afficher le nombre de produits dans le panier.
            badgeContent: Text(cartController.products.length.toString(),
                style: TextStyle(color: Styles.bgColor)), // Ajoutez le style souhaité
            child: Icon(Icons.shopping_bag_outlined),
          )
        : Icon(Icons.shopping_bag_outlined));
  }
}