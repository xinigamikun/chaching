import '../models/sms_transaction.dart';

abstract class ISmsService {
  /// Initialize the SMS service by checking permissions and starting the listener
  Future<bool> initialize();

  /// Check if SMS permissions are granted
  Future<bool> checkPermissions();

  /// Request SMS permissions from the user
  Future<bool> requestPermissions();

  /// Start listening for incoming SMS messages
  Future<bool> startSmsListener();

  /// Stop listening for SMS messages
  Future<void> stopSmsListener();

  /// Parse a single SMS message into a transaction
  /// Returns null if the message is not a transaction
  Future<SmsTransaction?> parseSmsToTransaction(String sender, String message);

  /// Get all transaction-related SMS messages from inbox
  Future<List<SmsTransaction>> getTransactionHistory({
    DateTime? startDate,
    DateTime? endDate,
  });

  /// Stream of new transaction SMS messages
  Stream<SmsTransaction> get transactionStream;

  /// Check if a sender is a known transaction sender
  bool isTransactionSender(String sender);

  /// Add a new transaction sender pattern
  Future<void> addTransactionSender(String pattern);

  /// Remove a transaction sender pattern
  Future<void> removeTransactionSender(String pattern);

  /// Get list of known transaction sender patterns
  Future<List<String>> getTransactionSenders();
}