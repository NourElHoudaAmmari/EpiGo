import 'package:epigo_project/models/product_model.dart';
import 'package:epigo_project/widgets/count.dart';
import 'package:epigo_project/widgets/product_unit.dart';
import 'package:flutter/material.dart';

import '../../config/constants.dart';

class SignalProduct extends StatefulWidget {
   late final String productImage;
  late final String productName;
  late final int productPrice;
  late final VoidCallback onTap;
  late final String productId;
  late final ProductModel productUnit;
 SignalProduct({required this.productImage, required this.productName, required this.productPrice, required this.onTap, required this.productUnit});
 // const SignalProduct({super.key});

  @override
  State<SignalProduct> createState() => _SignalProductState();
}

class _SignalProductState extends State<SignalProduct> {
    var unitData;
  var firstValue;
  @override
  Widget build(BuildContext context) {
  widget.productUnit.productUnit.firstWhere((element) {
      setState(() {
        firstValue = element;
      });
      return true;
    });
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 10),
            height: 230,
            width: 165,
            decoration: BoxDecoration(
              color: Color(0xffd9dad9),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: widget.onTap,
                  child: Container(
                    height: 150,
                    padding: EdgeInsets.all(5),
                    width: double.infinity,
                    child: Image.network(
                      widget.productImage,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.productName,
                          style: TextStyle(
                            color: textColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${widget.productPrice}\$/${unitData == null?firstValue:unitData}',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: ProductUnit(
                                onTap: () {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: widget
                                              .productUnit.productUnit
                                              .map<Widget>((data) {
                                            return Column(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 10,
                                                      horizontal: 10),
                                                  child: InkWell(
                                                    onTap: () async {
                                                      setState(() {
                                                        unitData = data;
                                                      });
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Text(
                                                      data,
                                                      style: TextStyle(
                                                          color: primaryColor,
                                                          fontSize: 18),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          }).toList(),
                                        );
                                      });
                                },
                                title: unitData == null?firstValue:unitData,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Count(
                              productId: widget.productId,
                              productImage: widget.productImage,
                              productName: widget.productName,
                              productPrice: widget.productPrice,
                              productUnit: unitData == null?firstValue:unitData,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}