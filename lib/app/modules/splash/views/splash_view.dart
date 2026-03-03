import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paper_trade/app/data/local_storage.dart';
import 'package:paper_trade/app/routes/app_pages.dart';
import 'package:paper_trade/app/themes/app_theme.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
  }

  void _checkAuthStatus() async {
    await Future.delayed(const Duration(seconds: 2));

    final token = LocalStorage.getAccessToken();
    print("Splash Token: $token");

    if (token != null && token.isNotEmpty) {
      Get.offAllNamed(Routes.BottomNavBar);
    } else {
      Get.offAllNamed(Routes.LOGIN);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightPrimary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.show_chart_rounded, size: 80, color: Colors.white),
            const SizedBox(height: 20),
            Text(
              "Paper Trade",
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),
            const CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 2,
            ),
          ],
        ),
      ),
    );
  }
}
