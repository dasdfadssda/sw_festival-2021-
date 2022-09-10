import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sw_festival/Auth/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Google Login"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        width: size.width,
        height: size.height,
        padding: EdgeInsets.only(
            left: 20, right: 20, top: size.height * 0.2, bottom: size.height * 0.5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("여기다 로고 넣으면 될듯",
                style: TextStyle(
                    fontSize: 30
                )),
            // ListTile(
            //     onTap: () {
            //       signInWithGoogle();
            //     },
            //     title: Text('L',style: TextStyle(fontSize: 30),)),
            ElevatedButton(
              onPressed:() {
                signInWithGoogle();
              },
              child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Image.asset('assets/google.png',
          height: 20,
          ),
          SizedBox(width: 12),
          Text('Sign in with Google'),
        ],
      ),
              )
          ],
        ),
      ),
    );
  }
}