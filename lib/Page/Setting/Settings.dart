import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Container(
          child: Row(children: [
            Image.network(FirebaseAuth.instance.currentUser!.photoURL!),
            Column(children: [
              Text(FirebaseAuth.instance.currentUser!.displayName!,style: TextStyle(fontWeight: FontWeight.bold),),
              Text(FirebaseAuth.instance.currentUser!.email!),
            ],)
          ],),
        )
      ]),
    );
  }
}