import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingSwitch extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool value;
  final Function(bool value) onTap;

  const SettingSwitch({
    super.key,
    required this.title,
    required this.icon,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Retrieve screen dimensions
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Define responsive sizes
    double containerSize = screenHeight * 0.07; // 7% of screen height
    double iconSize = containerSize * 0.5; // 50% of container size
    double textSize = screenWidth * 0.045; // 4.5% of screen width
    double spacing = screenWidth * 0.05; // 5% of screen width

    return SizedBox(
      width: double.infinity,
      child: Row(
        children: [
          Container(
            height: containerSize,
            width: containerSize,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color.fromARGB(255, 36, 72, 136),
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: iconSize,
            ),
          ),
          SizedBox(width: spacing),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: textSize,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Text(
            value ? "On" : "Off",
            style: TextStyle(
              fontSize: textSize,
              color: Colors.grey,
            ),
          ),
          SizedBox(width: spacing),
          CupertinoSwitch(
            value: value,
            onChanged: onTap,
            activeColor: const Color.fromARGB(255, 0, 70, 37),
          ),
        ],
      ),
    );
  }
}
