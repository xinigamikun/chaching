import 'package:drift/drift.dart';
import 'dart:convert';
import '../services/encryption_service.dart';
import '../models/expense.dart' as model;
import '../models/user.dart' as model;
import 'database.dart';
import 'tables.dart';

class EncryptedDatabase {
  final AppDatabase _db;
  final EncryptionService _encryptionService;

  EncryptedDatabase(this._db, this._encryptionService);

  // User operations with encryption
  Future<void> createUser(model.User user) async {
    // Encrypt sensitive user data
    final encryptedName = _encryptionService.encryptString(user.name);
    final encryptedEmail = _encryptionService.encryptString(user.email);
    final encryptedPreferences = user.preferences != null 
        ? _encryptionService.encryptMap(user.preferences!)
        : null;

    await _db.into(_db.users).insert(UsersCompanion.insert(
      id: user.id,
      name: encryptedName,
      email: encryptedEmail,
      createdAt: user.createdAt,
      preferences: Value(encryptedPreferences != null
          ? jsonEncode({'encrypted': encryptedPreferences})
          : null),
    ));
  }

  Future<model.User?> getUser(String id) async {
    final result = await (_db.select(_db.users)..where((t) => t.id.equals(id)))
        .getSingleOrNull();
    if (result == null) return null;

    // Decrypt sensitive user data
    final decryptedName = _encryptionService.decryptString(result.name);
    final decryptedEmail = _encryptionService.decryptString(result.email);
    Map<String, dynamic>? decryptedPreferences;
    if (result.preferences != null) {
      final prefMap = jsonDecode(result.preferences!) as Map<String, dynamic>;
      if (prefMap.containsKey('encrypted')) {
        decryptedPreferences = _encryptionService.decryptMap(prefMap['encrypted'] as String);
      } else {
        decryptedPreferences = prefMap;
      }
    }

    return model.User(
      id: result.id,
      name: decryptedName,
      email: decryptedEmail,
      createdAt: result.createdAt,
      preferences: decryptedPreferences,
    );
  }

  // Expense operations with encryption
  Future<void> createExpense(model.Expense expense) async {
    // Encrypt sensitive expense data
    final encryptedTitle = _encryptionService.encryptString(expense.title);
    final encryptedDescription = expense.description != null
        ? _encryptionService.encryptString(expense.description!)
        : null;
    final encryptedCategory = _encryptionService.encryptString(expense.category);
    final encryptedParticipants = _encryptionService.encryptList(
      expense.participants.map((p) => p.toJson()).toList()
    );

    // Insert main expense record
    await _db.into(_db.expenses).insert(ExpensesCompanion.insert(
      id: expense.id,
      title: encryptedTitle,
      amount: expense.amount,
      date: expense.date,
      description: Value(encryptedDescription),
      category: encryptedCategory,
      paidById: expense.paidById,
      source: Value(expense.source),
      isSettled: Value(expense.isSettled),
    ));

    // Insert encrypted participants
    final participantsData = _encryptionService.encryptList(
      expense.participants.map((p) => p.toJson()).toList()
    );

    // Store participants
    for (final participant in expense.participants) {
      await _db.into(_db.expenseParticipants).insert(
        ExpenseParticipantsCompanion.insert(
          expenseId: expense.id,
          userId: participant.userId,
          share: participant.share,
          hasPaid: Value(participant.hasPaid),
        ),
      );
    }
  }

  Future<model.Expense?> getExpense(String id) async {
    final query = _db.select(_db.expenses).join([
      leftOuterJoin(
        _db.expenseParticipants,
        _db.expenseParticipants.expenseId.equalsExp(_db.expenses.id),
      ),
    ])..where(_db.expenses.id.equals(id));

    final results = await query.get();
    if (results.isEmpty) return null;

    final firstRow = results.first;
    final expense = firstRow.readTable(_db.expenses);

    // Decrypt sensitive expense data
    final decryptedTitle = _encryptionService.decryptString(expense.title);
    final decryptedDescription = expense.description != null
        ? _encryptionService.decryptString(expense.description!)
        : null;
    final decryptedCategory = _encryptionService.decryptString(expense.category);

    // Get and decrypt participants
    final participants = results.map((row) {
      final participant = row.readTable(_db.expenseParticipants);
      return model.ExpenseParticipant(
        userId: participant.userId,
        share: participant.share,
        hasPaid: participant.hasPaid,
      );
    }).toList();

    return model.Expense(
      id: expense.id,
      title: decryptedTitle,
      amount: expense.amount,
      date: expense.date,
      description: decryptedDescription,
      category: decryptedCategory,
      paidById: expense.paidById,
      participants: participants,
      source: expense.source,
      isSettled: expense.isSettled,
    );
  }

  Future<List<model.Expense>> getAllExpenses() async {
    final results = await _db.select(_db.expenses).get();
    final futures = results.map((r) => getExpense(r.id));
    final expenses = await Future.wait(futures);
    return expenses.whereType<model.Expense>().toList();
  }

  Future<List<model.User>> getAllUsers() async {
    final results = await _db.select(_db.users).get();
    final futures = results.map((r) => getUser(r.id));
    final users = await Future.wait(futures);
    return users.whereType<model.User>().toList();
  }

  // Pass through other database operations that don't need encryption
  Future<void> deleteExpense(String id) async {
    await (_db.delete(_db.expenseParticipants)..where((t) => t.expenseId.equals(id))).go();
    await (_db.delete(_db.expenses)..where((t) => t.id.equals(id))).go();
  }

  Future<void> deleteUser(String id) async {
    await (_db.delete(_db.users)..where((t) => t.id.equals(id))).go();
  }

  Future<void> close() => _db.close();
}