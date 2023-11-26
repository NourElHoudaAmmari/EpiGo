import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epigo_project/config/constants.dart';
import 'package:epigo_project/controllers/cart_controller.dart';
import 'package:epigo_project/controllers/favorite_controller.dart';
import 'package:epigo_project/controllers/product_controller.dart';
import 'package:epigo_project/models/product_model.dart';
import 'package:epigo_project/screens/User/Cart/cart_screen.dart';
import 'package:epigo_project/screens/User/Home_Screen/home_screen.dart';
import 'package:epigo_project/screens/User/Profile/profile_screen.dart';
import 'package:epigo_project/screens/User/Search/search.dart';
import 'package:epigo_project/screens/User/Product/product_card.dart';
import 'package:epigo_project/services/firestore_db.dart';
import 'package:epigo_project/styles/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart' as badges;

class FavoritesScreen extends StatefulWidget {
  FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
    late FavoriteController _service;
  ProductController productController = Get.find(); // Assurez-vous que ProductController est correctement configuré
  FavoriteController favoriteController = Get.put(FavoriteController());
  bool _isBlocked = false;
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
 void  initState(){
  super.initState;
    _service = FavoriteController();
      fetchBlockedStatus();
 
 }
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
        appBar: AppBar(
        title:  Text(
          "Mes favoirs",
          style: TextStyle(color: Colors.black, fontSize: 20,fontWeight: FontWeight.bold),
        ),
        elevation: 0.0,
        backgroundColor:Styles.primaryColor,
        leading: IconButton(
          icon: Icon(CupertinoIcons.arrowtriangle_left,color: Colors.black,), onPressed: () {  Navigator.of(context).pop();},
        ),
      ),
        body:StreamBuilder<List<Product>>(
        stream: FirestoreDB().getFavorites(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Erreur : ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/favoriteempty.png',
                    width: 200,
                    height: 200,
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Aucun élément favori",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
                    },
                    child: Text("Retour à l'accueil", style: TextStyle(color: Colors.black)),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(primaryColor),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          side: BorderSide(color: primaryColor),
                        ),
                      ),
                      minimumSize: MaterialStateProperty.all(Size(100, 40)),
                    ),
                  ),
                ],
              ),
            );
          } else {
            List<Product> favorites = snapshot.data!;
            return ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    childAspectRatio: 1 / 1.3,
                    children: favorites.map((product) {
                      return ProductCard(
                        product: product,
                      );
                    }).toList(),
                  ),
                ),
              ],
            );
          }
        },
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
    MaterialPageRoute(builder: (context) =>ProductSearchPage() ),
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
