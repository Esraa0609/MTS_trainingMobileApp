import 'package:flutter/material.dart';
import 'package:flutter_application_1_1/Utils/data/products.dart';

class lineProd extends StatelessWidget{
  final int index;
  const lineProd({required this.index});
  Widget build(BuildContext context) {
    return Column(
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(shape: BoxShape.circle,color: (Products_Data.ProductCurrStock[index] > 0)? Color.fromARGB(255, 36, 72, 136):Colors.grey),
                      child: const Icon(Icons.circle, size: 5,color: Color.fromARGB(255, 255, 255, 255),),
                    ),
                    const SizedBox(height: 2),
                    const Icon(Icons.circle, size: 5,),
                    const SizedBox(height: 2),
                    const Icon(Icons.circle, size: 5,),
                    const SizedBox(height: 2),
                    const Icon(Icons.circle, size: 5,),
                    const SizedBox(height: 2),
                    const Icon(Icons.circle, size: 5,),
                    const SizedBox(height: 2),
                    const Icon(Icons.circle, size: 5,),Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(shape: BoxShape.circle,color: (Products_Data.ProductCurrStock[index] > 0)? Color.fromARGB(255, 36, 72, 136):Colors.grey),
                      child: const Icon(Icons.circle, size: 5,color: Color.fromARGB(255, 255, 255, 255),),
                    ),
                  ],
                );
}
}