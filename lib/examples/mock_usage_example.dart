import '../mocks/mock_database.dart';
import '../mocks/mock_user_service.dart';
import '../mocks/mock_expense_service.dart';
import '../models/expense.dart';
import '../models/user.dart';

void main() async {
  // Initialize services
  final database = MockDatabase();
  final userService = MockUserService();
  final expenseService = MockExpenseService();

  // Initialize database
  await database.initialize();
  print('Database initialized: ${await database.isInitialized()}');

  // Create a user
  final user = await userService.createUser(
    name: 'John Doe',
    email: 'john@example.com',
    preferences: {'currency': 'USD', 'theme': 'dark'},
  );
  print('\nCreated user: ${user.name}');

  // Set as current user
  await userService.setCurrentUser(user.id);
  final currentUser = await userService.getCurrentUser();
  print('Current user: ${currentUser?.name}');

  // Add some expenses
  final expense1 = await expenseService.createExpense(
    title: 'Groceries',
    amount: 50.0,
    category: 'Food',
    description: 'Weekly groceries',
  );

  final expense2 = await expenseService.createExpense(
    title: 'Movie tickets',
    amount: 30.0,
    category: 'Entertainment',
  );

  print('\nCreated expenses:');
  print('1. ${expense1.title}: \$${expense1.amount}');
  print('2. ${expense2.title}: \$${expense2.amount}');

  // Get expense statistics
  final stats = await expenseService.getExpenseStatistics();
  print('\nExpense Statistics:');
  print('Total: \$${stats['total']}');
  print('Average: \$${stats['average']}');
  print('Count: ${stats['count']}');

  // Get expenses by category
  final categoryTotals = await expenseService.getExpensesByCategory();
  print('\nExpenses by Category:');
  categoryTotals.forEach((category, total) {
    print('$category: \$${total}');
  });

  // Update an expense
  final updatedExpense = await expenseService.updateExpense(
    id: expense1.id,
    amount: 55.0,
    description: 'Weekly groceries + snacks',
  );
  print('\nUpdated expense:');
  print('${updatedExpense.title}: \$${updatedExpense.amount}');
  print('Description: ${updatedExpense.description}');

  // Search expenses
  final searchResults = await expenseService.searchExpenses('movie');
  print('\nSearch results for "movie":');
  for (final expense in searchResults) {
    print('${expense.title}: \$${expense.amount}');
  }

  // Clean up
  await database.clearAllData();
  await database.close();
  print('\nDatabase closed');
}