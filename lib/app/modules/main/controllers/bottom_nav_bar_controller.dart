import 'package:get/get.dart';



class BottomNavBarController extends GetxController {
  final currentIndex = 0.obs;

  final tabs = const ['Home', 'Trade', 'Portfolio', 'History', 'Premium'];

  void changePage(int index) {
    currentIndex.value = index;
  }
}
