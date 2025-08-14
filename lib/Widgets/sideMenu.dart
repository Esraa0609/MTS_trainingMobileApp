import 'package:flutter/material.dart';
import 'package:flutter_application_1_1/Screens/FirstScreen/FirstScreen.dart';
import 'package:flutter_application_1_1/Screens/LoginScreen/LoginScreen.dart';
import 'package:flutter_application_1_1/Screens/SettingsScreen/SettingsScreen.dart';
import 'package:flutter_application_1_1/Screens/ViewProfileScreen/ViewProfileScren.dart';
import 'package:flutter_application_1_1/Utils/data/data.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class sideMenu extends StatefulWidget {
  final String userId;

  const sideMenu({required this.userId, super.key});

  @override
  _sideMenuState createState() => _sideMenuState();
}

class _sideMenuState extends State<sideMenu> {
  String get userId => widget.userId;

  Map<String, String>? findUserByID(String id) {
    return Data.users.firstWhere(
      (user) => user['userID'] == id,
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = findUserByID(userId);

    // Get the screen width for responsive sizing
    double screenWidth = MediaQuery.of(context).size.width;

    // Define responsive text sizes
    double titleFontSize = screenWidth * 0.04; // 5% of screen width
    double subtitleFontSize = screenWidth * 0.03; // 4% of screen width

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 36, 72, 136),
            ),
            currentAccountPicture: const Icon(Icons.face, size: 48.0, color: Colors.white),
            accountName: Text(
              user!['username']!,
              style: TextStyle(fontSize: titleFontSize),
            ),
            accountEmail: Text(
              user['email']!,
              style: TextStyle(fontSize: subtitleFontSize),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: Text(
              AppLocalizations.of(context)!.sidemenu_view_profile,
              style: TextStyle(fontSize: titleFontSize),
            ),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => ViewProfileScreen(userId: userId)),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.bar_chart),
            title: Text(
              AppLocalizations.of(context)!.sidemenu_dashboard,
              style: TextStyle(fontSize: titleFontSize),
            ),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => FirstScreen(userId: userId)),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.task),
            title: Text(
              AppLocalizations.of(context)!.sidemenu_today_tasks,
              style: TextStyle(fontSize: titleFontSize),
            ),
            // Add onTap functionality here
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: Text(
              AppLocalizations.of(context)!.sidemenu_settings,
              style: TextStyle(fontSize: titleFontSize),
            ),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => Settingsscreen(userId: userId)),
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: Text(
              AppLocalizations.of(context)!.sidemenu_logout,
              style: TextStyle(fontSize: titleFontSize),
            ),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
            ),
          ),
        ],
      ),
    );
  }
}
