class HoldingModel {
  final String symbol;
  final String stockName;
  final int quantity;
  final double avgPrice;
  final double currentPrice;
  final double pnlValue;
  final double pnlPercent;
  final double weight;

  HoldingModel({
    required this.symbol,
    required this.stockName,
    required this.quantity,
    required this.avgPrice,
    required this.currentPrice,
    required this.pnlValue,
    required this.pnlPercent,
    required this.weight,
  });

  factory HoldingModel.fromJson(Map<String, dynamic> json) => HoldingModel(
    symbol: json['symbol'],
    stockName: json['stockName'],
    quantity: json['quantity'],
    avgPrice: json['avgPrice'].toDouble(),
    currentPrice: json['currentPrice'].toDouble(),
    pnlValue: json['pnlValue'].toDouble(),
    pnlPercent: json['pnlPercent'].toDouble(),
    weight: json['weight'].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    'symbol': symbol,
    'stockName': stockName,
    'quantity': quantity,
    'avgPrice': avgPrice,
    'currentPrice': currentPrice,
    'pnlValue': pnlValue,
    'pnlPercent': pnlPercent,
    'weight': weight,
  };

  double get totalValue => quantity * currentPrice;
  double get invested => quantity * avgPrice;
}
