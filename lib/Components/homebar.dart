import 'package:duds/Components/home.dart';
import 'package:duds/Components/orderdetails.dart';
import 'package:flutter/material.dart';
import 'package:duds/Components/uploadpreview_screen.dart';


import 'package:duds/Components/chat.dart';
void main() {
  runApp(HomeBar());
}

class HomeBar extends StatefulWidget {
  @override
  State<HomeBar> createState() => _HomeBarState();
}

class _HomeBarState extends State<HomeBar> {
  int currentIndex=0;
  final screens=[
HomePage(),
OrderDetail(),
Chat(),
ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) => Scaffold(
    // extendBodyBehindAppBar: true,
    body: screens[currentIndex],
    bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.white,
        unselectedItemColor: Color.fromARGB(99, 255, 255, 255),
        backgroundColor: const Color.fromARGB(255, 255, 100, 64),
        currentIndex: currentIndex,
        type : BottomNavigationBarType.fixed,
        showUnselectedLabels: false,
        onTap: (index) => setState(()=>currentIndex= index),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Checkout',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'ProfilePage',
          ),
        ],
   
        

      ),
  );

}