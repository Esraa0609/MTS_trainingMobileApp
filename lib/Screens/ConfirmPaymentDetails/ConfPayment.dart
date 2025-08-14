import 'package:flutter/material.dart';
import 'package:flutter_application_1_1/Models/cart_provider.dart';
import 'package:flutter_application_1_1/Widgets/appBar.dart';
import 'package:flutter_application_1_1/Widgets/sideMenu.dart';
import 'package:provider/provider.dart';

class ConfPayment extends StatefulWidget {
  final String userId;
  final int PaymentType;
  const ConfPayment({required this.userId,required this.PaymentType, Key? key}) : super(key: key);

  @override
  _ConfPaymentState createState() => _ConfPaymentState();
}

class _ConfPaymentState extends State<ConfPayment> {
  String get userId => widget.userId;
  int get paymenttype => widget.PaymentType;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    final cart = Provider.of<CartProvider>(context);
    String payment;
    if(paymenttype == 1)
     payment = 'Cash';
    else if(paymenttype == 2)
     payment = 'Visa';
     else if(paymenttype == 3)
     payment = 'Pay Pal';
      else 
     payment = 'Fawry';

    return Scaffold(
      appBar: appBar(title: 'Confirm Payment'),
      drawer: sideMenu(userId: userId),    );
  }
}
