import 'dart:async';
import '../interfaces/i_sms_service.dart';
import '../models/sms_transaction.dart';

class MockSmsService implements ISmsService {
  final _transactionController = StreamController<SmsTransaction>.broadcast();
  final Set<String> _transactionSenders = {
    'HDFCBANK', 'SBICARD', 'AXISBANK', 'ICICIBANK',
    'PAYTM', 'PHONEPE', 'GPAY'
  };
  bool _isListening = false;

  // Sample transaction messages for testing
  final List<Map<String, String>> _sampleMessages = [
    {
      'sender': 'HDFCBANK',
      'message': 'Your a/c XX1234 debited for Rs.1,250.00 on 15-08-23 at AMAZON RETAIL. Avl bal: Rs.45,678.90',
    },
    {
      'sender': 'SBICARD',
      'message': 'Thank you for using SBI Card XX5678. Rs.890.00 spent at SWIGGY on 15-08-23. Avl Credit Limit: Rs.98,765.00',
    },
    {
      'sender': 'PAYTM',
      'message': 'Rs.500.00 paid to UBER via UPI. UPI Ref: 123456789. Balance: Rs.2,345.67',
    },
  ];

  @override
  Future<bool> initialize() async {
    // Mock implementation always succeeds
    await checkPermissions();
    return startSmsListener();
  }

  @override
  Stream<SmsTransaction> get transactionStream => _transactionController.stream;

  @override
  Future<bool> checkPermissions() async {
    // Mock always returns true
    return true;
  }

  @override
  Future<bool> requestPermissions() async {
    // Mock always returns true
    return true;
  }

  @override
  Future<bool> startSmsListener() async {
    if (_isListening) return true;
    _isListening = true;

    // Simulate incoming messages every 30 seconds
    Timer.periodic(const Duration(seconds: 30), (timer) {
      if (!_isListening) {
        timer.cancel();
        return;
      }

      final randomMessage = _sampleMessages[
        DateTime.now().millisecondsSinceEpoch % _sampleMessages.length
      ];

      _handleNewMessage(
        randomMessage['sender'] ?? '',
        randomMessage['message'] ?? '',
      );
    });

    return true;
  }

  @override
  Future<void> stopSmsListener() async {
    _isListening = false;
  }

  Future<void> _handleNewMessage(String sender, String message) async {
    if (!_isListening) return;

    final transaction = await parseSmsToTransaction(sender, message);
    if (transaction != null) {
      _transactionController.add(transaction);
    }
  }

  @override
  Future<SmsTransaction?> parseSmsToTransaction(
    String sender,
    String message,
  ) async {
    if (!isTransactionSender(sender)) return null;

    final amount = _extractAmount(message);
    if (amount == null) return null;

    return SmsTransaction(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      sender: sender,
      message: message,
      timestamp: DateTime.now(),
      amount: amount,
      merchantName: _extractMerchantName(message),
      transactionType: _extractTransactionType(message),
      paymentMethod: _extractPaymentMethod(message),
    );
  }

  double? _extractAmount(String message) {
    final pattern = RegExp(r'Rs\.?\s*(\d+(?:,\d+)*(?:\.\d{2})?)', caseSensitive: false);
    final match = pattern.firstMatch(message);
    if (match != null) {
      final amountStr = match.group(1)?.replaceAll(',', '');
      return double.tryParse(amountStr ?? '');
    }
    return null;
  }

  String? _extractMerchantName(String message) {
    final pattern = RegExp(r'(?:at|@|to)\s+([A-Za-z0-9\s&]+?)(?=\s+(?:on|for|via|Rs|INR|₹|\d))',
        caseSensitive: false);
    final match = pattern.firstMatch(message);
    return match?.group(1)?.trim();
  }

  String? _extractTransactionType(String message) {
    final lowerMessage = message.toLowerCase();
    if (lowerMessage.contains('debited') ||
        lowerMessage.contains('spent') ||
        lowerMessage.contains('paid')) {
      return 'debit';
    } else if (lowerMessage.contains('credited') ||
        lowerMessage.contains('received') ||
        lowerMessage.contains('refund')) {
      return 'credit';
    }
    return null;
  }

  String? _extractPaymentMethod(String message) {
    final lowerMessage = message.toLowerCase();
    if (lowerMessage.contains('upi')) return 'UPI';
    if (lowerMessage.contains('card')) return 'Card';
    if (lowerMessage.contains('net banking')) return 'Net Banking';
    return null;
  }

  @override
  Future<List<SmsTransaction>> getTransactionHistory({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    // Return sample transactions for testing
    final transactions = <SmsTransaction>[];
    
    for (final sample in _sampleMessages) {
      final transaction = await parseSmsToTransaction(
        sample['sender'] ?? '',
        sample['message'] ?? '',
      );
      if (transaction != null) {
        transactions.add(transaction);
      }
    }

    return transactions;
  }

  @override
  bool isTransactionSender(String sender) {
    return _transactionSenders.any(
      (pattern) => sender.toUpperCase().contains(pattern),
    );
  }

  @override
  Future<void> addTransactionSender(String pattern) async {
    _transactionSenders.add(pattern.toUpperCase());
  }

  @override
  Future<void> removeTransactionSender(String pattern) async {
    _transactionSenders.remove(pattern.toUpperCase());
  }

  @override
  Future<List<String>> getTransactionSenders() async {
    return _transactionSenders.toList();
  }

  void dispose() {
    _transactionController.close();
  }
}