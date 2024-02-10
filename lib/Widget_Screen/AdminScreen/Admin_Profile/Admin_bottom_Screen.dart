import 'package:flutter/material.dart';

import '../../../Constants/Constants.dart';
import '../../Admin_list_Screen/adminHome_Screen.dart';
import 'Admin_PRofile.dart';
import 'Admin_home_Screen.dart';



class Admin_Bottom_page extends StatefulWidget {
  const Admin_Bottom_page({Key? key}) : super(key: key);

  @override
  State<Admin_Bottom_page> createState() => _Admin_Bottom_pageState();
}

class _Admin_Bottom_pageState extends State<Admin_Bottom_page> {
  int currentIndex = 0;

  final List<Widget> pages = [

    const Admin_List_user(),
    admin_home_screen(),
     Admin_profile(),
  ];

  final List<BottomNavigationBarItem> bottomNavBarItems = [
    BottomNavigationBarItem(icon: Icon(Icons.list), label: 'List'),
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
