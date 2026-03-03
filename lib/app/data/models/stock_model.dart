class StockModel {
  final String symbol;
  final String name;
  final String exchange;
  final double currentPrice;
  final double changePercent;
  final double changeValue;
  final bool isUp;
  final String category;

  StockModel({
    required this.symbol,
    required this.name,
    required this.exchange,
    required this.currentPrice,
    required this.changePercent,
    required this.changeValue,
    required this.isUp,
    this.category = 'All',
  });
  factory StockModel.fromJson(Map<String, dynamic> json) => StockModel(
    symbol: json['symbol'] ?? '',
    name: json['name'] ?? '',
    exchange: json['exchange'] ?? 'NSE', // fallback
    currentPrice: (json['value'] ?? 0).toDouble(),
    changePercent: (json['changePercent'] ?? 0).toDouble(),
    changeValue: ((json['value'] ?? 0) * ((json['changePercent'] ?? 0) / 100))
        .toDouble(), // calculate manually
    isUp: json['isUp'] ?? false,
    category: json['category'] ?? 'All',
  );
  // factory StockModel.fromJson(Map<String, dynamic> json) => StockModel(
  //   symbol: json['symbol'],
  //   name: json['name'],
  //   exchange: json['exchange'],
  //   currentPrice: json['currentPrice'].toDouble(),
  //   changePercent: json['changePercent'].toDouble(),
  //   changeValue: json['changeValue'].toDouble(),
  //   isUp: json['isUp'],
  //   category: json['category'] ?? 'All',
  // );

  Map<String, dynamic> toJson() => {
    'symbol': symbol,
    'name': name,
    'exchange': exchange,
    'currentPrice': currentPrice,
    'changePercent': changePercent,
    'changeValue': changeValue,
    'isUp': isUp,
    'category': category,
  };

  String get symbolInitial => symbol.isNotEmpty ? symbol[0] : 'S';
}
