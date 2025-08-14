import 'forward_button.dart';
import 'package:flutter/material.dart';

class SettingItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function() onTap;

  const SettingItem({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Get the screen width and height
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Adjust container and icon size based on screen size
    double containerSize = screenHeight * 0.07; // Example: 7% of the screen height
    double iconSize = containerSize * 0.5; // Icon size relative to container size
    double textSize = screenWidth * 0.045; // Text size relative to screen width

    return GestureDetector(
        onTap: onTap,
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
              color: const Color.fromARGB(255, 255, 255, 255),
              size: iconSize,
            ),
          ),
          SizedBox(width: screenWidth * 0.05), // Responsive spacing
          Text(
            title,
            style: TextStyle(
              fontSize: textSize,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          
        ],
      ),
    
    );
  }
}
