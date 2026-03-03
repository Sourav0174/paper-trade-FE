import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paper_trade/app/data/models/dummy_point.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../controllers/chart_controller.dart';

class ChartView extends GetView<ChartController> {
  const ChartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NIFTY 50'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _timeFrameButton('5m', TimeFrame.m5),
                _timeFrameButton('15m', TimeFrame.m15),
                _timeFrameButton('30m', TimeFrame.m30),
                _timeFrameButton('1H', TimeFrame.h1),
                _timeFrameButton('4H', TimeFrame.h4),
                _timeFrameButton('1D', TimeFrame.d1),
                _timeFrameButton('1W', TimeFrame.w1),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Obx(() {
              return Row(
                children: [
                  // SMA Toggle
                  Row(
                    children: [
                      Checkbox(
                        value: controller.showSMA.value,
                        onChanged: (v) => controller.showSMA.value = v ?? false,
                      ),
                      const Text("SMA"),
                    ],
                  ),

                  const SizedBox(width: 8),

                  // EMA Toggle
                  Row(
                    children: [
                      Checkbox(
                        value: controller.showEMA.value,
                        onChanged: (v) {
                          controller.showEMA.value = v ?? false;

                          if (!(v ?? false)) {
                            controller.activeEmaPeriods.clear();
                            controller.emaLines.clear();
                          } else {
                            controller.activeEmaPeriods.assignAll(
                              controller.defaultEmaPeriods,
                            );
                            controller.calculateAllEMAs();
                          }
                        },
                      ),
                      const Text("EMA"),
                    ],
                  ),

                  const Spacer(),

                  // EMA Period Input
                  SizedBox(
                    width: 60,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: "Add EMA",
                        isDense: true,
                      ),
                      onSubmitted: (value) {
                        int? period = int.tryParse(value);
                        if (period != null && period > 0) {
                          controller.addCustomEMA(period);
                        }
                      },
                    ),
                  ),
                ],
              );
            }),
          ),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Obx(() {
              if (!controller.showEMA.value) return const SizedBox();

              return Wrap(
                spacing: 12,
                children: controller.activeEmaPeriods.map((period) {
                  Color color;

                  switch (period) {
                    case 20:
                      color = Colors.green;
                      break;
                    case 50:
                      color = Colors.blue;
                      break;
                    case 200:
                      color = Colors.red;
                      break;
                    default:
                      color = Colors.purple;
                  }

                  final lastValue =
                      controller.emaLines[period]?.last.value.toStringAsFixed(
                        2,
                      ) ??
                      "--";

                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(width: 10, height: 10, color: color),
                      const SizedBox(width: 4),
                      Text(
                        "EMA $period: $lastValue",
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  );
                }).toList(),
              );
            }),
          ),

          const SizedBox(height: 12),

          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.candleData.isEmpty) {
                return const Center(child: Text('No candle data'));
              }

              return SfCartesianChart(
                zoomPanBehavior: ZoomPanBehavior(
                  enablePinching: true,
                  enablePanning: true,
                  zoomMode: ZoomMode.x,
                ),
                crosshairBehavior: CrosshairBehavior(
                  enable: true,
                  activationMode: ActivationMode.longPress,
                ),

                tooltipBehavior: TooltipBehavior(enable: true),
                primaryXAxis: CategoryAxis(),
                primaryYAxis: NumericAxis(opposedPosition: true),

                series: <CartesianSeries>[
                  CandleSeries<IndexCandlePoint, String>(
                    dataSource: controller.candleData,
                    xValueMapper: (d, _) => d.time,
                    lowValueMapper: (d, _) => d.low,
                    highValueMapper: (d, _) => d.high,
                    openValueMapper: (d, _) => d.open,
                    closeValueMapper: (d, _) => d.close,
                  ),

                  if (controller.showSMA.value)
                    LineSeries<IndexPoint, String>(
                      name: "SMA",
                      dataSource: controller.smaData,
                      xValueMapper: (d, _) => d.time,
                      yValueMapper: (d, _) => d.value,
                      color: Colors.orange,
                      width: 2,
                    ),

                  if (controller.showEMA.value)
                    ...controller.emaLines.entries.map((entry) {
                      final period = entry.key;
                      final data = entry.value;

                      Color color;

                      switch (period) {
                        case 20:
                          color = Colors.green;
                          break;
                        case 50:
                          color = Colors.blue;
                          break;
                        case 200:
                          color = Colors.red;
                          break;
                        default:
                          color = Colors.purple;
                      }

                      return LineSeries<IndexPoint, String>(
                        name: "EMA $period",
                        dataSource: data,
                        xValueMapper: (d, _) => d.time,
                        yValueMapper: (d, _) => d.value,
                        color: color,
                        width: 2,
                      );
                    }),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _timeFrameButton(String label, TimeFrame tf) {
    return Obx(() {
      final isSelected = controller.selectedTimeFrame.value == tf;

      return GestureDetector(
        onTap: () => controller.changeTimeFrame(tf),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          margin: const EdgeInsets.only(right: 8),
          decoration: BoxDecoration(
            color: isSelected ? Colors.blue : Colors.grey.shade200,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );
    });
  }
}
