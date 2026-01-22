import '../models/expense.dart';

/// Interface for expense management operations
abstract class IExpenseService {
  /// Create a new expense
  /// Returns the created expense
  Future<Expense> createExpense({
    required String title,
    required double amount,
    required String category,
    String? description,
    DateTime? date,
  });

  /// Get expense by ID
  /// Returns null if expense not found
  Future<Expense?> getExpenseById(String id);

  /// Get all expenses
  /// Optionally filtered by category and date range
  Future<List<Expense>> getExpenses({
    String? category,
    DateTime? startDate,
    DateTime? endDate,
  });

  /// Update expense
  /// Returns the updated expense
  Future<Expense> updateExpense({
    required String id,
    String? title,
    double? amount,
    String? category,
    String? description,
    DateTime? date,
  });

  /// Delete expense by ID
  /// Returns true if deletion was successful
  Future<bool> deleteExpense(String id);

  /// Get total expenses for a period
  Future<double> getTotalExpenses({
    DateTime? startDate,
    DateTime? endDate,
    String? category,
  });

  /// Get expenses grouped by category
  /// Returns a map of category to total amount
  Future<Map<String, double>> getExpensesByCategory({
    DateTime? startDate,
    DateTime? endDate,
  });

  /// Get available expense categories
  Future<List<String>> getCategories();

  /// Add new expense category
  Future<bool> addCategory(String category);

  /// Delete expense category
  /// Returns true if deletion was successful
  /// Note: Will fail if there are expenses in this category
  Future<bool> deleteCategory(String category);

  /// Search expenses by title or description
  Future<List<Expense>> searchExpenses(String query);

  /// Get expense statistics for a period
  /// Returns a map containing various statistics like
  /// average, highest, lowest expenses etc.
  Future<Map<String, dynamic>> getExpenseStatistics({
    DateTime? startDate,
    DateTime? endDate,
  });
}