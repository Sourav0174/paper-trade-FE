class UserModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final bool isPremium;
  final double virtualBalance;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.isPremium = false,
    this.virtualBalance = 100000.0,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json['id'],
    name: json['name'],
    email: json['email'],
    phone: json['phone'],
    isPremium: json['isPremium'] ?? false,
    virtualBalance: json['virtualBalance']?.toDouble() ?? 100000.0,
    createdAt: DateTime.parse(json['createdAt']),
    updatedAt: DateTime.parse(json['updatedAt']),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'phone': phone,
    'isPremium': isPremium,
    'virtualBalance': virtualBalance,
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
  };

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    bool? isPremium,
    double? virtualBalance,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => UserModel(
    id: id ?? this.id,
    name: name ?? this.name,
    email: email ?? this.email,
    phone: phone ?? this.phone,
    isPremium: isPremium ?? this.isPremium,
    virtualBalance: virtualBalance ?? this.virtualBalance,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
}
