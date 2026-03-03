import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../controllers/chart_controller.dart';
import '../../../data/services/index_service.dart';

class ChartBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Dio>(() => Dio());
    Get.lazyPut<IndexService>(() => IndexService(Get.find()));
    Get.lazyPut<ChartController>(() => ChartController(Get.find()));
  }
}
