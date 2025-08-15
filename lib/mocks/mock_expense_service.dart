import '../interfaces/i_expense_service.dart';
import '../models/expense.dart';

class MockExpenseService implements IExpenseService {
  final Map<String, Expense> _expenses = {};
  final Set<String> _categories = {'Food', 'Transport', 'Entertainment', 'Bills'};
  int _expenseIdCounter = 1;

  String _generateExpenseId() => 'exp_${_expenseIdCounter++}';

  @override
  Future<bool> addCategory(String category) async {
    await Future.delayed(const Duration(milliseconds: 50));
    return _categories.add(category);
  }

  @override
  Future<Expense> createExpense({
    required String title,
    required double amount,
    required String category,
    String? description,
    DateTime? date,
  }) async {
    await Future.delayed(const Duration(milliseconds: 100));

    final expense = Expense(
      id: _generateExpenseId(),
      title: title,
      amount: amount,
      category: category,
      description: description,
      date: date ?? DateTime.now(),
    );

    _expenses[expense.id] = expense;
    return expense;
  }

  @override
  Future<bool> deleteCategory(String category) async {
    await Future.delayed(const Duration(milliseconds: 75));
    
    // Check if any expenses use this category
    if (_expenses.values.any((exp) => exp.category == category)) {
      return false;
    }
    
    return _categories.remove(category);
  }

  @override
  Future<bool> deleteExpense(String id) async {
    await Future.delayed(const Duration(milliseconds: 50));
    return _expenses.remove(id) != null;
  }

  @override
  Future<List<String>> getCategories() async {
    await Future.delayed(const Duration(milliseconds: 50));
    return _categories.toList()..sort();
  }

  @override
  Future<Expense?> getExpenseById(String id) async {
    await Future.delayed(const Duration(milliseconds: 50));
    return _expenses[id];
  }

  @override
  Future<List<Expense>> getExpenses({
    String? category,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    await Future.delayed(const Duration(milliseconds: 100));

    return _expenses.values.where((expense) {
      if (category != null && expense.category != category) return false;
      if (startDate != null && expense.date.isBefore(startDate)) return false;
      if (endDate != null && expense.date.isAfter(endDate)) return false;
      return true;
    }).toList()
      ..sort((a, b) => b.date.compareTo(a.date));
  }

  @override
  Future<Map<String, double>> getExpensesByCategory({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    await Future.delayed(const Duration(milliseconds: 150));

    final Map<String, double> result = {};
    
    for (final expense in _expenses.values) {
      if (startDate != null && expense.date.isBefore(startDate)) continue;
      if (endDate != null && expense.date.isAfter(endDate)) continue;
      
      result[expense.category] = (result[expense.category] ?? 0) + expense.amount;
    }

    return result;
  }

  @override
  Future<Map<String, dynamic>> getExpenseStatistics({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    await Future.delayed(const Duration(milliseconds: 200));

    final expenses = await getExpenses(
      startDate: startDate,
      endDate: endDate,
    );

    if (expenses.isEmpty) {
      return {
        'total': 0.0,
        'average': 0.0,
        'highest': 0.0,
        'lowest': 0.0,
        'count': 0,
      };
    }

    final amounts = expenses.map((e) => e.amount).toList();
    final total = amounts.reduce((a, b) => a + b);

    return {
      'total': total,
      'average': total / expenses.length,
      'highest': amounts.reduce((a, b) => a > b ? a : b),
      'lowest': amounts.reduce((a, b) => a < b ? a : b),
      'count': expenses.length,
    };
  }

  @override
  Future<List<Expense>> searchExpenses(String query) async {
    await Future.delayed(const Duration(milliseconds: 100));

    final lowercaseQuery = query.toLowerCase();
    return _expenses.values
        .where((expense) =>
            expense.title.toLowerCase().contains(lowercaseQuery) ||
            (expense.description?.toLowerCase().contains(lowercaseQuery) ?? false))
        .toList()
      ..sort((a, b) => b.date.compareTo(a.date));
  }

  @override
  Future<double> getTotalExpenses({
    DateTime? startDate,
    DateTime? endDate,
    String? category,
  }) async {
    await Future.delayed(const Duration(milliseconds: 100));

    double total = 0.0;
    for (final expense in _expenses.values) {
      if (category != null && expense.category != category) continue;
      if (startDate != null && expense.date.isBefore(startDate)) continue;
      if (endDate != null && expense.date.isAfter(endDate)) continue;
      total += expense.amount;
    }
    return total;
  }

  @override
  Future<Expense> updateExpense({
    required String id,
    String? title,
    double? amount,
    String? category,
    String? description,
    DateTime? date,
  }) async {
    await Future.delayed(const Duration(milliseconds: 100));

    final existingExpense = _expenses[id];
    if (existingExpense == null) {
      throw Exception('Expense not found');
    }

    final updatedExpense = Expense(
      id: id,
      title: title ?? existingExpense.title,
      amount: amount ?? existingExpense.amount,
      category: category ?? existingExpense.category,
      description: description ?? existingExpense.description,
      date: date ?? existingExpense.date,
    );

    _expenses[id] = updatedExpense;
    return updatedExpense;
  }
}