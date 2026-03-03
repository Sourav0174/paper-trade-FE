import 'package:get/get.dart';

import '../modules/chart/bindings/chart_binding.dart';
import '../modules/chart/views/chart_view.dart';
import '../modules/history/bindings/history_binding.dart';
import '../modules/history/views/history_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/main/bindings/bottom_nav_bar_binding.dart';
import '../modules/main/views/bottom_nav_bar_view.dart';
import '../modules/otp/bindings/otp_binding.dart';
import '../modules/otp/views/otp_view.dart';
import '../modules/portfolio/bindings/portfolio_binding.dart';
import '../modules/portfolio/views/portfolio_view.dart';
import '../modules/settings/bindings/settings_binding.dart';
import '../modules/settings/views/settings_view.dart';
import '../modules/sign_up/bindings/sign_up_binding.dart';
import '../modules/sign_up/views/sign_up_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/subscription/bindings/subscription_binding.dart';
import '../modules/subscription/views/subscription_view.dart';
import '../modules/trade/bindings/trade_binding.dart';
import '../modules/trade/views/trade_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();
  static const INITIAL = Routes.SPLASH;
  static final routes = [
    GetPage(
      name: Routes.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.OTP,
      page: () => const OtpView(),
      binding: OtpBinding(),
    ),
    GetPage(
      name: Routes.BottomNavBar,
      page: () => const BottomNavBarView(),
      binding: BottomNavBarBinding(),
      children: [
        GetPage(
          name: Routes.HOME,
          page: () => const HomeView(),
          binding: HomeBinding(),
        ),
        GetPage(
          name: Routes.TRADE,
          page: () => const TradeView(),
          binding: TradeBinding(),
        ),
        GetPage(
          name: Routes.PORTFOLIO,
          page: () => const PortfolioView(),
          binding: PortfolioBinding(),
        ),
        GetPage(
          name: Routes.HISTORY,
          page: () => const HistoryView(),
          binding: HistoryBinding(),
        ),
        GetPage(
          name: Routes.SUBSCRIPTION,
          page: () => const SubscriptionView(),
          binding: SubscriptionBinding(),
        ),
      ],
    ),
    GetPage(
      name: Routes.SETTINGS,
      page: () => const SettingsView(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: _Paths.CHART,
      page: () => const ChartView(),
      binding: ChartBinding(),
    ),
    GetPage(
      name: _Paths.SIGN_UP,
      page: () => const SignUpView(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
  ];
}

// class AppPages {
//   AppPages._();

//   static const INITIAL = Routes.HOME;

//   static final routes = [
//     GetPage(
//       name: _Paths.HOME,
//       page: () => const HomeView(),
//       binding: HomeBinding(),
//     ),
//     GetPage(
//       name: _Paths.BottomNavBar,
//       page: () => const BottomNavBarView(),
//       binding: BottomNavBarBinding(),
//     ),
//     GetPage(
//       name: _Paths.LOGIN,
//       page: () => const LoginView(),
//       binding: LoginBinding(),
//     ),
//   ];
// }
