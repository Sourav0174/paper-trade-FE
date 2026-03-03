import 'package:dio/dio.dart';
import 'package:paper_trade/app/data/dummy/nifty_dummy.dart';
import 'package:paper_trade/app/data/models/dummy_point.dart';
import 'package:paper_trade/app/modules/chart/controllers/chart_controller.dart';

class IndexService {
  final Dio dio;

  IndexService(this.dio);

  Future<List<IndexCandlePoint>> fetchNiftyCandles(TimeFrame timeFrame) async {
    await Future.delayed(const Duration(milliseconds: 800));

    final data = niftyCandleByTimeFrame[timeFrame] ?? [];

    return data.map((e) => IndexCandlePoint.fromJson(e)).toList();
  }

  Future<List<IndexPoint>> fetchNifty() async {
    await Future.delayed(const Duration(milliseconds: 800));
    return niftyDummyData.map((e) => IndexPoint.fromJson(e)).toList();
  }
}
