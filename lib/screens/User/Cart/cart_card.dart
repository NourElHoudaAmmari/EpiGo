import 'package:epigo_project/controllers/cart_controller.dart';
import 'package:epigo_project/models/product_model.dart';
import 'package:epigo_project/styles/app_layout.dart';
import 'package:epigo_project/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class CartCard extends StatefulWidget {
  const CartCard({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;
  

  @override
  State<CartCard> createState() => _CartCardState();
}


class _CartCardState extends State<CartCard> {
      final CartController cartController = Get.find();
   Future<void> confirmAndRemoveProduct(Product product) async {
      if (product.quantity == 1) {
        bool? confirm = await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Confirmation'),
              content: Text('Voulez-vous retirer ce produit du panier ?'),
              actions: <Widget>[
                TextButton(
                  child: Text('Non'),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
                TextButton(
                  child: Text('Oui',style: TextStyle(color: Styles.primaryColor,fontSize: 14),),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                ),
              ],
            );
          },
        );

        if (confirm != null && confirm) {
          cartController.removeProduct(product);
        }
      } else {
        cartController.removeProduct(product);
      }
    }
  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find();
     return Dismissible(
      key: ValueKey(widget.product.id),
      background: Container(
        color:Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Confirmation'),
            content: const Text(
              'Voulez-vous retirer ce produit du panier ?',
            ),
            actions: <Widget>[
              TextButton(
                  child: Text('Non'),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
                TextButton(
                  child: Text('Oui',style: TextStyle(color: Styles.primaryColor,fontSize: 14),),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                ),
            ],
          ),
        );
      },
      onDismissed: (direction) {
        cartController.removeProduct(widget.product);
      },
      child:Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
  color: Styles.cardColor,
        borderRadius: BorderRadius.circular(10),
      ),
      
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(
                      widget.product.imageUrl,
                      height: AppLayout.getHeight(50),
                      width: AppLayout.getWidth(50),
                    ),
                    const Gap(8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.product.title,
                          style: Styles.headLineStyle2,
                        ),
                        const Gap(6),
                        Row(
                          children: [
                            Text(
                              widget.product.discount.isGreaterThan(0)
                                  ? '${(widget.product.price).toStringAsFixed(3)}\Dt'
                                  : '',
                              style: TextStyle(
                                decoration: TextDecoration.lineThrough,
                                color: Styles.orangeColor,
                              ),
                            ),
                            const Gap(4),
                            Text(
                              widget.product.discount.isGreaterThan(0)
                                  ? '${(widget.product.price - (widget.product.price * widget.product.discount / 100)).toStringAsFixed(3)}\Dt'
                                  : '${widget.product.price.toStringAsFixed(3)}\Dt',
                              style: Styles.headLineStyle4,
                            ),
                            Text( '/${widget.product.unit}',style: Styles.headLineStyle5,),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      confirmAndRemoveProduct(widget.product);
                    },
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Styles.orangeColor,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: const Icon(
                        Icons.remove,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Styles.whiteColor),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      widget.product.quantity.toString(),
                      style: Styles.headLineStyle2,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      cartController.addProduct(widget.product);
                    },
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Styles.orangeColor,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      ),
    );
  }
}