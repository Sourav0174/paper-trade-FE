class MarketIndexModel {
  final String name;
  final double value;
  final double changePercent;
  final bool isUp;

  MarketIndexModel({
    required this.name,
    required this.value,
    required this.changePercent,
    required this.isUp,
  });

  factory MarketIndexModel.fromJson(Map<String, dynamic> json) =>
      MarketIndexModel(
        name: json['name'],
        value: json['value'].toDouble(),
        changePercent: json['changePercent'].toDouble(),
        isUp: json['isUp'],
      );

  Map<String, dynamic> toJson() => {
    'name': name,
    'value': value,
    'changePercent': changePercent,
    'isUp': isUp,
  };
}
