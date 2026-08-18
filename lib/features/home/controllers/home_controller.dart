import 'package:get/get.dart';

class HomeController extends GetxController {
  // Current bottom navigation index
  final RxInt selectedIndex = 0.obs;

  // Change bottom navigation
  void changeBottomNav(int index) {
    selectedIndex.value = index;
  }
}