import 'package:epigo_project/config/constants.dart';
import 'package:epigo_project/providers/user_provider.dart';
import 'package:epigo_project/screens/Home_Screen/drawer_side.dart';
import 'package:flutter/material.dart';


class HomeScreen extends StatefulWidget {
 
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
   Widget singalProducts(){
    return  Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
              height: 230,
              width: 160,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 243, 243, 243),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Image.network('https://pngimg.com/uploads/basil/basil_PNG10.png'),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Basilic Frais',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                          Text('3.2\Dt/500g',style: TextStyle(color: Colors.grey,),),
                          Row(children: [
                            Expanded(child: Container(
                              padding: EdgeInsets.only(left: 5),
                              height: 30,
                              width: 50,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                   Expanded(child: Text('50 g',style: TextStyle(fontSize: 10),
                                   )),
                               Center(
                                  child: Icon(
                                    Icons.arrow_drop_down,
                                  size: 20,
                                  color:primaryColor,
                                  ),
                                ),
                                                         ],
                                                         ),
                                                         ),
                                                       ),
              
                            SizedBox(width: 5,),
                            Expanded(child: Container(
                              height: 30,
                              width: 50,
                                 decoration: BoxDecoration(
                             
                                  border: Border.all(color: Colors.grey,),
                                borderRadius: BorderRadius.circular(8),
                      
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.remove,size: 15,color: Color(0xffd0b84c),),
                                  Text('1',style: TextStyle(color: Color(0xffd0b84c),fontWeight: FontWeight.bold),),
                                  Icon(Icons.add,size: 15,color: Color(0xffd0b84c),)
                                ],
                              ),
                            ),
                            ),
                          ],
                          ),
                     
                  
                         
                        ],
                                          ),
                      ),
                    ),
                ],
              ),
            
            );
  }
   Widget fruitsProducts(){
    return  Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
              height: 230,
              width: 160,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 243, 243, 243),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Image.network('https://us.123rf.com/450wm/monticello/monticello1411/monticello141100038/33614942-grappe-de-raisin-blanc-frais-isol%C3%A9-sur-fond-blanc.jpg'),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Raisins',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                          Text('6.7\Dt/500g',style: TextStyle(color: Colors.grey,),),
                          Row(children: [
                            Expanded(child: Container(
                              padding: EdgeInsets.only(left: 5),
                              height: 30,
                              width: 50,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                   Expanded(child: Text('500 g',style: TextStyle(fontSize: 10),
                                   )),
                               Center(
                                  child: Icon(
                                    Icons.arrow_drop_down,
                                  size: 20,
                                  color:primaryColor,
                                  ),
                                ),
                                                         ],
                                                         ),
                                                         ),
                                                       ),
              
                            SizedBox(width: 5,),
                            Expanded(child: Container(
                              height: 30,
                              width: 50,
                                 decoration: BoxDecoration(
                             
                                  border: Border.all(color: Colors.grey,),
                                borderRadius: BorderRadius.circular(8),
                      
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.remove,size: 15,color: Color(0xffd0b84c),),
                                  Text('1',style: TextStyle(color: Color(0xffd0b84c),fontWeight: FontWeight.bold),),
                                  Icon(Icons.add,size: 15,color: Color(0xffd0b84c),)
                                ],
                              ),
                            ),
                            ),
                          ],
                          ),
                     
                  
                         
                        ],
                                          ),
                      ),
                    ),
                ],
              ),
            
            );
  }
  @override
  Widget build(BuildContext context) {
      
  //  UserProvider userProvider = Provider.of(context);
   // userProvider.getUserData();
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
       Padding(
         padding: const EdgeInsets.symmetric(vertical: 15),
         child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Les Herbes',style: TextStyle(fontWeight: FontWeight.bold),),
            Text('Tout voir',style: TextStyle(color: Colors.grey,),)
          ],
         ),
       ),
       SingleChildScrollView(
        scrollDirection: Axis.horizontal,
          child: Row(
            children: [
             singalProducts(),
                singalProducts(),
                   singalProducts(),
                      singalProducts(),
                         singalProducts(),
            ],
          ),
        ),
          Padding(
         padding: const EdgeInsets.symmetric(vertical: 15),
         child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Les Fruits',style: TextStyle(fontWeight: FontWeight.bold),),
            Text('Tout voir',style: TextStyle(color: Colors.grey,),)
          ],
         ),
       ),
        SingleChildScrollView(
        scrollDirection: Axis.horizontal,
          child: Row(
            children: [
            fruitsProducts(),
            fruitsProducts(),
            fruitsProducts(),
            fruitsProducts(),
            fruitsProducts(),
            ],
          ),
        ),
        ],
      ),
    ),
    );
  }
}