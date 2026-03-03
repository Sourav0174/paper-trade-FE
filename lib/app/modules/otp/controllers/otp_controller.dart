import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paper_trade/app/data/services/api_service.dart';

class OtpController extends GetxController {
  final ApiService _apiService = ApiService();

  final otp = ''.obs;
  final isLoading = false.obs;
  final resendTimer = 45.obs;

  @override
  void onInit() {
    super.onInit();
    startResendTimer();
  }

  void startResendTimer() {
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));
      if (resendTimer.value > 0) {
        resendTimer.value--;
        return true;
      }
      return false;
    });
  }

  void addDigit(String digit) {
    if (otp.value.length < 6) {
      otp.value += digit;
      if (otp.value.length == 6) {
        verifyOtp();
      }
    }
  }

  void removeDigit() {
    if (otp.value.isNotEmpty) {
      otp.value = otp.value.substring(0, otp.value.length - 1);
    }
  }

  Future<void> verifyOtp() async {
    try {
      isLoading.value = true;
      final isValid = await _apiService.verifyOtp('+91 98765 43210', otp.value);

      if (isValid) {
        // Get.offAllNamed(AppRoutes.main);
      } else {
        Get.snackbar(
          'Error',
          'Invalid OTP. Please try again.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        otp.value = '';
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Verification failed. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void resendOtp() {
    if (resendTimer.value == 0) {
      resendTimer.value = 45;
      startResendTimer();
      Get.snackbar(
        'Success',
        'OTP sent successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    }
  }
}
