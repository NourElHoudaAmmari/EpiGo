import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:epigo_project/controllers/cart_controller.dart';
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
import 'package:badges/badges.dart' as badges;



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


  Stream<List<Product>> sortProductsByPriceDescending() {
  return _firestore
      .collection('products')
      .orderBy('price', descending: true) // Tri par le champ 'price' en ordre décroissant
      .snapshots()
      .map((QuerySnapshot query) {
        List<Product> retVal = [];
        query.docs.forEach((element) {
          retVal.add(Product.fromDocumentSnapshot(snapshot: element));
        });

        return retVal;
      });
}
Stream<List<Product>> getDiscountedProducts() {
  return _firestore
      .collection('products')
      .where('discount', isGreaterThan: 0)
      .snapshots()
      .map((QuerySnapshot query) {
        List<Product> retVal = [];
        query.docs.forEach((element) {
          retVal.add(Product.fromDocumentSnapshot(snapshot: element));
        });

        return retVal;
      });
}
  Stream<List<Product>>? productsStream;
  
  @override
  void initState() {
    super.initState();
    productsStream = getAllProducts();
    fetchBlockedStatus();
getDiscountedProducts();
     sortProductsByPriceAscending();
     sortProductsByPriceDescending();
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

Stream<List<Product>> sortProductsByPriceAscending() {
  return _firestore
      .collection('products')
      .orderBy('price') // Tri par le champ 'price'
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
                       _showFilterModal(context);
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
  void _showFilterModal(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Filtrer par",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            ListTile(
              title: Text("Prix Par Ordre Croissant"),
            onTap: () {
                // Tri par prix croissant
                setState(() {
                  productsStream = sortProductsByPriceAscending();
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text("Prix Par Ordre Décroissant"),
             onTap: () {
                // Tri par prix décroissant
                setState(() {
                  productsStream = sortProductsByPriceDescending();
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text("Par prix remisé"),
                 onTap: () {
                setState(() {
                  productsStream =  getDiscountedProducts();
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
    },
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