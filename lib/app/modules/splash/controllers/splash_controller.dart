import 'package:get/get.dart';
import 'package:paper_trade/app/routes/app_pages.dart';
import 'package:paper_trade/app/data/local_storage.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    print("init");
    super.onInit();
    _checkAuthStatus();
  }

  void _checkAuthStatus() {
    Future.delayed(const Duration(seconds: 2));

    final token = LocalStorage.getAccessToken();

    print("Splash Token: $token"); // 👈 Add this for debug

    if (token != null && token.isNotEmpty) {
      Get.offAllNamed(Routes.BottomNavBar);
    } else {
      Get.offAllNamed(Routes.LOGIN);
    }
  }
}
