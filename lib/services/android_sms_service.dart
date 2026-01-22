import 'dart:async';
import 'package:another_telephony/telephony.dart';
import 'package:permission_handler/permission_handler.dart';
import '../interfaces/i_sms_service.dart';
import '../models/sms_transaction.dart';
import 'package:uuid/uuid.dart';

class AndroidSmsService implements ISmsService {
  final Telephony _telephony = Telephony.instance;
  final _uuid = const Uuid();

  /// Initialize the SMS service by checking permissions and starting the listener
  Future<bool> initialize() async {
    try {
      print('Initializing SMS service...');
      
      final hasPermissions = await checkPermissions();
      print('SMS permissions status: $hasPermissions');
      
      if (!hasPermissions) {
        print('Requesting SMS permissions...');
        final granted = await requestPermissions();
        if (!granted) {
          print('SMS permissions denied by user');
          return false;
        }
        print('SMS permissions granted by user');
      }

      print('Starting SMS listener...');
      final listenerStarted = await startSmsListener();
      if (!listenerStarted) {
        print('Failed to start SMS listener');
        return false;
      }
      
      print('SMS service initialized successfully');
      return true;
    } catch (e) {
      print('Error initializing SMS service: $e');
      return false;
    }
  }

  final _transactionController = StreamController<SmsTransaction>.broadcast();
  final Set<String> _transactionSenders = {
    'HDFCBANK', 'SBICARD', 'AXISBANK', 'ICICIBANK',
    'PAYTM', 'PHONEPE', 'GPAY'
  };

  bool _isListening = false;

  @override
  Stream<SmsTransaction> get transactionStream => _transactionController.stream;

  @override
  Future<bool> checkPermissions() async {
    final status = await Permission.sms.status;
    return status.isGranted;
  }

  @override
  Future<bool> requestPermissions() async {
    final status = await Permission.sms.request();
    return status.isGranted;
  }

  @override
  Future<bool> startSmsListener() async {
    if (_isListening) return true;
    
    final permissionGranted = await checkPermissions();
    if (!permissionGranted) {
      final requested = await requestPermissions();
      if (!requested) return false;
    }

    _telephony.listenIncomingSms(
      onNewMessage: _handleNewSms,
      listenInBackground: true,
      onBackgroundMessage: _handleBackgroundSms,
    );

    _isListening = true;
    return true;
  }

  @override
  Future<void> stopSmsListener() async {
    _isListening = false;
    // Note: Telephony plugin doesn't provide a way to stop listening
    // The flag will prevent processing of new messages
  }

  Future<void> _handleNewSms(SmsMessage message) async {
    print('Foreground SMS received:');
    print('From: ${message.address}');
    print('Body: ${message.body}');

    if (!_isListening) {
      print('SMS listener is not active, ignoring message');
      return;
    }

    if (!isTransactionSender(message.address ?? '')) {
      print('Not a transaction sender, ignoring: ${message.address}');
      return;
    }

    print('Processing transaction SMS...');
    final transaction = await parseSmsToTransaction(
      message.address ?? '',
      message.body ?? '',
    );

    if (transaction != null) {
      print('Transaction processed successfully:');
      print('Amount: ${transaction.amount}');
      print('Merchant: ${transaction.merchantName}');
      print('Type: ${transaction.transactionType}');
      print('Method: ${transaction.paymentMethod}');
      _transactionController.add(transaction);
    } else {
      print('Could not parse transaction from message');
    }
  }

  // This method needs to be static as per telephony plugin requirements
  static Future<void> _handleBackgroundSms(SmsMessage message) async {
    print('Background SMS received from: ${message.address}');
    
    // Create a temporary instance to handle the background message
    final service = AndroidSmsService();
    
    try {
      // Check if the sender is a transaction sender
      if (!service.isTransactionSender(message.address ?? '')) {
        print('Ignored: Not a transaction sender - ${message.address}');
        return;
      }

      // Process the message
      final transaction = await service.parseSmsToTransaction(
        message.address ?? '',
        message.body ?? '',
      );

      if (transaction != null) {
        print('Transaction parsed successfully in background:');
        print('Amount: ${transaction.amount}');
        print('Merchant: ${transaction.merchantName}');
        print('Type: ${transaction.transactionType}');
        print('Method: ${transaction.paymentMethod}');
      } else {
        print('Could not parse transaction from message: ${message.body}');
      }
    } catch (e) {
      print('Error processing background SMS: $e');
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
      id: _uuid.v4(),
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
    print('Extracting amount from message: $message');
    // Match common Indian currency patterns
    // Matches patterns like Rs. 1,234.56, INR 1234.56, ₹1,234
    final patterns = [
      RegExp(r'(?:Rs\.?|INR|₹)\s*(\d+(?:,\d+)*(?:\.\d{2})?)',
          caseSensitive: false),
      RegExp(r'(\d+(?:,\d+)*(?:\.\d{2})?)\s*(?:Rs\.?|INR|₹)',
          caseSensitive: false),
    ];

    for (final pattern in patterns) {
      final match = pattern.firstMatch(message);
      if (match != null) {
        final amountStr = match.group(1)?.replaceAll(',', '');
        return double.tryParse(amountStr ?? '');
      }
    }
    return null;
  }

  String? _extractMerchantName(String message) {
    print('\nAttempting to extract merchant name:');
    print('Message: $message');
    // Match merchant name patterns
    // Example: "at MERCHANT_NAME" or "to MERCHANT_NAME"
    final patterns = [
      RegExp(r'(?:at|@|to)\s+([A-Za-z0-9\s&]+?)(?=\s+(?:on|for|via|Rs|INR|₹|\d))',
          caseSensitive: false),
    ];

    for (final pattern in patterns) {
      final match = pattern.firstMatch(message);
      if (match != null) {
        final merchantName = match.group(1)?.trim();
        print('Extracted merchant name: $merchantName');
        return merchantName;
      }
    }
    print('No merchant name found in message');
    return null;
  }

  String? _extractTransactionType(String message) {
    final lowerMessage = message.toLowerCase();
    if (lowerMessage.contains('debit') ||
        lowerMessage.contains('spent') ||
        lowerMessage.contains('paid')) {
      return 'debit';
    } else if (lowerMessage.contains('credit') ||
        lowerMessage.contains('received') ||
        lowerMessage.contains('refund')) {
      return 'credit';
    }
    return null;
  }

  String? _extractPaymentMethod(String message) {
    print('\nAttempting to extract payment method:');
    print('Message: $message');
    final lowerMessage = message.toLowerCase();
    
    if (lowerMessage.contains('upi')) {
      print('Payment method found: UPI');
      return 'UPI';
    }
    if (lowerMessage.contains('card')) {
      print('Payment method found: Card');
      return 'Card';
    }
    if (lowerMessage.contains('net banking')) {
      print('Payment method found: Net Banking');
      return 'Net Banking';
    }
    print('No payment method found in message');
    return null;
  }

  @override
  Future<List<SmsTransaction>> getTransactionHistory({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final messages = await _telephony.getInboxSms(
      columns: [SmsColumn.ADDRESS, SmsColumn.BODY, SmsColumn.DATE],
    );
    final transactions = <SmsTransaction>[];

    for (final message in messages) {
      if (!_isListening) break;

      final transaction = await parseSmsToTransaction(
        message.address ?? '',
        message.body ?? '',
      );

      if (transaction != null) {
        if (startDate != null && transaction.timestamp.isBefore(startDate)) {
          continue;
        }
        if (endDate != null && transaction.timestamp.isAfter(endDate)) {
          continue;
        }
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