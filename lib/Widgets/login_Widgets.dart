// lib/widgets/base_widgets.dart

import 'package:flutter/material.dart';
import '../Services/login_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


abstract class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});
}

abstract class BaseScreenState<T extends BaseScreen> extends State<T> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isVisible = false;

  Widget buildUsernameField() {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.deepPurple.withOpacity(0.2),
      ),
      child: TextFormField(
        controller: usernameController,
        decoration:  InputDecoration(
          icon: const Icon(Icons.person),
          border: InputBorder.none,
          hintText: AppLocalizations.of(context)!.page_login_username
        ),
      ),
    );
  }

  Widget buildPasswordField() {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.deepPurple.withOpacity(0.2),
      ),
      child: TextFormField(
        controller: passwordController,
        obscureText: !isVisible,
        decoration: InputDecoration(
          icon: const Icon(Icons.lock),
          border: InputBorder.none,
          hintText: AppLocalizations.of(context)!.page_login_password,
          suffixIcon: IconButton(
            onPressed:  (){
              setState(() {
                isVisible = !isVisible;
              });
            },
            icon: Icon(
              isVisible ? Icons.visibility : Icons.visibility_off,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildActionButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 50),
      height: 55,
      width: MediaQuery.of(context).size.width * .5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.deepPurple,
      ),
      child: TextButton(
        onPressed:(){ LoginService.login(context,usernameController.text,passwordController.text);} ,
        child:  Text(
          AppLocalizations.of(context)!.page_login_loginbutton,
          style: const TextStyle(fontSize: 20, fontFamily: "Roboto Serif", color: Colors.white),
        ),
      ),
    );
  }
}
