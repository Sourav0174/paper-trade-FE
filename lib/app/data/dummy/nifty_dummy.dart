import 'package:paper_trade/app/modules/chart/controllers/chart_controller.dart';

final niftyDummyData = [
  {"time": "09:15", "value": 21750},
  {"time": "09:30", "value": 21780},
  {"time": "09:45", "value": 21720},
  {"time": "10:00", "value": 21810},
  {"time": "10:15", "value": 21840},
];

final niftyCandleDummyData = [
  {"time": "09:15", "open": 21750, "high": 21800, "low": 21720, "close": 21780},
  {"time": "09:30", "open": 21780, "high": 21820, "low": 21760, "close": 21810},
  {"time": "09:45", "open": 21810, "high": 21830, "low": 21790, "close": 21800},
  {"time": "10:00", "open": 21800, "high": 21850, "low": 21790, "close": 21840},
];

final Map<TimeFrame, List<Map<String, dynamic>>> niftyCandleByTimeFrame = {
  TimeFrame.m5: niftyCandleDummyData,

  TimeFrame.m15: [
    {
      "time": "09:15",
      "open": 21750,
      "high": 21850,
      "low": 21720,
      "close": 21840,
    },
  ],

  TimeFrame.m30: [
    {
      "time": "09:15",
      "open": 21750,
      "high": 21850,
      "low": 21720,
      "close": 21840,
    },
  ],

  TimeFrame.h1: [
    {
      "time": "09:15",
      "open": 21750,
      "high": 21850,
      "low": 21720,
      "close": 21840,
    },
  ],

  TimeFrame.h4: [
    {
      "time": "Today",
      "open": 21680,
      "high": 21900,
      "low": 21650,
      "close": 21840,
    },
  ],

  TimeFrame.d1: [
    {
      "time": "13 Feb",
      "open": 21500,
      "high": 21900,
      "low": 21450,
      "close": 21840,
    },
  ],

  TimeFrame.w1: [
    {
      "time": "This Week",
      "open": 21000,
      "high": 21950,
      "low": 20800,
      "close": 21840,
    },
  ],
};
