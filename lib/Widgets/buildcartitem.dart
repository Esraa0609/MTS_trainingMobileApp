import 'package:flutter/material.dart';
import 'package:flutter_application_1_1/Models/cartModel.dart';
import 'package:flutter_application_1_1/Models/cart_provider.dart';
import 'package:flutter_application_1_1/Services/dbService.dart';
import 'package:flutter_application_1_1/Utils/data/products.dart';
import 'package:flutter_application_1_1/Widgets/lineProd.dart';
import 'package:provider/provider.dart';

Widget buildCartItem(
  Cart item,
  int index,
  BuildContext context,
  bool isExpanded,
  int selected,
) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;
  Db_service DBservice = Db_service();
  final cart = Provider.of<CartProvider>(context);

  return Container(
    child: Card(
      child: Container(
        padding: EdgeInsets.all(screenWidth * 0.02),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        height: screenWidth * 0.32,
                        width: screenWidth * 0.25,
                        color: const Color.fromARGB(255, 36, 72, 136),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              color: Colors.white,
                              width: screenWidth * 0.3,
                              height: screenWidth * 0.21,
                              child: Image(
                                height: screenWidth * 0.22,
                                width: screenWidth * 0.3,
                                image: AssetImage(item.image.toString()),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const SizedBox(width: 5),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('UNIT',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 17)),
                                    Text(item.unitTag.toString(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                        )),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const SizedBox(width: 10),
                                lineProd(index: index),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            item.productName.toString(),
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              int quan = item.quantity!;
                                              while (quan > 0) {
                                                cart.removeCounter();
                                                quan = quan - 1;
                                                cart.removeTotalPrice(double.parse(
                                                    item.initialPrice!.toString()));
                                              }
                                              DBservice.delete(item.id!);
                                            },
                                            child: Icon(Icons.delete),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 5),
                                      Container(
                                        height: 1,
                                        width: double.infinity,
                                        color: const Color.fromARGB(255, 197, 196, 196),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        item.productId.toString(),
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 30),
                            Row(
                              children: [
                                const SizedBox(width: 12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('In Stock',
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.grey)),
                                    Text(
                                      item.currentStock.toString(),
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: (item.currentStock! > 0)
                                              ? const Color.fromARGB(255, 0, 100, 33)
                                              : Colors.red),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('UNIT PRICE',
                                        style: TextStyle(
                                            fontSize: 13, color: Colors.grey)),
                                    Text(
                                      "L.E. ${item.initialPrice?.toStringAsFixed(2)}",
                                      style: const TextStyle(
                                          fontSize: 22, color: Colors.grey),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 12),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    width: screenWidth,
                    height: (isExpanded && index == selected) ? screenHeight * 0.08 : 0,
                    color: const Color.fromARGB(255, 248, 244, 244),
                    child: (isExpanded && index == selected)
                        ? Align(
                            alignment: Alignment.center,
                            child: InkWell(
                              onTap: () {
                                // Add to cart logic
                              },
                              child: Container(
                                height: screenHeight * 0.07,
                                width: screenWidth * 0.8,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(screenWidth * 0.01),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          int quantity = item.quantity!;
                                          double price = item.initialPrice!;
                                          quantity--;
                                          double newprice = price * quantity;
                                          int current = item.currentStock! + 1;

                                          if (quantity > 0) {
                                            DBservice.updateQauntity(
                                              Cart(
                                                  id: item.id,
                                                  productId: item.productId,
                                                  productName: item.productName,
                                                  initialPrice: item.initialPrice,
                                                  productPrice: newprice,
                                                  quantity: quantity,
                                                  currentStock: current,
                                                  unitTag: item.unitTag,
                                                  image: item.image),
                                            ).then((value) {
                                              newprice = 0;
                                              quantity = 0;
                                              cart.removeTotalPrice(double.parse(
                                                  item.initialPrice!.toString()));
                                              cart.removeCounter();
                                            }).onError((error, StackTrace) {
                                              print(error.toString());
                                            });
                                          }
                                        },
                                        child: Icon(
                                          Icons.remove,
                                          color: Colors.white,
                                          size: screenWidth * 0.08,
                                        ),
                                      ),
                                      Text(
                                        item.quantity.toString(),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: screenWidth * 0.05),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          int quantity = item.quantity!;
                                          double price = item.initialPrice!;
                                          quantity++;
                                          double newprice = price * quantity;
                                          int current = item.currentStock! - 1;
                                          if (0 < item.currentStock!) {
                                            DBservice.updateQauntity(
                                              Cart(
                                                  id: item.id,
                                                  productId: item.productId,
                                                  productName: item.productName,
                                                  initialPrice: item.initialPrice,
                                                  productPrice: newprice,
                                                  quantity: quantity,
                                                  currentStock: current,
                                                  unitTag: item.unitTag,
                                                  image: item.image),
                                            ).then((value) {
                                              newprice = 0;
                                              quantity = 0;
                                              cart.addTotalPrice(double.parse(
                                                  item.initialPrice!.toString()));
                                              cart.addCounter();
                                            }).onError((error, StackTrace) {
                                              print(error.toString());
                                            });
                                          }
                                        },
                                        child: Icon(
                                          Icons.add,
                                          color: Colors.white,
                                          size: screenWidth * 0.08,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        : null,
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
