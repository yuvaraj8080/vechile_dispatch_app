import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vechile_dispatch_app/Chat_Module/ChatBot.dart';

import '../../Constants/Constants.dart';
import '../../GetX_BottomPage/bottompage_controller.dart';
import 'Bottom_Screens/Chat_Page.dart';
import 'Bottom_Screens/UserHome_Screen.dart';
import 'Bottom_Screens/add_Contacts.dart';

class BottomPage extends StatelessWidget {
  final BottomPageController _controller = Get.put(BottomPageController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        extendBody: true,
        body: Obx(() => _getPage(_controller.currentIndex.value)),
        bottomNavigationBar: Obx(
              () => BottomNavigationBar(
            items: _bottomNavBarItems,
            currentIndex: _controller.currentIndex.value,
            selectedItemColor: primaryColor,
            onTap: _controller.changeIndex,
            type: BottomNavigationBarType.fixed,
          ),
        ),
      ),
    );
  }

  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return const AddContactsPage();
      case 1:
        return const ChatPage();
      case 2:
        return HomeScreen();
      case 3:
        return const ChatBotScreen();
      default:
        return HomeScreen();
    }
  }

  final List<BottomNavigationBarItem> _bottomNavBarItems = [
    const BottomNavigationBarItem(icon: Icon(Icons.contacts), label: 'Contacts'),
    const BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
    const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    const BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'ChatBOt'),
  ];
}
