import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../database/database.dart';
import '../models/expense.dart';
import '../theme/app_theme.dart';
import '../models/user.dart';
import '../services/notification_service.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _selectedCategory = 'Food';
  bool _isSplitExpense = false;
  List<User> _selectedUsers = [];
  final List<User> _availableUsers = [
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

  final List<String> _categories = [
    'Food',
    'Transport',
    'Entertainment',
    'Shopping',
    'Bills',
    'Health',
    'Others',
  ];

  @override
  void dispose() {
    _amountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _submitExpense() async {
    if (_formKey.currentState!.validate()) {
      final currentUserId = "user1"; // TODO: Get from provider
      final notificationService = Provider.of<NotificationService>(context, listen: false);
      final amount = double.parse(_amountController.text);
      
      final List<ExpenseParticipant> participants;
      if (_isSplitExpense && _selectedUsers.isNotEmpty) {
        participants = Expense.splitEqually(
          [currentUserId, ..._selectedUsers.map((u) => u.id)],
          amount
        );
      } else {
        participants = [
          ExpenseParticipant(userId: currentUserId, share: amount)
        ];
      }
      
      final expense = Expense(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: _descriptionController.text,
        amount: amount,
        description: _descriptionController.text,
        category: _selectedCategory,
        date: _selectedDate,
        paidById: currentUserId,
        participants: participants,
      );

      // TODO: Save expense to database
      // final db = Provider.of<AppDatabase>(context, listen: false);
      // await db.createExpense(expense);

      // Show notification for new expense
      await notificationService.showNewExpenseNotification(expense);

      // Show notifications for participants who need to pay
      if (_isSplitExpense && _selectedUsers.isNotEmpty) {
        for (final user in _selectedUsers) {
          final share = expense.getAmountOwedByUser(user.id);
          if (share > 0) {
            await notificationService.showPendingSettlementNotification(expense, user.name);
          }
        }
      }

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Expense'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _amountController,
              decoration: const InputDecoration(
                labelText: 'Amount',
                prefixText: '₹',
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
              ],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an amount';
                }
                if (double.tryParse(value) == null) {
                  return 'Please enter a valid amount';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a description';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              decoration: const InputDecoration(
                labelText: 'Category',
              ),
              items: _categories.map((category) {
                return DropdownMenuItem(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value!;
                });
              },
            ),
            const SizedBox(height: 16),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Date'),
              subtitle: Text(
                '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
              ),
              trailing: IconButton(
                icon: const Icon(Icons.calendar_today),
                onPressed: () => _selectDate(context),
              ),
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Split Expense'),
              subtitle: const Text('Enable to split this expense with others'),
              value: _isSplitExpense,
              onChanged: (value) {
                setState(() {
                  _isSplitExpense = value;
                });
              },
            ),
            if (_isSplitExpense) ...[
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Split Details',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 16),
                      // TODO: Add split details UI
                      Column(
                        children: [
                          ..._availableUsers
                              .where((user) => user.id != 'user1') // Exclude current user
                              .map((user) => CheckboxListTile(
                                    title: Text(user.name),
                                    value: _selectedUsers.contains(user),
                                    onChanged: (bool? value) {
                                      setState(() {
                                        if (value == true) {
                                          _selectedUsers.add(user);
                                        } else {
                                          _selectedUsers.remove(user);
                                        }
                                      });
                                    },
                                  ))
                              .toList(),
                          if (_selectedUsers.isNotEmpty) ...[
                            const Divider(),
                            Text(
                              'Split amount: ₹${(double.tryParse(_amountController.text) ?? 0) / (_selectedUsers.length + 1)}',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton(
            onPressed: _submitExpense,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primary,
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 50),
            ),
            child: const Text('Save Expense'),
          ),
        ),
      ),
    );
  }
}