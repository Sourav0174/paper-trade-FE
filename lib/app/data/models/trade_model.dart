class TradeModel {
  final String id;
  final String userId;
  final String symbol;
  final String stockName;
  final String type;
  final int quantity;
  final double price;
  final double total;
  final String orderType;
  final DateTime timestamp;
  final DateTime createdAt;
  final DateTime updatedAt;

  TradeModel({
    required this.id,
    required this.userId,
    required this.symbol,
    required this.stockName,
    required this.type,
    required this.quantity,
    required this.price,
    required this.total,
    this.orderType = 'Market',
    required this.timestamp,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TradeModel.fromJson(Map<String, dynamic> json) => TradeModel(
    id: json['id'],
    userId: json['userId'],
    symbol: json['symbol'],
    stockName: json['stockName'],
    type: json['type'],
    quantity: json['quantity'],
    price: json['price'].toDouble(),
    total: json['total'].toDouble(),
    orderType: json['orderType'] ?? 'Market',
    timestamp: DateTime.parse(json['timestamp']),
    createdAt: DateTime.parse(json['createdAt']),
    updatedAt: DateTime.parse(json['updatedAt']),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'userId': userId,
    'symbol': symbol,
    'stockName': stockName,
    'type': type,
    'quantity': quantity,
    'price': price,
    'total': total,
    'orderType': orderType,
    'timestamp': timestamp.toIso8601String(),
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
  };
}
