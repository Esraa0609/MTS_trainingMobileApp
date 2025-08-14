import 'package:flutter/material.dart';
import '../../widgets/login_widgets.dart';

class LoginScreen extends BaseScreen {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends BaseScreenState<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Image.asset(
                    'lib/assets/Test1.png',
                    width: 350,
                  ),
                  const SizedBox(height: 15),
                  buildUsernameField(),
                  buildPasswordField(),
                  buildActionButton(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
