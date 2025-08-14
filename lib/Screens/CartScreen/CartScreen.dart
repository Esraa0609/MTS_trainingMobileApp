import 'package:flutter/material.dart';
import 'package:flutter_application_1_1/Models/cartModel.dart';
import 'package:flutter_application_1_1/Models/cart_provider.dart';
import 'package:flutter_application_1_1/Screens/PaymentScreen/PaymentScreen.dart';
import 'package:flutter_application_1_1/Services/dbService.dart';
import 'package:flutter_application_1_1/Utils/data/data.dart';
import 'package:flutter_application_1_1/Widgets/buildcartitem.dart'; // Ensure this widget is correctly defined
import 'package:flutter_application_1_1/Widgets/reusableprice.dart'; // Ensure this widget is correctly defined
import 'package:flutter_application_1_1/Widgets/sideMenu.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;

class CartScreen extends StatefulWidget {
  final String userId;

  const CartScreen({required this.userId});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  String get userId => widget.userId;
  
  Map<String, String>? findUserByID(String id) {
    return Data.users.firstWhere(
      (user) => user['userID'] == id,
    );
  }

  final Db_service _dbService = Db_service();
  bool _isExpanded = false;
  int _selected = -1;

  void _toggleExpansion(int index) {
    setState(() {
      if (_selected == index) {
        _isExpanded = !_isExpanded;
      } else {
        _isExpanded = true;
        _selected = index;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = findUserByID(userId);
    final cart = Provider.of<CartProvider>(context);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    int x = 0;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Products",
          style: TextStyle(
            color: Colors.white,
            fontSize: screenWidth * 0.065,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 36, 72, 136),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          Center(
            child: badges.Badge(
              badgeContent: Consumer<CartProvider>(
                builder: (context, value, child) {
                  return Text(
                    value.getCounter().toString(),
                    style: const TextStyle(color: Colors.white),
                  );
                },
              ),
              badgeAnimation: const badges.BadgeAnimation.slide(
                animationDuration: Duration(milliseconds: 300),
                loopAnimation: false,
              ),
              child: const Icon(Icons.shopping_cart_outlined),
            ),
          ),
          const SizedBox(width: 20),
        ],
      ),
      drawer: sideMenu(userId: user?['userID'] ?? 'Username not available'),
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.025),
        child: Column(
          children: [
            FutureBuilder<List<Cart>>(
              future: cart.getData(),
              builder: (context, AsyncSnapshot<List<Cart>> snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Column(
                    children: [
                      Text(
                        'No items in the cart',
                        style: TextStyle(fontSize: screenWidth * 0.05),
                      ),
                      Image.asset(
                        'lib/assets/emptyBox.png',
                        width: screenWidth,
                        height: screenHeight * 0.8,
                      ),
                    ],
                  );
                } else {
                  x = snapshot.data!.length;
                  return Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => _toggleExpansion(index),
                          child: Card(
                            child: Container(
                              padding: EdgeInsets.all(screenWidth * 0.02),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  buildCartItem(
                                    snapshot.data![index],
                                    index,
                                    context,
                                    _isExpanded,
                                    _selected,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            ),
            Consumer<CartProvider>(builder: (context, value, child) {
              final totalPrice = value.getTotalPrice().toStringAsFixed(2);
              return Visibility(
                visible: totalPrice != '0.00',
                child: Column(
                  children: [
                    ReusableWidget(
                      title: 'Total Items',
                      value: (cart.getCounter()).toString(),
                    ),
                    ReusableWidget(
                      title: 'Sub Total',
                      value: 'L.E.' + totalPrice,
                    ),
                    ReusableWidget(
                      title: 'Shipping Fees',
                      value: 'L.E.60.00',
                    ),
                    ReusableWidget(
                      title: 'Total',
                      value: 'L.E.' +
                          (double.parse(totalPrice.toString()) + 60)
                              .toStringAsFixed(2),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      height: screenHeight * 0.07,
                      width: screenWidth ,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder:(_) => PaymentScreen(userId: userId)));
                        },
                        child: Center(
                          child: Text(
                            "Proceed to Checkout",
                            style: TextStyle(
                              fontSize: screenWidth * 0.05,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
