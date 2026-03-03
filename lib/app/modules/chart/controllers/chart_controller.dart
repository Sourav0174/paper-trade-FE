import 'package:get/get.dart';
import 'package:paper_trade/app/data/models/dummy_point.dart';
import 'package:paper_trade/app/data/services/index_service.dart';

enum TimeFrame { m5, m15, m30, h1, h4, d1, w1 }

class ChartController extends GetxController {
  final IndexService indexService;

  ChartController(this.indexService);

  var candleData = <IndexCandlePoint>[].obs;

  var smaData = <IndexPoint>[].obs;

  var isLoading = false.obs;
  var selectedTimeFrame = TimeFrame.m5.obs;

  // Indicator Toggles
  var showSMA = true.obs;
  var showEMA = true.obs;

  // User configurable periods
  var smaPeriod = 3.obs;

  // EMA settings
  final List<int> defaultEmaPeriods = [20, 50, 200];

  var activeEmaPeriods = <int>[20, 50, 200].obs;

  // Map<period, emaData>
  var emaLines = <int, List<IndexPoint>>{}.obs;

  @override
  void onInit() {
    super.onInit();
    loadCandles();
  }

  Future<void> loadCandles() async {
    isLoading.value = true;

    final data = await indexService.fetchNiftyCandles(selectedTimeFrame.value);

    candleData.value = data;

    calculateSMA();
    calculateAllEMAs();

    isLoading.value = false;
  }

  void changeTimeFrame(TimeFrame tf) {
    if (selectedTimeFrame.value == tf) return;

    selectedTimeFrame.value = tf;
    loadCandles();
  }

  // =======================
  // SMA Calculation
  // =======================
  void calculateSMA() {
    int period = smaPeriod.value;

    if (candleData.length < period) {
      smaData.clear();
      return;
    }

    List<IndexPoint> result = [];

    for (int i = period - 1; i < candleData.length; i++) {
      double sum = 0;

      for (int j = i - (period - 1); j <= i; j++) {
        sum += candleData[j].close;
      }

      result.add(IndexPoint(time: candleData[i].time, value: sum / period));
    }

    smaData.value = result;
  }

  // =======================
  // EMA Calculation
  // =======================
  void calculateAllEMAs() {
    if (candleData.isEmpty) {
      emaLines.clear();
      return;
    }

    Map<int, List<IndexPoint>> resultMap = {};

    for (int period in activeEmaPeriods) {
      List<IndexPoint> result = [];

      double multiplier = 2 / (period + 1);
      double previousEMA = candleData.first.close;

      for (int i = 0; i < candleData.length; i++) {
        double close = candleData[i].close;

        double ema = (close - previousEMA) * multiplier + previousEMA;

        result.add(IndexPoint(time: candleData[i].time, value: ema));

        previousEMA = ema;
      }

      resultMap[period] = result;
    }

    emaLines.value = resultMap;
  }

  void addCustomEMA(int period) {
    if (period <= 0) return;

    if (activeEmaPeriods.contains(period)) return;

    activeEmaPeriods.add(period);

    final emaData = _calculateEMAForPeriod(period);
    emaLines[period] = emaData;
  }

  void removeEMA(int period) {
    activeEmaPeriods.remove(period);

    // Remove only that EMA line
    emaLines.remove(period);

    // Force refresh (important for RxMap UI update)
    emaLines.refresh();
  }

  List<IndexPoint> _calculateEMAForPeriod(int period) {
    if (candleData.isEmpty) return [];

    List<IndexPoint> result = [];

    double multiplier = 2 / (period + 1);
    double previousEMA = candleData.first.close;

    for (int i = 0; i < candleData.length; i++) {
      double close = candleData[i].close;

      double ema = (close - previousEMA) * multiplier + previousEMA;

      result.add(IndexPoint(time: candleData[i].time, value: ema));

      previousEMA = ema;
    }

    return result;
  }

  void updateSMAPeriod(int period) {
    smaPeriod.value = period;
    calculateSMA();
  }

  // void updateEMAPeriod(int period) {
  //   emaPeriod.value = period;
  //   calculateEMA();
  // }
}
