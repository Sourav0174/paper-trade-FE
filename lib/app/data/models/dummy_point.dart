class IndexPoint {
  final String time;
  final double value;

  IndexPoint({required this.time, required this.value});

  factory IndexPoint.fromJson(Map<String, dynamic> json) {
    return IndexPoint(time: json['time'], value: json['value'].toDouble());
  }
}

class IndexCandlePoint {
  final String time;
  final double open;
  final double high;
  final double low;
  final double close;

  IndexCandlePoint({
    required this.time,
    required this.open,
    required this.high,
    required this.low,
    required this.close,
  });

  factory IndexCandlePoint.fromJson(Map<String, dynamic> json) {
    return IndexCandlePoint(
      time: json['time'],
      open: json['open'].toDouble(),
      high: json['high'].toDouble(),
      low: json['low'].toDouble(),
      close: json['close'].toDouble(),
    );
  }
}
