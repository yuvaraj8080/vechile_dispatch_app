import 'package:flutter/material.dart';

import '../../../Constants/Constants.dart';
import '../../Admin_list_Screen/adminHome_Screen.dart';
import 'Admin_home_Screen.dart';
import 'GoogleMap.dart';



class Admin_Bottom_page extends StatefulWidget {
  const Admin_Bottom_page({Key? key}) : super(key: key);

  @override
  State<Admin_Bottom_page> createState() => Admin_bottom_screen();
}

class Admin_bottom_screen extends State<Admin_Bottom_page> {
  int currentIndex = 0;

  final List<Widget> pages = [

    const Admin_List_user(),
    const admin_home_screen(),
    LiveLocation(),
  ];

  final List<BottomNavigationBarItem> bottomNavBarItems = [
    const BottomNavigationBarItem(icon: Icon(Icons.list), label: 'List'),
    const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),

    // BottomNavigationBarItem(icon: Icon(Icons.reviews), label: 'Reviews'),
    const BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Map'),
  ];

  void onTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SafeArea(
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
      ),
    );
  }
}
