import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  const CustomBottomNavigationBar({
    required this.selectedIndex,
    required this.onItemTapped,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Get the screen width for responsive sizing
    double screenWidth = MediaQuery.of(context).size.width;

    // Define responsive icon and font sizes
    double iconSize = screenWidth * 0.06; // 7% of screen width
    double fontSize = screenWidth * 0.030; // 3.5% of screen width

    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home, size: iconSize),
          label: AppLocalizations.of(context)!.page_firstscreen_homeiconlabel,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.local_mall, size: iconSize),
          label: "Products",
        ),
        
        BottomNavigationBarItem(
          icon: Icon(Icons.local_shipping, size: iconSize),
          label: AppLocalizations.of(context)!.page_firstscreen_deliveryiconlabel,
        ),
      ],
      currentIndex: selectedIndex,
      backgroundColor: const Color.fromARGB(255, 36, 72, 136),
      selectedItemColor: Colors.amber[800],
      unselectedItemColor: Colors.white,
      selectedFontSize: fontSize,
      unselectedFontSize: fontSize,
      onTap: onItemTapped,
    );
  }
}
