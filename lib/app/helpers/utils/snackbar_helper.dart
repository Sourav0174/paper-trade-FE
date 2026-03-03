import 'package:get/get.dart';

class SnackbarHelper {
  static void showNoInternet() {
    if (Get.isSnackbarOpen) return;

    Get.snackbar(
      "No Internet",
      "Please check your internet connection and try again.",
      snackPosition: SnackPosition.BOTTOM,

      duration: const Duration(seconds: 3),
    );
  }

  static void showTimeout() {
    if (Get.isSnackbarOpen) return;

    Get.snackbar(
      "Request Failed",
      "Server not responding. Please try again later.",
      snackPosition: SnackPosition.BOTTOM,

      duration: const Duration(seconds: 3),
    );
  }
}
