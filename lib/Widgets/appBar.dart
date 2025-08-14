import 'package:flutter/material.dart';

class appBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const appBar({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    // Get the screen width
    double screenWidth = MediaQuery.of(context).size.width;

    // Adjust text size based on screen width
    double titleFontSize = screenWidth * 0.065; // Example: 6.5% of screen width

    return AppBar(
      title: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: titleFontSize,
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 36, 72, 136),
      iconTheme: const IconThemeData(color: Colors.white),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
