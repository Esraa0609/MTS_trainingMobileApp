import 'package:flutter/material.dart';
import 'package:flutter_application_1_1/Screens/FirstScreen/firstscreen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginService {
  // A simple list of users and passwords for demonstration purposes
  static final List<Map<String, String>> users = [
    {'userID': '20221441546', 'password': 'toka'},
    {'userID': '20221446413', 'password': 'esraa'},
    {'userID': '20221441566', 'password': 'dina'},
    {'userID': '20221440817', 'password': 'mirna'}
  ];

  static void login(BuildContext context, String username, String password) {
    if (username.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.page_login_userrequired),
          backgroundColor: Colors.redAccent,
          duration: const Duration(seconds: 3),
        ),
      );
    } else if (password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.page_login_passrequired),
          backgroundColor: Colors.redAccent,
          duration: const Duration(seconds: 3),
        ),
      );
    } else {
      // Check if the user exists in the users array
      bool isAuthenticated = users.any((user) =>
          user['userID'] == username && user['password'] == password);

      if (isAuthenticated) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => FirstScreen(userId : username)),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text(AppLocalizations.of(context)!.page_login_invaliduserpass),
            backgroundColor: Colors.redAccent,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }
}
