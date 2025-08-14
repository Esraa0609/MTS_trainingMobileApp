import 'package:flutter_application_1_1/Models/localeModel.dart';
import 'package:flutter_application_1_1/Utils/data/data.dart';
import 'package:flutter_application_1_1/Widgets/appBar.dart';
import 'package:flutter_application_1_1/Widgets/lang_card.dart';
import 'package:flutter_application_1_1/Widgets/sideMenu.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../../Widgets/setting_item.dart';
import '../../Widgets/setting_switch.dart';
import 'package:flutter/material.dart';

class Settingsscreen extends StatefulWidget {
  final String userId;
  const Settingsscreen({required this.userId, super.key});

  @override
  _SettingsscreenState createState() => _SettingsscreenState();
}

class _SettingsscreenState extends State<Settingsscreen> {
  bool isDarkMode = false;
  bool _isExpanded = false;
  bool _isSelected = false;

  String get userId => widget.userId;

  Map<String, String>? findUserByID(String id) {
    return Data.users.firstWhere(
      (user) => user['userID'] == id,
    );
  }

   void _showLanguageDialog()
  {
    showDialog(context: context, builder: (BuildContext context)
    {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16)
        ),
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Select Language', style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
              SizedBox(height: 16,),
              _buildLanguagwItem(context, '🇬🇧', AppLocalizations.of(context)!.settings_lang_en, 'en'),
              _buildLanguagwItem(context, '🇵🇸',  AppLocalizations.of(context)!.settings_lang_ar, 'ar'),
              _buildLanguagwItem(context, '🇪🇸',  AppLocalizations.of(context)!.settings_lang_es, 'es'),
              _buildLanguagwItem(context, '🇮🇹',  AppLocalizations.of(context)!.settings_lang_it, 'it'),
              _buildLanguagwItem(context, '🇯🇵',  AppLocalizations.of(context)!.settings_lang_ja, 'ja'),
              _buildLanguagwItem(context, '🇩🇪',  AppLocalizations.of(context)!.settings_lang_de, 'de'),
            ],
          ),
        ),
      );
    }
    );
  }

 Widget _buildLanguagwItem(BuildContext context, String flag, String Name, String code)
 {
    final localeModel = Provider.of<LocaleModel>(context);

  return GestureDetector(
     onTap: (){
      localeModel.setLocale(Locale(code));
      Navigator.of(context).pop();
     },
     child: Column(
       children: [
        Row(
          children: [
            Text(flag, style: TextStyle(fontSize: 24),),
            SizedBox(width: 12,),
            Text(Name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
          ],
        ),
        const Divider()
       ],
     ),
  );
 }

  @override
  Widget build(BuildContext context) {
    final user = findUserByID(userId);

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: appBar(
        title: AppLocalizations.of(context)!.sidemenu_settings,
      ),
      drawer: sideMenu(userId: user!['userID']!),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.05), // Responsive padding
          child: Column(
            children: [
              SettingItem(
                title: AppLocalizations.of(context)!.settings_lang,
                icon: Icons.public,
                onTap: () {
                 _showLanguageDialog();
                },
              ),
              const Divider(),
              SizedBox(height: screenHeight * 0.03),
              SettingSwitch(
                title: AppLocalizations.of(context)!.settings_dark_mode,
                icon: Icons.nightlight_round,
                value: isDarkMode,
                onTap: (value) {
                  setState(() {
                    isDarkMode = value;
                  });
                },
              ),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
