import 'dart:ui';
import 'package:flutter/material.dart';
import '../widgets/trade_list.dart';
import './profile_screen.dart';

class MainScreen extends StatefulWidget {

  @override
  _MainScreenState createState() => _MainScreenState();
}


class _MainScreenState extends State<MainScreen> {

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    //print(_selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(112, 112, 112, 0.15),
      appBar: AppBar(
        title: Text("Molybot"),
        elevation: 5,
        leading: 
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ClipOval(
              child: Image.asset('assets/images/monopolyUncle.jpg', fit: BoxFit.cover,),
        ),
            ),
        backgroundColor: Colors.black87,
        actions: [
          IconButton(icon: Icon(Icons.search), onPressed: (){})
        ],
      ),
      body: 
      _selectedIndex==2 ? ProfileScreen()
      : TradeList(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black87,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.all_inclusive_outlined, color: Colors.grey,),
            label: 'All',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outlined, color: Colors.grey,),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined, color: Colors.grey,),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
        
    );
  }
}