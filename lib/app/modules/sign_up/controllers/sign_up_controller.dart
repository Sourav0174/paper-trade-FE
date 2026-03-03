import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paper_trade/app/data/api_constants.dart';
import 'package:paper_trade/app/data/api_provider.dart';

import 'package:paper_trade/app/routes/app_pages.dart';

class SignUpController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final APIProvider _apiProvider = APIProvider();

  /// Controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  /// Observables
  final selectedGender = ''.obs;
  final isPasswordVisible = false.obs;
  final isConfirmPasswordVisible = false.obs;
  final areTermsAccepted = false.obs;
  final isFormValid = false.obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    nameController.addListener(checkFormValidity);
    emailController.addListener(checkFormValidity);
    passwordController.addListener(checkFormValidity);
    confirmPasswordController.addListener(checkFormValidity);
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  // ---------------- FORM VALIDITY ---------------- //

  void checkFormValidity() {
    isFormValid.value =
        nameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty &&
        selectedGender.value.isNotEmpty &&
        areTermsAccepted.value;
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  void setGender(String gender) {
    selectedGender.value = gender;
    checkFormValidity();
  }

  void toggleTerms(bool? value) {
    areTermsAccepted.value = value ?? false;
    checkFormValidity();
  }

  // ---------------- VALIDATORS ---------------- //

  String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Name is required";
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Email is required";
    }
    if (!GetUtils.isEmail(value)) {
      return "Enter valid email";
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    }
    if (value.length < 6) {
      return "Password must be at least 6 characters";
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Confirm your password";
    }
    if (value != passwordController.text) {
      return "Passwords do not match";
    }
    return null;
  }

  // ---------------- API CALL ---------------- //

  Future<void> onSignUpPressed() async {
    if (!formKey.currentState!.validate()) {
      log("❌ Form validation failed", name: "SIGNUP");
      return;
    }

    if (!areTermsAccepted.value) {
      Get.snackbar(
        "Error",
        "Please accept Terms & Conditions",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    final Map<String, dynamic> body = {
      "name": nameController.text.trim(),
      "email": emailController.text.trim(),
      "password": passwordController.text.trim(),
      "gender": selectedGender.value.toUpperCase(),
    };

    final Map<String, dynamic> headers = {"Accept": "application/json"};

    try {
      isLoading.value = true;

      log("📤 Signup Request Body: $body", name: "SIGNUP");

      final response = await _apiProvider.postAPICall(
        ApiConstants.signup, // 🔥 change to your real endpoint
        body,
        headers,
      );

      final resData = response.data;

      log("📥 Signup Response: $resData", name: "SIGNUP");

      if (resData["success"] == true ||
          resData["statusCode"] == 201 ||
          resData["code"] == 100) {
        Get.snackbar(
          "Success",
          "Verification email sent",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        Get.offAllNamed(Routes.LOGIN);
      } else {
        Get.snackbar(
          "Error",
          resData["message"] ?? "Signup failed",
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e, stack) {
      log("🔥 Signup Exception", name: "SIGNUP", error: e, stackTrace: stack);

      Get.snackbar(
        "Error",
        handleDioError(e),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
