import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sw_festival/Page/add.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
           Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddPage()),
          );
        },
        label: const Text('글 쓰기',style: TextStyle(fontWeight: FontWeight.bold),),
        icon: const Icon(Icons.add,size: 25,),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView(children: [
        
      ],)
    );
  }


}