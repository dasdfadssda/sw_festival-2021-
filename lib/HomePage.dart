import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sw_festival/Auth/auth_service.dart';
import 'package:sw_festival/Page/MainScreen.dart';
import 'package:sw_festival/Page/Setting/Settings.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
  
}

class _HomePageState extends State<HomePage> {
final FirebaseAuth _auth = FirebaseAuth.instance;


int _selectedIndex = 0;
  Color? bgColorBottomNavigationBar;
  Color? iconColor;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

var my_list2 = ['홈', '찜', '채팅','프로필'];

 final List<Widget> _widgetOptions = <Widget>[
    MainScreen(),
    MainScreen(),
   MainScreen(),
    Settings(),
 ];

  //String? user = FirebaseAuth.instance.currentUser!.email ?? FirebaseAuth.instance.currentUser!.displayName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Drawer(
          elevation: 0,
          backgroundColor: Colors.blueAccent,
          child: Icon(Icons.menu)
          ),
        title: Text(my_list2.elementAt(_selectedIndex)),
        actions: [
          Row(children: [
            IconButton(
              onPressed: () {
                signOut();
              }, 
              icon: Icon(Icons.notifications)),
              SizedBox(
                width: 5,
              )
          ],)
        ],
        backgroundColor: Colors.blueAccent,
      ),
      body: SafeArea(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 10,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: iconColor,
            ),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.bookmark,
              color: iconColor,
            ),
            label: '찜',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.chat,
              color: iconColor,
            ),
            label: '채팅',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle,
              color: iconColor,
            ),
            label: '프로필',
          ),
        ],
        
        currentIndex: _selectedIndex,
        //selectedLabelStyle: Theme.of(context).primaryTextTheme.caption,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        backgroundColor: bgColorBottomNavigationBar,
        onTap: _onItemTapped,
      ),
    );
  }
}