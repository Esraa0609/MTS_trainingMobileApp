import 'package:flutter/material.dart';
import 'package:flutter_application_1_1/Models/cart_provider.dart';
import 'package:flutter_application_1_1/Screens/ConfirmPaymentDetails/ConfPayment.dart';
import 'package:flutter_application_1_1/Widgets/appBar.dart';
import 'package:flutter_application_1_1/Widgets/sideMenu.dart';
import 'package:provider/provider.dart';

class PaymentScreen extends StatefulWidget {
  final String userId; // Specify the type for userId
  const PaymentScreen({required this.userId, Key? key}) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String get userId => widget.userId;

  int _type = 1;

  void _handleRadio(Object? e) {
    setState(() {
      _type = e as int;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    final cart = Provider.of<CartProvider>(context);


    return Scaffold(
      appBar: appBar(title: 'Payment Method'),
      drawer: sideMenu(userId: userId),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 15),
                Container(
                  width: screenWidth,
                  height: 65,
                  decoration: BoxDecoration(
                    border: _type == 1
                        ? Border.all(width: 1, color: Colors.black)
                        : Border.all(width: 0.3, color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.transparent,
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Radio(
                                value: 1,
                                groupValue: _type,
                                onChanged: _handleRadio,
                                activeColor:
                                    Color.fromARGB(255, 36, 72, 136),
                              ),
                              Text(
                                'Cash',
                                style: _type == 1
                                    ? TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Color.fromARGB(255, 36, 72, 136))
                                    : TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey),
                              ),
                            ],
                          ),
                          Image.asset('lib/assets/cash.png',width: 100, height: 45,fit: BoxFit.cover,),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  width: screenWidth,
                  height: 65,
                  decoration: BoxDecoration(
                    border: _type == 2
                        ? Border.all(width: 1, color: Colors.black)
                        : Border.all(width: 0.3, color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.transparent,
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Radio(
                                value: 2,
                                groupValue: _type,
                                onChanged: _handleRadio,
                                activeColor:
                                    Color.fromARGB(255, 36, 72, 136),
                              ),
                              Text(
                                'Credit Card', // Corrected the spelling
                                style: _type == 2
                                    ? TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Color.fromARGB(255, 36, 72, 136))
                                    : TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey),
                              ),
                            ],
                          ),
                          Image.asset('lib/assets/visa.png', width: 125, height: 70, fit: BoxFit.cover, ),
                        ],
                      ),
                    ),
                  ),
                ),
                  SizedBox(height: 15),
                 Container(
                  width: screenWidth,
                  height: 65,
                  decoration: BoxDecoration(
                    border: _type == 3
                        ? Border.all(width: 1, color: Colors.black)
                        : Border.all(width: 0.3, color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.transparent,
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Radio(
                                value: 3,
                                groupValue: _type,
                                onChanged: _handleRadio,
                                activeColor:
                                    Color.fromARGB(255, 36, 72, 136),
                              ),
                              Text(
                                'Pay Pal', // Corrected the spelling
                                style: _type == 3
                                    ? TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Color.fromARGB(255, 36, 72, 136))
                                    : TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey),
                              ),
                            ],
                          ),
                          Image.asset('lib/assets/paypal.png', width: 125, height: 30, fit: BoxFit.cover, ),
                        ],
                      ),
                    ),
                  ),
                ),
                 SizedBox(height: 15),
                 Container(
                  width: screenWidth,
                  height: 65,
                  decoration: BoxDecoration(
                    border: _type == 4
                        ? Border.all(width: 1, color: Colors.black)
                        : Border.all(width: 0.3, color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.transparent,
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Radio(
                                value: 4,
                                groupValue: _type,
                                onChanged: _handleRadio,
                                activeColor:
                                    Color.fromARGB(255, 36, 72, 136),
                              ),
                              Text(
                                'Fawry Pay', // Corrected the spelling
                                style: _type == 4
                                    ? TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Color.fromARGB(255, 36, 72, 136))
                                    : TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey),
                              ),
                            ],
                          ),
                          Image.asset('lib/assets/fawry.png', width: 125, height: 50, fit: BoxFit.cover, ),
                        ],
                      ),
                    ),
                  ),
                ),
                 SizedBox(height: 100,),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Units',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey
                      ),
                    ),
                    Text(
                      cart.getCounter().toString(),
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                 ),
                  SizedBox(height: 15,),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Sub-total',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey
                      ),
                    ),
                    Text(
                      'L.E.'+cart.getTotalPrice().toStringAsFixed(2),
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                 ),
                  SizedBox(height: 15,),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Shipping Fees',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey
                      ),
                    ),
                    Text(
                      'L.E.60',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                 ),
                 Divider(height: 30, color: const Color.fromARGB(255, 80, 80, 80),),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey
                      ),
                    ),
                    Text(
                      'L.E.'+(cart.getTotalPrice()+60).toStringAsFixed(2),
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    )
                  ],
                 ),
                 SizedBox(height: 50,),
                 Container(
                      height: screenHeight * 0.07,
                      width: screenWidth ,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 36, 72, 136),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_)=> ConfPayment(userId: userId, PaymentType: _type)));
                        },
                        child: Center(
                          child: Text(
                            "Confirm Payment",
                            style: TextStyle(
                              fontSize: screenWidth * 0.05,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                 )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
