import 'package:epigo_project/models/CodePromo_model.dart';
import 'package:epigo_project/services/couponCode_Service.dart';
import 'package:epigo_project/services/firestore_db.dart';
import 'package:epigo_project/styles/styles.dart';
import 'package:epigo_project/widgets/promoCode_Row.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CodePromo extends StatefulWidget {
  const CodePromo({super.key});

  @override
  State<CodePromo> createState() => _CodePromoState();
}

class _CodePromoState extends State<CodePromo> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(
          "Codes Promos",
          style: TextStyle(color: Colors.black, fontSize: 20,fontWeight: FontWeight.bold),
        ),
        elevation: 0.0,
        backgroundColor:Styles.primaryColor,
        leading: IconButton(
          icon: Icon(CupertinoIcons.arrowtriangle_left,color: Colors.black,), onPressed: () {  Navigator.of(context).pop();},
        ),
      ), 
       body: StreamBuilder<List<CouponModel>>(
    stream:FirestoreDB().couponsStream(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child:CircularProgressIndicator.adaptive());
      } else if (snapshot.hasError) {
        return Text('Erreur : ${snapshot.error}');
      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/coupon.png',
                width: 200,
                height: 200,
              ),
              SizedBox(height: 10),
              Text(
                "Aucun code Promo trouvé",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        );
      } else {
        List<CouponModel> couponCode = snapshot.data!;
        return SingleChildScrollView(
       child: Column(
  children: [
    Padding(padding: EdgeInsets.all(8)),
    SizedBox(height: 16),
   Padding(
  padding: EdgeInsets.only(left: 16), 
  child: Container(
    constraints: BoxConstraints(
      maxWidth: 383,
    ),
    child: ListView.builder(
      shrinkWrap: true,
      itemCount: couponCode.length,
      itemBuilder: (context, index) {
        return PromoCodeRow(
          couponcode: couponCode[index],
          
        );
      },
    ),
  ),
),
  ],
),
        );
      }
    },
  ),
);
                
          }
        }
    



class PromoCodeItem extends StatelessWidget {
  final CouponModel promoCode;

  const PromoCodeItem(this.promoCode);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(
          promoCode.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        ),
        subtitle: Text(
          promoCode.description,
          style: TextStyle(
            color: Colors.grey[600],
          ),
        ),
        trailing: promoCode.isActivated!
            ? Icon(
                Icons.check_circle,
                color: Colors.green,
              )
            : Icon(
                Icons.cancel,
                color: Colors.red,
              ),
      ),
    );
  }
}