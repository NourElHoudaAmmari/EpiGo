import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epigo_project/controllers/search_controller.dart';
import 'package:epigo_project/models/product_model.dart';
import 'package:epigo_project/screens/User/Cart/cart_screen.dart';
import 'package:epigo_project/screens/User/Home_Screen/home_screen.dart';
import 'package:epigo_project/screens/User/Profile/profile_screen.dart';
import 'package:epigo_project/screens/User/Wishlist/favorite_screen.dart';
import 'package:epigo_project/screens/User/Product/product_card.dart';
import 'package:epigo_project/styles/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ProductSearchPage extends StatefulWidget {
  @override
  State<ProductSearchPage> createState() => _ProductSearchPageState();
}

class _ProductSearchPageState extends State<ProductSearchPage> {
   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  TextEditingController textController = TextEditingController();
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
  Stream<List<Product>>? productsStream;
  
  @override
  void initState() {
    super.initState();
    productsStream = getAllProducts();
    fetchBlockedStatus();
  }
 Stream<List<Product>> getAllProducts() {
    return _firestore
        .collection('products')
        .snapshots()
        .map((QuerySnapshot query) {
      List<Product> retVal = [];
      query.docs.forEach((element) {
        retVal.add(Product.fromDocumentSnapshot(snapshot: element));
      });

      return retVal;
    });
  }


  @override
  Widget build(BuildContext context) {
     final SearchController searchController = Get.put(SearchController());
      return Scaffold(
         appBar: AppBar(
        title: Text(
          "Rechercher",
          style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        elevation: 0.0,
        backgroundColor: Styles.primaryColor,
        leading: IconButton(
          icon: Icon(CupertinoIcons.arrowtriangle_left, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: <Widget>[
            Expanded(
  child: TextField(
    controller: textController,
    decoration: InputDecoration(
      hintText: "Rechercher un produit",
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0), // Vous pouvez ajuster le rayon selon vos préférences
      ),
    ),
    onChanged: (value) {
      setState(() {
        productsStream = searchProducts(value);
      });
    },
  ),
),
                IconButton(
                  icon: Icon(Icons.filter_list,color: Colors.deepOrange,),
                  onPressed: () {
                    // Ajoutez votre logique de filtrage ici
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<List<Product>>(
              stream: productsStream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                List<Product> products = snapshot.data ?? [];

                if (products.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset("assets/images/search_fail.png"),
                        Text("Le produit recherché n'existe pas"),
                      ],
                    ),
                  );
                }

             return GridView.count(
  shrinkWrap: true,
                      crossAxisCount: 2,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      childAspectRatio: 1 / 1.3,
   children: List.generate(
                     products.length,
                        (index) {
                          return ProductCard(
                            product: products[index],
                          );
                        },
                      ),
                    );
              },
            ),
          ),
        ],
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
    icon: const Icon(Icons.shopping_cart_outlined),
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

  Stream<List<Product>> searchProducts(String query) {
    return _firestore
        .collection('products')
        .where('title', isGreaterThanOrEqualTo: query)
        .where('title', isLessThanOrEqualTo: query + '\uf8ff')
        .snapshots()
        .map((QuerySnapshot query) {
          List<Product> retVal = [];
          query.docs.forEach((element) {
            retVal.add(Product.fromDocumentSnapshot(snapshot: element));
          });

          return retVal;
        });
  }
}