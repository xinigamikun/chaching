class SmsTransaction {
  final String id;
  final String sender;
  final String message;
  final DateTime timestamp;
  final double? amount;
  final String? merchantName;
  final String? transactionType; // debit, credit, etc.
  final String? paymentMethod; // UPI, card, etc.

  SmsTransaction({
    required this.id,
    required this.sender,
    required this.message,
    required this.timestamp,
    this.amount,
    this.merchantName,
    this.transactionType,
    this.paymentMethod,
  });

  // Convert to a potential expense
  Map<String, dynamic> toExpenseData() {
    return {
      'title': merchantName ?? 'Transaction',
      'amount': amount ?? 0.0,
      'description': message,
      'date': timestamp,
      'source': paymentMethod,
      'category': _inferCategory(),
    };
  }

  // Basic category inference based on merchant name or message content
  String _inferCategory() {
    final lowerMessage = message.toLowerCase();
    final lowerMerchant = merchantName?.toLowerCase() ?? '';

    if (lowerMessage.contains('food') || 
        lowerMessage.contains('restaurant') ||
        lowerMessage.contains('cafe')) {
      return 'Food';
    } else if (lowerMessage.contains('uber') || 
               lowerMessage.contains('ola') ||
               lowerMessage.contains('transport')) {
      return 'Transport';
    } else if (lowerMessage.contains('movie') || 
               lowerMessage.contains('entertainment')) {
      return 'Entertainment';
    } else if (lowerMessage.contains('bill') || 
               lowerMessage.contains('utility') ||
               lowerMessage.contains('recharge')) {
      return 'Bills';
    }
    return 'Other';
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'sender': sender,
        'message': message,
        'timestamp': timestamp.toIso8601String(),
        'amount': amount,
        'merchantName': merchantName,
        'transactionType': transactionType,
        'paymentMethod': paymentMethod,
      };

  factory SmsTransaction.fromJson(Map<String, dynamic> json) => SmsTransaction(
        id: json['id'],
        sender: json['sender'],
        message: json['message'],
        timestamp: DateTime.parse(json['timestamp']),
        amount: json['amount'],
        merchantName: json['merchantName'],
        transactionType: json['transactionType'],
        paymentMethod: json['paymentMethod'],
      );
}