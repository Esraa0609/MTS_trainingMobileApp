import 'package:flutter/material.dart';

class langCard extends StatelessWidget {
  final String language;
  final Function() onTap;
  final Color color;

  const langCard({
    required this.color,
    required this.language,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Get the screen width and height
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Adjust card size based on screen size
    double cardWidth = screenWidth * 0.42; // Example: 50% of the screen width
    double cardHeight = screenHeight * 0.065; // Example: 7% of the screen height

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: color,
        ),
        height: cardHeight,
        width: cardWidth,
        margin: EdgeInsets.only(top: screenHeight * 0.01), // Responsive margin
        child: Center(
          child: Text(
            language,
            style: TextStyle(
              color: Colors.white,
              fontSize: screenWidth * 0.035, // Responsive text size
            ),
          ),
        ),
      ),
    );
  }
}
