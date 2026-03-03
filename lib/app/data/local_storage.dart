import 'package:get_storage/get_storage.dart';

class LocalStorage {
  static final prefs = GetStorage();

  // Access Token
  static void setAccessToken({required String? accessToken}) {
    prefs.write("accessToken", accessToken);
  }

  static String? getAccessToken() {
    return prefs.read("accessToken");
  }

  static setFCMToken(String value) {
    prefs.write("USER_FCM_TOKEN", value);
  }

  static String getFCMToken() {
    return prefs.read("USER_FCM_TOKEN") ?? "";
  }

  // Location explainer
  static void setLocationExplainerShown(bool value) {
    prefs.write('location_explainer_shown', value);
  }

  static bool isLocationExplainerShown() {
    return prefs.read('location_explainer_shown') ?? false;
  }

  // User ID
  static void setUserId({required String? userId}) {
    prefs.write("userId", userId);
  }

  static String? getUserId() {
    return prefs.read("userId");
  }

  // User Name
  static void setUserName({required String? userName}) {
    prefs.write("userName", userName);
  }

  static String? getUserName() {
    return prefs.read("userName");
  }

  // User Email
  static void setUserEmail({required String? userEmail}) {
    prefs.write("userEmail", userEmail);
  }

  static String? getUserEmail() {
    return prefs.read("userEmail");
  }

  // User Phone Number
  static void setUserPhoneNumber({required String? userPhoneNumber}) {
    prefs.write("userPhoneNumber", userPhoneNumber);
  }

  static String? getUserPhoneNumber() {
    return prefs.read("userPhoneNumber");
  }

  // ✅ Clear all local data (for logout)
  static Future<void> clearAll() async {
    await prefs.erase();
  }
}
