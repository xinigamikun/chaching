import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../database/database.dart';
import '../models/expense.dart';
import '../models/user.dart';
import '../theme/app_theme.dart';
import '../services/bill_service.dart';
import '../services/notification_service.dart';

class BillSplittingScreen extends StatefulWidget {
  const BillSplittingScreen({super.key});

  @override
  State<BillSplittingScreen> createState() => _BillSplittingScreenState();
}

class _BillSplittingScreenState extends State<BillSplittingScreen> {
  String _selectedUserId = 'user1'; // TODO: Get from provider
  final _billService = BillService();

  // TODO: Replace with actual data from database
  final List<User> _users = [
    User(
      id: 'user1',
      name: 'You',
      email: 'you@example.com',
      createdAt: DateTime.now(),
    ),
    User(
      id: 'user2',
      name: 'Alice',
      email: 'alice@example.com',
      createdAt: DateTime.now(),
    ),
    User(
      id: 'user3',
      name: 'Bob',
      email: 'bob@example.com',
      createdAt: DateTime.now(),
    ),
  ];

  final List<Expense> _expenses = []; // TODO: Get from database

  double _calculateTotalOwed(String userId) {
    double total = 0;
    for (var expense in _expenses) {
      if (!expense.isSettled) {
        total += expense.getAmountOwedByUser(userId);
      }
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Split Bills'),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: Theme.of(context).colorScheme.surface,
            child: Column(
              children: [
                Text(
                  'Select Person',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 16),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: _users
                        .where((user) => user.id != 'user1') // Exclude current user
                        .map((user) {
                      final isSelected = user.id == _selectedUserId;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ChoiceChip(
                          label: Text(user.name),
                          selected: isSelected,
                          onSelected: (selected) {
                            if (selected) {
                              setState(() {
                                _selectedUserId = user.id;
                              });
                            }
                          },
                          backgroundColor: isSelected ? AppTheme.primary : null,
                          labelStyle: TextStyle(
                            color: isSelected ? Colors.white : null,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _BalanceCard(
                  user: _users.firstWhere((u) => u.id == _selectedUserId),
                  totalOwed: _calculateTotalOwed(_selectedUserId),
                ),
                const SizedBox(height: 16),
                Text(
                  'Pending Settlements',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                ..._expenses
                    .where((e) =>
                        !e.isSettled &&
                        e.getAmountOwedByUser(_selectedUserId) > 0)
                    .map((expense) => _ExpenseCard(
                          expense: expense,
                          billService: _billService,
                          onSettle: () async {
                            // TODO: Implement settlement in database
                            final notificationService = Provider.of<NotificationService>(context, listen: false);
                            final settledByUser = _users.firstWhere((u) => u.id == 'user1');
                            await notificationService.showExpenseSettledNotification(expense, settledByUser.name);
                          },
                        )),
                if (_expenses.isEmpty)
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(32),
                      child: Text(
                        'No pending settlements',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BalanceCard extends StatelessWidget {
  final User user;
  final double totalOwed;

  const _BalanceCard({
    required this.user,
    required this.totalOwed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  child: Text(user.name[0]),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.name,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        user.email,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Owed',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Text(
                  '₹${totalOwed.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: totalOwed > 0 ? Colors.red : Colors.green,
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ExpenseCard extends StatelessWidget {
  final Expense expense;
  final BillService billService;
  final VoidCallback onSettle;

  const _ExpenseCard({
    required this.expense,
    required this.billService,
    required this.onSettle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        title: Text(expense.title),
        subtitle: Text(
          '${expense.date.day}/${expense.date.month}/${expense.date.year} • ${expense.category}',
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '₹${expense.amount.toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(width: 8),
            IconButton(
              icon: const Icon(Icons.share),
              onPressed: () async {
                // TODO: Get actual users from provider
                final users = [
                  User(
                    id: 'user1',
                    name: 'You',
                    email: 'you@example.com',
                    createdAt: DateTime.now(),
                  ),
                  User(
                    id: 'user2',
                    name: 'Alice',
                    email: 'alice@example.com',
                    createdAt: DateTime.now(),
                  ),
                  User(
                    id: 'user3',
                    name: 'Bob',
                    email: 'bob@example.com',
                    createdAt: DateTime.now(),
                  ),
                ];
                await billService.generateAndShareBill(expense, users);
              },
              tooltip: 'Share Bill',
            ),
            const SizedBox(width: 8),
            IconButton(
              icon: const Icon(Icons.check_circle_outline),
              onPressed: onSettle,
              tooltip: 'Mark as settled',
            ),
          ],
        ),
      ),
    );
  }
}