class Expense {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final String? description;
  final String category;

  Expense({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    this.description,
    required this.category,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'amount': amount,
        'date': date.toIso8601String(),
        'description': description,
        'category': category,
      };

  factory Expense.fromJson(Map<String, dynamic> json) => Expense(
        id: json['id'],
        title: json['title'],
        amount: json['amount'],
        date: DateTime.parse(json['date']),
        description: json['description'],
        category: json['category'],
      );
}