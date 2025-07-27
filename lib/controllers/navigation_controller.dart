import 'package:get/get.dart';

class NavigationController extends GetxController {
  var selectedIndex = 2.obs;

  var isModalOpen = false.obs;

  void setModalOpen(bool value) {
    isModalOpen.value = value;
  }

  void changeIndex(int index) {
    selectedIndex.value = index;
  }
}
