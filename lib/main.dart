import 'package:flutter/material.dart';
import 'package:flutter_application_1_1/Models/cart_provider.dart';
import 'package:flutter_application_1_1/Models/localeModel.dart';
import 'package:flutter_application_1_1/Screens/LoginScreen/LoginScreen.dart';
import 'package:flutter_application_1_1/Screens/ProductsPage/ProductsPage.dart';
import 'package:flutter_application_1_1/Screens/SettingsScreen/SettingsScreen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LocaleModel()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LocaleModel>(
      builder: (context, localeModel, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          locale: localeModel.locale,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const LoginScreen(),
        );
      },
    );
  }
}
