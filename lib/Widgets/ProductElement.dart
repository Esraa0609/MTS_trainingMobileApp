import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1_1/Models/cartModel.dart';
import 'package:flutter_application_1_1/Models/cart_provider.dart';
import 'package:flutter_application_1_1/Services/LimitDigitInputFormatter.dart';
import 'package:flutter_application_1_1/Services/dbService.dart';
import 'package:flutter_application_1_1/Utils/data/products.dart';
import 'package:flutter_application_1_1/Widgets/lineProd.dart';

class ProductElement extends StatefulWidget {
  final int index;
  final bool isExpanded;
  final Db_service db;
  final CartProvider cart;
  final int selectedindex;

  const ProductElement({
    Key? key,
    required this.index,
    required this.isExpanded,
    required this.db,
    required this.cart,
    required this.selectedindex,
  }) : super(key: key);

  @override
  _ProductElementState createState() => _ProductElementState();
}

class _ProductElementState extends State<ProductElement> {
  final TextEditingController unitsquantity = TextEditingController(text: "1");

  @override
  void dispose() {
    unitsquantity.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double imageHeight = screenWidth * 0.18;
    double containerWidth = screenWidth * 0.25;
    double unitFontSize = screenWidth * 0.045;
    double unitPriceFontSize = screenWidth * 0.055;
    double stockFontSize = screenWidth * 0.04;
    double buttonHeight = screenWidth * 0.10;
    double buttonWidth = screenWidth * 0.27;
    int quantity = 1;
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: screenWidth * 0.32,
                width: containerWidth,
                color: (Products_Data.ProductCurrStock[widget.index] > 0)
                    ? const Color.fromARGB(255, 36, 72, 136)
                    : Colors.grey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      color: Colors.white,
                      width: containerWidth,
                      height: imageHeight,
                      child: Image(
                        height: imageHeight,
                        width: containerWidth,
                        image: AssetImage(Products_Data.ProductImage[widget.index]),
                        opacity: (Products_Data.ProductCurrStock[widget.index] > 0)
                            ? const AlwaysStoppedAnimation(1)
                            : const AlwaysStoppedAnimation(0.5),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(width: 5),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('UNIT',
                                style: TextStyle(
                                    color: Colors.white, fontSize: unitFontSize)),
                            Text(Products_Data.ProductUnit[widget.index],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: unitFontSize * 0.8,
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
                        lineProd(index: widget.index),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                Products_Data.ProductName[widget.index].toString(),
                                style: TextStyle(
                                    fontSize: unitFontSize,
                                    fontWeight: FontWeight.w500,
                                    color: (Products_Data.ProductCurrStock[widget.index] > 0)
                                        ? Colors.black
                                        : Colors.grey),
                              ),
                              const SizedBox(height: 5),
                              Container(
                                height: 1,
                                width: double.infinity,
                                color: const Color.fromARGB(255, 197, 196, 196),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                Products_Data.ProductBarCode[widget.index].toString(),
                                style: TextStyle(
                                    fontSize: unitFontSize,
                                    color: (Products_Data.ProductCurrStock[widget.index] > 0)
                                        ? Colors.black
                                        : Colors.grey),
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
                            Text('In Stock',
                                style: TextStyle(
                                    fontSize: stockFontSize, color: Colors.grey)),
                            Text(
                              Products_Data.ProductCurrStock[widget.index].toString(),
                              style: TextStyle(
                                  fontSize: stockFontSize,
                                  color: (Products_Data.ProductCurrStock[widget.index] > 0)
                                      ? const Color.fromARGB(255, 0, 100, 33)
                                      : Colors.red),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('UNIT PRICE',
                                style: TextStyle(fontSize: unitFontSize * 0.8, color: Colors.grey)),
                            Text(
                              "L.E. ${Products_Data.ProductPrice[widget.index].toStringAsFixed(2)}",
                              style: TextStyle(
                                  fontSize: unitPriceFontSize, color: Colors.grey),
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
            height: (widget.isExpanded && widget.selectedindex == widget.index) ? 60 : 0,
            color: const Color.fromARGB(255, 248, 243, 243),
            child: (widget.isExpanded && widget.selectedindex == widget.index)
                ? SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            Container(
                              width: buttonHeight * 1.2,
                              height: buttonHeight * 1.2,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child:  GestureDetector(
                                onTap: ()
                                {
                                  quantity = int.tryParse(unitsquantity.text) ?? 1;
                                  if(quantity > 1)
                                  { quantity = quantity - 1;
                                   unitsquantity.text = quantity.toString();
                                  }

                                },
                                child: const Icon(
                                Icons.remove,
                                size: 45,
                                color: Colors.white,
                              ),
                              )
                            ),
                            const SizedBox(width: 10),
                            Container(
                              width: screenWidth * 0.2,
                              height: screenWidth * 0.10,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(9),
                                color: const Color.fromARGB(255, 43, 108, 194)
                                    .withOpacity(0.2),
                              ),
                              child: TextFormField(
                                controller: unitsquantity,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  hintText: "1",
                                  border: OutlineInputBorder(),
                                ),
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                   LimitedDigitsInputFormatter(maxDigits: 3),
                                  ],
                                  textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Container(
                              width: buttonHeight * 1.2,
                              height: buttonHeight * 1.2,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: GestureDetector(
                                onTap: (){
                                  quantity = int.tryParse(unitsquantity.text) ?? 1;
                                  if(quantity < Products_Data.ProductCurrStock[widget.index])
                                  { quantity = quantity + 1;
                                   unitsquantity.text = quantity.toString();
                                  }

                                },
                                child: const Icon(
                                Icons.add,
                                size: 45,
                                color: Colors.white,
                              ),
                              )
                              
                            ),
                            const SizedBox(width: 35),
                            InkWell(
                              onTap: () {
                                quantity = int.tryParse(unitsquantity.text) ?? 1;
                                widget.db.insert(
                                  Cart(
                                    id: widget.index,
                                    productId: Products_Data.ProductBarCode[widget.index],
                                    productName: Products_Data.ProductName[widget.index],
                                    initialPrice: Products_Data.ProductPrice[widget.index],
                                    productPrice: Products_Data.ProductPrice[widget.index],
                                    quantity: quantity,
                                    currentStock: Products_Data.ProductCurrStock[widget.index],
                                    unitTag: Products_Data.ProductUnit[widget.index],
                                    image: Products_Data.ProductImage[widget.index],
                                  ),
                                ).then((value) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("Product added to Cart"),
                                      backgroundColor: Colors.green,
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                  widget.cart.addTotalPrice(
                                     double.parse(Products_Data.ProductPrice[widget.index].toString()) * quantity,
                                  );
                                  for (int i = 0; i < quantity; i++) {
                                    widget.cart.addCounter();
                                  }
                                }).onError((error, StackTrace) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("Product already added"),
                                      backgroundColor: Colors.red,
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                });
                              },
                              child: Container(
                                height: buttonHeight,
                                width: buttonWidth ,
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 36, 72, 136),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Center(
                                  child: Text(
                                    'Check In',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: unitFontSize),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                : null,
          ),
        ],
      ),
    );
  }
}
