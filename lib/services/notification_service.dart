import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../models/expense.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin _notifications = FlutterLocalNotificationsPlugin();
  
  /// Initialize notification settings
  Future<void> initialize() async {
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    
    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );
    
    await _notifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _onNotificationTap,
    );
  }

  /// Request notification permissions
  Future<bool> requestPermissions() async {
    final androidPermissions = await _notifications
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.requestPermission();
        
    final iosPermissions = await _notifications
        .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
        
    return androidPermissions ?? iosPermissions ?? false;
  }

  /// Show a notification for a new expense
  Future<void> showNewExpenseNotification(Expense expense) async {
    const androidDetails = AndroidNotificationDetails(
      'new_expense_channel',
      'New Expenses',
      channelDescription: 'Notifications for new expenses',
      importance: Importance.high,
      priority: Priority.high,
    );
    
    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );
    
    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );
    
    await _notifications.show(
      expense.hashCode,
      'New Expense Added',
      'A new expense of ₹${expense.amount.toStringAsFixed(2)} was added for ${expense.title}',
      details,
      payload: 'expense:${expense.id}',
    );
  }

  /// Show a notification for a pending settlement
  Future<void> showPendingSettlementNotification(Expense expense, String userName) async {
    const androidDetails = AndroidNotificationDetails(
      'pending_settlement_channel',
      'Pending Settlements',
      channelDescription: 'Notifications for pending expense settlements',
      importance: Importance.high,
      priority: Priority.high,
    );
    
    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );
    
    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );
    
    await _notifications.show(
      expense.hashCode,
      'Pending Settlement',
      'You have a pending settlement of ₹${expense.amount.toStringAsFixed(2)} with $userName',
      details,
      payload: 'settlement:${expense.id}',
    );
  }

  /// Show a notification when an expense is settled
  Future<void> showExpenseSettledNotification(Expense expense, String settledByName) async {
    const androidDetails = AndroidNotificationDetails(
      'expense_settled_channel',
      'Settled Expenses',
      channelDescription: 'Notifications for settled expenses',
      importance: Importance.defaultImportance,
      priority: Priority.defaultPriority,
    );
    
    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );
    
    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );
    
    await _notifications.show(
      expense.hashCode,
      'Expense Settled',
      '$settledByName has settled the expense of ₹${expense.amount.toStringAsFixed(2)}',
      details,
      payload: 'settled:${expense.id}',
    );
  }

  /// Show a reminder notification for pending settlements
  Future<void> showSettlementReminderNotification(double totalAmount, int pendingCount) async {
    const androidDetails = AndroidNotificationDetails(
      'settlement_reminder_channel',
      'Settlement Reminders',
      channelDescription: 'Reminders for pending settlements',
      importance: Importance.high,
      priority: Priority.high,
    );
    
    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );
    
    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );
    
    await _notifications.show(
      DateTime.now().millisecondsSinceEpoch,
      'Settlement Reminder',
      'You have $pendingCount pending settlements totaling ₹${totalAmount.toStringAsFixed(2)}',
      details,
      payload: 'settlements',
    );
  }

  /// Handle notification tap
  void _onNotificationTap(NotificationResponse response) {
    if (response.payload == null) return;

    // TODO: Navigate to appropriate screen based on payload
    final parts = response.payload!.split(':');
    if (parts.length != 2) return;

    final type = parts[0];
    final id = parts[1];

    switch (type) {
      case 'expense':
        // Navigate to expense details
        break;
      case 'settlement':
        // Navigate to bill splitting screen
        break;
      case 'settled':
        // Navigate to activity screen
        break;
      case 'settlements':
        // Navigate to bill splitting screen
        break;
    }
  }

  /// Cancel all notifications
  Future<void> cancelAllNotifications() async {
    await _notifications.cancelAll();
  }

  /// Cancel a specific notification
  Future<void> cancelNotification(int id) async {
    await _notifications.cancel(id);
  }
}