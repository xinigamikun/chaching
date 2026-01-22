class User {
  final String id;
  final String name;
  final String email;
  final DateTime createdAt;
  final Map<String, dynamic>? preferences;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.createdAt,
    this.preferences,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'createdAt': createdAt.toIso8601String(),
        'preferences': preferences,
      };

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        createdAt: DateTime.parse(json['createdAt']),
        preferences: json['preferences'],
      );
}