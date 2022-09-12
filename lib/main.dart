import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sw_festival/Page/detialPage.dart';
import 'package:sw_festival/models/model_provider.dart';
import 'Auth/auth_service.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider<ItemProvider>(
      create: (context) => ItemProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes : { //route 설정
    '/detail' : (context) => DetailScreen()
  },
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: AuthService().handleAuthState(), // 로그인 유무 확인
    );
  }
}

