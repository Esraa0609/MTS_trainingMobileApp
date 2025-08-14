import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class ForwardButton extends StatelessWidget {
  final Function() onTap;
  final bool selected;

  const ForwardButton({
    super.key,
    required this.onTap,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    // Get the screen width and height
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Adjust button size based on screen size
    double buttonSize = screenWidth * 0.15; // Example: 15% of the screen width

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: buttonSize,
        height: buttonSize,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Icon(
          selected ? Ionicons.chevron_down_outline : Ionicons.chevron_forward_outline,
          size: buttonSize * 0.5, // Icon size relative to button size
        ),
      ),
    );
  }
}
