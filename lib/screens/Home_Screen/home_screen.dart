import 'package:epigo_project/config/constants.dart';
import 'package:epigo_project/providers/product_provider.dart';
import 'package:epigo_project/providers/user_provider.dart';
import 'package:epigo_project/screens/Home_Screen/drawer_side.dart';
import 'package:epigo_project/screens/Home_Screen/signal_product.dart';
import 'package:epigo_project/screens/Product_overview/product_overview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class HomeScreen extends StatefulWidget {
 
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ProductProvider productProvider;
   Widget _buildHerbsProducts(context){
   return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
                Text('Les Herbes',style: TextStyle(fontWeight: FontWeight.bold),),
              GestureDetector(
                onTap: () {
                /*  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Search(
                        search: productProvider.getHerbsProductDataList,
                      ),
                    ),
                  );*/
                },
                child:     Text('Tout voir',style: TextStyle(color: Colors.grey,),)
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children:productProvider.getHerbsProductDataList.map(
              (herbsProductData){
                return SignalProduct(
                      productId: herbsProductData.productId,
                  productImage:herbsProductData.productImage, 
                  productName: herbsProductData.productName,
                   productPrice: herbsProductData.productPrice, 
                   productUnit: herbsProductData ,
                   productDescription: herbsProductData.productDescription,
                 
                   onTap: (){
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ProductOverview(
                        productId: herbsProductData.productId,
                         productImage: herbsProductData.productImage,
                          productName: herbsProductData.productName, 
                          productPrice: herbsProductData.productPrice,
                          productDescription: herbsProductData.productDescription,
                          productUnit: herbsProductData),
                          )
                    );
                   }
                   );
              },
              ).toList(),
         
          ),
        ),
      ],
    );
  }
   Widget _fruitsProducts(context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
                Text('Les Fruits',style: TextStyle(fontWeight: FontWeight.bold),),
              GestureDetector(
                onTap: () {
                /*  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Search(
                        search: productProvider.getHerbsProductDataList,
                      ),
                    ),
                  );*/
                },
                child:     Text('Tout voir',style: TextStyle(color: Colors.grey,),)
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children:productProvider.getFreshProductDataList.map(
              (fruitProductData){
                return SignalProduct(
                      productId: fruitProductData.productId,
                  productImage:fruitProductData.productImage, 
                  productName: fruitProductData.productName,
                   productPrice: fruitProductData.productPrice, 
                   productUnit: fruitProductData ,
                   productDescription: fruitProductData.productDescription,
                   onTap: (){
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ProductOverview(
                        productId:fruitProductData.productId,
                         productImage: fruitProductData.productImage,
                          productName: fruitProductData.productName, 
                          productPrice: fruitProductData.productPrice,
                          productDescription: fruitProductData.productDescription,
                          productUnit: fruitProductData,),
                          )
                    );
                   }
                   );
              },
              ).toList(),
         
          ),
        ),
      ],
    );
  }
  Widget _LegumesProducts(context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
                Text('Les Légumes',style: TextStyle(fontWeight: FontWeight.bold),),
              GestureDetector(
                onTap: () {
                /*  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Search(
                        search: productProvider.getHerbsProductDataList,
                      ),
                    ),
                  );*/
                },
                child:     Text('Tout voir',style: TextStyle(color: Colors.grey,),)
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children:productProvider.getRootProductDataList.map(
              (legProductData){
                return SignalProduct(
                      productId: legProductData.productId,
                  productImage:legProductData.productImage, 
                  productName: legProductData.productName,
                   productPrice: legProductData.productPrice, 
                   productUnit: legProductData,
                   productDescription: legProductData.productDescription,
                   onTap: (){
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ProductOverview(
                        productId:legProductData.productId,
                         productImage: legProductData.productImage,
                          productName: legProductData.productName, 
                          productPrice: legProductData.productPrice,
                          productDescription: legProductData.productDescription,
                          productUnit: legProductData,),
                          )
                    );
                     print(legProductData);
                   }
                   
                   );
                  
              },
              ).toList(),
              
         
          ),
        ),
      ],
    );
  }
  @override
  void initState(){
    ProductProvider productProvider = Provider.of(context,listen: false);
    productProvider.fatchHerbsProductData();
    productProvider.fatchFreshProductData();
    productProvider.fatchRootProductData();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
 productProvider = Provider.of(context);
    return Scaffold(
    //backgroundColor: Color.fromARGB(255, 219, 219, 219),
      drawer: DrawerSide( ),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text('Accueil',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17),),
        actions: [
          CircleAvatar(
            radius: 12,
            backgroundColor: Color(0xffd4d181),
            child: Icon(Icons.search,size: 17,color: Colors.black,),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: CircleAvatar(
              radius: 12,
              backgroundColor: Color(0xffd4d181),
               child: Icon(Icons.shop_2_outlined,size: 17,color: Colors.black,),
            ),
          )
        ],
        backgroundColor: Color(0xffd6b738),
      ),
    body: Padding(
      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
      child: ListView(
        children: [
          Container(
            height: 150,
            decoration: BoxDecoration(
              
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQi0Xg-k622Sbztlrb-L1o1CAla3zCbVc2lUw&usqp=CAU')),
               color: Colors.red,
              borderRadius: BorderRadius.circular(10),
            ),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 130,bottom: 10),
                        child: Container(
                          height: 50,
                          width: 100,
                          decoration: BoxDecoration(
                                    color: Color(0xffd1ad17),
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(50),
                              bottomLeft: Radius.circular(50),

                            )
                          ),
                          child: Center(
                            child: Text('EpiGo',style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              shadows: [
                             BoxShadow(
                              color: Colors.green,
                              blurRadius: 10,
                              offset: Offset(3,3),
                             ),
                              ],
                              ),
                              ),
                          ),
                        ),
                      ),
                    Text('30% de réduction',style: TextStyle(
                      fontSize: 30,color: Colors.green[100],
                      fontWeight: FontWeight.bold,
                    ),),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text('Sur tous les produits végétaux',style: TextStyle(
                       color: Colors.white,
                        
                      ),),
                    ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(),
              ),
            ],
          ), 
          ),
    _buildHerbsProducts(context),
         _fruitsProducts(context),
         _LegumesProducts(context),
        ],
      ),
    ),
    );
  }
}