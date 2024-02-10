import 'package:flutter/material.dart';

import '../../Constants/Constants.dart';
import 'Bottom_Screens/Chat_Page.dart';
import 'Bottom_Screens/Profile_Screen.dart';
import 'Bottom_Screens/UserHome_Screen.dart';
import 'Bottom_Screens/add_Contacts.dart';

class BottomPage extends StatefulWidget {
  const BottomPage({Key? key}) : super(key: key);

  @override
  State<BottomPage> createState() => _BottomPageState();
}

class _BottomPageState extends State<BottomPage> {
  int currentIndex = 2;

  final List<Widget> pages = [

    const AddContactsPage(),
    const ChatPage(),
    HomeScreen(),
    const ProfilePage(),
  ];

  final List<BottomNavigationBarItem> bottomNavBarItems = [
    BottomNavigationBarItem(icon: Icon(Icons.contacts), label: 'Contacts'),
    BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),

    // BottomNavigationBarItem(icon: Icon(Icons.reviews), label: 'Reviews'),
    BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
  ];

  void onTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        extendBody: true,
        body: pages[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: bottomNavBarItems,
          currentIndex: currentIndex,
          selectedItemColor: primaryColor,
          onTap: onTapped,
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }
}
