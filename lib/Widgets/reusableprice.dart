import 'package:flutter/material.dart';

class ReusableWidget extends StatelessWidget {
  final String title;
  final String value;
  final TextStyle? titleStyle;
  final TextStyle? valueStyle;
  final EdgeInsetsGeometry padding;

  const ReusableWidget({
    Key? key,
    required this.title,
    required this.value,
    this.titleStyle,
    this.valueStyle,
    this.padding = const EdgeInsets.symmetric(vertical: 0.0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Container(
        color: const Color.fromARGB(255, 36, 72, 136),
        height: 60,
        child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(width:20),
          Expanded(
            child: Text(
              title, 
              style: titleStyle ?? const TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: valueStyle ?? const TextStyle(color: Color.fromARGB(255, 206, 200, 200), fontSize: 20),
              textAlign: TextAlign.end,
            ),
          ),
          const SizedBox(width: 20,)
        ],
      ),
    )
      );
  }
}
