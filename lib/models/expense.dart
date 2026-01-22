class ExpenseParticipant {
  final String userId;
  final double share;
  final bool hasPaid;

  ExpenseParticipant({
    required this.userId,
    required this.share,
    this.hasPaid = false,
  });

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'share': share,
        'hasPaid': hasPaid,
      };

  factory ExpenseParticipant.fromJson(Map<String, dynamic> json) =>
      ExpenseParticipant(
        userId: json['userId'],
        share: json['share'],
        hasPaid: json['hasPaid'] ?? false,
      );
}

class Expense {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final String? description;
  final String category;
  final String paidById;
  final List<ExpenseParticipant> participants;
  final String? source; // e.g., 'UPI', 'Cash', 'Card'
  final bool isSettled;

  Expense({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    this.description,
    required this.category,
    required this.paidById,
    required this.participants,
    this.source,
    this.isSettled = false,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'amount': amount,
        'date': date.toIso8601String(),
        'description': description,
        'category': category,
        'paidById': paidById,
        'participants': participants.map((p) => p.toJson()).toList(),
        'source': source,
        'isSettled': isSettled,
      };

  factory Expense.fromJson(Map<String, dynamic> json) => Expense(
        id: json['id'],
        title: json['title'],
        amount: json['amount'],
        date: DateTime.parse(json['date']),
        description: json['description'],
        category: json['category'],
        paidById: json['paidById'],
        participants: (json['participants'] as List)
            .map((p) => ExpenseParticipant.fromJson(p))
            .toList(),
        source: json['source'],
        isSettled: json['isSettled'] ?? false,
      );

  // Helper method to split expense equally among participants
  static List<ExpenseParticipant> splitEqually(
      List<String> userIds, double amount) {
    final share = amount / userIds.length;
    return userIds
        .map((id) => ExpenseParticipant(userId: id, share: share))
        .toList();
  }

  // Helper method to check if expense is fully settled
  bool get isFullySettled => participants.every((p) => p.hasPaid);

  // Get amount owed by a specific user
  double getAmountOwedByUser(String userId) {
    if (userId == paidById) {
      return 0.0; // Payer doesn't owe anything
    }
    final participant = participants.firstWhere(
      (p) => p.userId == userId,
      orElse: () => ExpenseParticipant(userId: userId, share: 0.0),
    );
    return participant.share;
  }

  // Get total amount settled so far
  double get settledAmount =>
      participants.where((p) => p.hasPaid).fold(0.0, (sum, p) => sum + p.share);
}