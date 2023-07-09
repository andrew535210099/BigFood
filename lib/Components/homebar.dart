import 'package:duds/Components/home.dart';
import 'package:duds/Components/orderdetails.dart';
import 'package:flutter/material.dart';
import 'package:duds/Components/uploadpreview_screen.dart';


import 'package:duds/Components/rooms.dart';
void main() {
  runApp(HomeBar());
}

class HomeBar extends StatefulWidget {
  final int currentIndex;

  const HomeBar({Key? key, this.currentIndex = 0}) : super(key: key);
  @override
  State<HomeBar> createState() => _HomeBarState();
}

class _HomeBarState extends State<HomeBar> {
  late int currentIndex;
  void initState() {
    super.initState();
    currentIndex = widget.currentIndex;
  }
  final screens=[
HomePage(),
OrderDetail(),
RoomsPage(),
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
            label: 'Profile',
          ),
        ],
   
        

      ),
  );

}