import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paper_trade/app/routes/app_pages.dart';

import 'package:shared_preferences/shared_preferences.dart';

class SettingsController extends GetxController {
  final isDarkMode = false.obs;
  final notificationsEnabled = true.obs;
  final userName = 'Rahul Kumar'.obs;
  final userEmail = 'rahul.k@papertrade.in'.obs;

  @override
  void onInit() {
    super.onInit();
    loadSettings();
  }

  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    isDarkMode.value = prefs.getBool('darkMode') ?? false;
    notificationsEnabled.value = prefs.getBool('notifications') ?? true;
    userName.value = prefs.getString('userName') ?? 'Arjun Sharma';
    userEmail.value = prefs.getString('userEmail') ?? 'arjun@example.com';
  }

  Future<void> toggleDarkMode(bool value) async {
    isDarkMode.value = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('darkMode', value);
    Get.changeThemeMode(value ? ThemeMode.dark : ThemeMode.light);
  }

  Future<void> toggleNotifications(bool value) async {
    notificationsEnabled.value = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notifications', value);
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Get.offAllNamed(Routes.LOGIN);
  }
}
