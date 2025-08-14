import 'package:flutter/material.dart';
import 'package:flutter_application_1_1/Screens/setting_edit_profile/edit_screen.dart';
import 'package:flutter_application_1_1/Utils/data/data.dart';
import 'package:flutter_application_1_1/Widgets/appBar.dart';
import 'package:flutter_application_1_1/Widgets/forward_button.dart';
import 'package:flutter_application_1_1/Widgets/sideMenu.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ViewProfileScreen extends StatefulWidget {
  final String userId; // Change to `userId` to match common naming conventions
  const ViewProfileScreen({required this.userId, super.key});

  @override
  _ViewProfileScreenState createState() => _ViewProfileScreenState();
}

class _ViewProfileScreenState extends State<ViewProfileScreen> {
  String get userId => widget.userId;

  Map<String, String>? findUserByID(String id) {
    return Data.users.firstWhere(
      (user) => user['userID'] == id,
    );
  }


  @override
  Widget build(BuildContext context) {
    final user = findUserByID(userId);
    return Scaffold(
      appBar: appBar(
        title: AppLocalizations.of(context)!.sidemenu_view_profile,
      ),
      drawer: sideMenu(
        userId: user!['userID']!,
      ),
      body: 
      SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                margin:const EdgeInsets.only(top: 30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(140),
                ),
                child: const CircleAvatar(
                  radius: 100,
                 child:  Icon(Icons.person,size:200,color: Colors.white),
              ),
               ),
               Container(
                width: 500,
                height: 70,
                margin: const EdgeInsets.only(top: 50),
                padding: const EdgeInsets.all(20),
                child: Text(
                "User ID: ${user['userID']!}",
                 style: const TextStyle(fontSize: 15, fontFamily: 'Roboto Serif'),
                ),
              ),
           const Divider(),
            Container(
                width: 500,
                height: 70,
                padding: const EdgeInsets.all(20),
                child: Text(
                "User Name: ${user['username']!}",
                 style: const TextStyle(fontSize: 15, fontFamily: 'Roboto Serif'),
                ),
              ),
           const Divider(),
           Container(
                width: 500,
                height: 70,
                padding: const EdgeInsets.all(20),
                child: Text(
                "User Email: ${user['email']!}",
                 style: const TextStyle(fontSize: 15, fontFamily: 'Roboto Serif'),
                ),
              ),
           const Divider(),
            Container(
                width: 500,
                height: 70,
                padding: const EdgeInsets.all(20),
                child: Text(
                "User Phone: ${user['Phone']!}",
                 style: const TextStyle(fontSize: 15, fontFamily: 'Roboto Serif'),
                ),
              ),
           const Divider(),
           const SizedBox(height: 40,),
           Text(AppLocalizations.of(context)!.profile_account,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
              SizedBox(
                child: Row(
                  children: [
                    const SizedBox(width: 20),
                     Column(
                      children: [
                        Text(user['username']!,style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w500)),
                      ],
                    ),
                    const Spacer(),
                    ForwardButton(
                      onTap: () {
                        Navigator.push(context,MaterialPageRoute(builder: (context) => const EditAccountScreen()));
                      },
                      selected: false,
                    )
                  ],
                ),
              ),
               
          ],)
      )
      )

    );
  }
}