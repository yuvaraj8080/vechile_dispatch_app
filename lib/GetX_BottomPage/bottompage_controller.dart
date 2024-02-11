import 'package:get/get.dart';

class BottomPageController extends GetxController {
  var currentIndex = 2.obs;

  void changeIndex(int index) {
    currentIndex.value = index;
  }
}
