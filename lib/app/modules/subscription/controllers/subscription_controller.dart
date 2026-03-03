import 'package:get/get.dart';

class SubscriptionController extends GetxController {
  final selectedPlan = 'Monthly'.obs;

  void selectPlan(String plan) {
    selectedPlan.value = plan;
  }
}
