import 'package:flutter/material.dart';
import 'package:flutter_application_1_1/Screens/ProductsPage/ProductsPage.dart';
import 'package:flutter_application_1_1/Utils/data/data.dart';
import 'package:flutter_application_1_1/Widgets/appBar.dart';
import 'package:flutter_application_1_1/Widgets/buttom_nav_bar.dart';
import 'package:flutter_application_1_1/Widgets/sideMenu.dart';
// Import the ProfileScreen if available
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FirstScreen extends StatefulWidget {
  final String userId; // Change to `userId` to match common naming conventions
  const FirstScreen({required this.userId, super.key});

  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {

  String get userId => widget.userId;

  Map<String, String>? findUserByID(String id) {
    return Data.users.firstWhere(
      (user) => user['userID'] == id,
    );
  }

  
  @override
  Widget build(BuildContext context) {
    final user = findUserByID(userId);
    

    return Scaffold(
      appBar: appBar(
        title: AppLocalizations.of(context)!.page_firstscreen_appbar(user?['username'] ?? 'User'),
      ),
      drawer: sideMenu(
        userId: user?['userID'] ?? 'Username not available',
      ),
      body: GestureDetector(
        onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => ProductPage(userId: user?['userID'] ?? 'Username not available')),
            ),
        child: Container(
          
          padding: const EdgeInsets.all(12),
          width: 120,
          height: 110,
          margin: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: const Color.fromARGB(255, 12, 24, 46), 
              width: 3.0,
            ),
            borderRadius: BorderRadius.circular(16)
          ),
          child: const Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Stack(
        alignment: Alignment.center,
        children: [
          Icon(Icons.local_shipping_outlined, size: 50, color:const Color.fromARGB(255, 36, 72, 136)),
          Positioned(
            top: 0,
            right: -1,
            child: Icon(Icons.add_circle, size: 25, color: const Color.fromARGB(255, 36, 72, 136)),
          ),
        ],
      ),
      SizedBox(height: 5),
      Text(
        "New Order",
        style: TextStyle(color: Color.fromARGB(255, 12, 24, 46), fontSize: 15, fontWeight: FontWeight.w800),
      ),
    ],
  ),


        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(selectedIndex: 0, onItemTapped: (int value) {  },)
     
    );
  }
}
