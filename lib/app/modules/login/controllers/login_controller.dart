import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paper_trade/app/data/api_constants.dart';
import 'package:paper_trade/app/data/api_provider.dart';
import 'package:paper_trade/app/data/local_storage.dart';
import 'package:paper_trade/app/routes/app_pages.dart';

class LoginController extends GetxController {
  final APIProvider _apiService = APIProvider();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final isLoading = false.obs;
  final obscurePassword = true.obs;

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  // ---------------- LOGIN ---------------- //

  Future<void> login() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    // ----------- BASIC VALIDATION ----------- //
    if (email.isEmpty || password.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter email and password',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (!GetUtils.isEmail(email)) {
      Get.snackbar(
        'Error',
        'Enter a valid email address',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    // ----------- FORM BODY (x-www-form-urlencoded) ----------- //
    final Map<String, dynamic> body = {
      "grant_type": "password",
      "username": email,
      "password": password,
      "scope": "",
      "client_id": "string",
      "client_secret": "string",
    };

    final headers = {
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded",
    };

    try {
      isLoading.value = true;

      log("📤 Login Request: $body", name: "LOGIN");

      final response = await _apiService.postAPICall(
        ApiConstants.signIn,
        body,
        headers,
      );

      final resData = response.data;

      log("📥 Login Response: $resData", name: "LOGIN");

      // ----------- SUCCESS CASE ----------- //
      if (resData["access_token"] != null) {
        final accessToken = resData["access_token"];
        final user = resData["user"];

        // ✅ Store using GetStorage wrapper
        LocalStorage.setAccessToken(accessToken: accessToken);
        LocalStorage.setUserId(userId: user["id"].toString());
        LocalStorage.setUserName(userName: user["name"] ?? "");
        LocalStorage.setUserEmail(userEmail: user["email"] ?? "");

        Get.snackbar(
          "Success",
          "Login successful",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        Get.offAllNamed(Routes.BottomNavBar);
      } else {
        Get.snackbar(
          "Error",
          "Invalid credentials",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    }
    // ----------- DIO ERROR HANDLING ----------- //
    catch (e, stack) {
      log("🔥 Login Exception", name: "LOGIN", error: e, stackTrace: stack);

      String errorMessage = "Login failed. Please try again.";

      if (e.toString().contains("401")) {
        errorMessage = "Incorrect email or password";
      } else if (e.toString().contains("400")) {
        errorMessage = "Invalid request format";
      } else if (e.toString().contains("SocketException")) {
        errorMessage = "No internet connection";
      }

      Get.snackbar(
        "Error",
        errorMessage,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void navigateToOtp() {
    Get.toNamed(Routes.OTP);
  }
}
