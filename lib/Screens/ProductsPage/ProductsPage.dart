import 'package:flutter/material.dart';
import 'package:flutter_application_1_1/Models/cartModel.dart';
import 'package:flutter_application_1_1/Models/cart_provider.dart';
import 'package:flutter_application_1_1/Screens/CartScreen/CartScreen.dart';
import 'package:flutter_application_1_1/Services/dbService.dart';
import 'package:flutter_application_1_1/Utils/data/data.dart';
import 'package:flutter_application_1_1/Utils/data/products.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_application_1_1/Widgets/ProductElement.dart';
import 'package:flutter_application_1_1/Widgets/sideMenu.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatefulWidget {
  final String userId;
  const ProductPage({required this.userId});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  String get userId => widget.userId;

  Map<String, String>? findUserByID(String id) {
    return Data.users.firstWhere(
      (user) => user['userID'] == id,
    );
  }

  Db_service DBservice = Db_service();
  bool _isExpanded = false;
  int _selected = -1;
  String _searchQuery = '';
  bool _searchByBarcode = false;
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text.toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _toggleExpansion(int index) {
    setState(() {
      _isExpanded = !_isExpanded;
      _selected = _isExpanded ? index : -1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = findUserByID(userId);
    final cart = Provider.of<CartProvider>(context);

    // Responsive sizing
    double screenWidth = MediaQuery.of(context).size.width;
    double titleFontSize = screenWidth * 0.065;
    double iconSize = screenWidth * 0.075;
    double cardPadding = screenWidth * 0.02;
    double badgeSize = screenWidth * 0.1;
    double textFieldHeight = 50;
    double buttonWidth = 61;

    // Filtered products based on search query
    List<int> filteredIndices = [];
    for (int i = 0; i < Products_Data.ProductName.length; i++) {
      bool matches = _searchByBarcode
          ? Products_Data.ProductBarCode[i].toLowerCase().contains(_searchQuery)
          : Products_Data.ProductName[i].toLowerCase().contains(_searchQuery);
      if (matches) {
        filteredIndices.add(i);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Product List",
          style: TextStyle(
            color: Colors.white,
            fontSize: titleFontSize,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 36, 72, 136),
        iconTheme: IconThemeData(color: Colors.white, size: iconSize),
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartScreen(
                    userId: user?['userID'] ?? 'Username not available',
                  ),
                ),
              );
            },
            child: badges.Badge(
              badgeContent: Consumer<CartProvider>(
                builder: (context, value, child) {
                  return Text(
                    value.getCounter().toString(),
                    style: TextStyle(color: Colors.white, fontSize: badgeSize * 0.4),
                  );
                },
              ),
              badgeAnimation: const badges.BadgeAnimation.slide(
                animationDuration: Duration(milliseconds: 300),
                loopAnimation: false,
              ),
              child: Icon(Icons.shopping_cart_outlined, size: iconSize),
            ),
          ),
          SizedBox(width: screenWidth * 0.05),
        ],
      ),
      drawer: sideMenu(userId: user?['userID'] ?? 'Username not available'),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(screenWidth * 0.02),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: _searchByBarcode ? "Search by barcode" : "Search by product",
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.02),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 7, 24, 53),
                      ),
                      onPressed: () {
                        setState(() {
                          _searchByBarcode = !_searchByBarcode; // Toggle search criteria
                        });
                      },
                      child: Container(
                        width: buttonWidth,
                        height: textFieldHeight,
                        alignment: Alignment.center,
                        child: Text(
                          _searchByBarcode ? 'Product' : 'Barcode',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredIndices.length,
              itemBuilder: (context, index) {
                int productIndex = filteredIndices[index];
                return GestureDetector(
                  onTap: () {
                    if (Products_Data.ProductCurrStock[productIndex] > 0) {
                      _toggleExpansion(productIndex);
                    }
                  },
                  child: Card(
                    margin: EdgeInsets.symmetric(vertical: cardPadding, horizontal: cardPadding * 2),
                    child: Container(
                      padding: EdgeInsets.all(cardPadding),
                      child: ProductElement(
                        index: productIndex,
                        isExpanded: _isExpanded,
                        selectedindex: _selected,
                        db: DBservice,
                        cart: cart,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color.fromARGB(255, 36, 72, 136),
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.025),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Consumer<CartProvider>(
                builder: (context, value, child) {
                  return Row(
                    children: [
                      Text(
                        "Items: ",
                        style: TextStyle(color: Colors.white, fontSize: screenWidth * 0.045),
                      ),
                      Container(
                        width: screenWidth * 0.22,
                        height: screenWidth * 0.15,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 7, 24, 53),
                          borderRadius: BorderRadius.circular(screenWidth * 0.02),
                        ),
                        child: Center(
                          child: Text(
                            "${value.getCounter()}",
                            style: TextStyle(color: Colors.white, fontSize: screenWidth * 0.045),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              Consumer<CartProvider>(
                builder: (context, value, child) {
                  return Row(
                    children: [
                      Text(
                        "Total: L.E. ",
                        style: TextStyle(color: Colors.white, fontSize: screenWidth * 0.045),
                      ),
                      Container(
                        width: screenWidth * 0.22,
                        height: screenWidth * 0.15,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 7, 24, 53),
                          borderRadius: BorderRadius.circular(screenWidth * 0.02),
                        ),
                        child: Center(
                          child: Text(
                            "${value.getTotalPrice().toStringAsFixed(2)}",
                            style: TextStyle(color: Colors.white, fontSize: screenWidth * 0.045),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
