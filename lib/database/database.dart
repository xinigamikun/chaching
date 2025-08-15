import 'dart:convert';
import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import '../models/expense.dart' as model;
import '../models/user.dart' as model;
import 'tables.dart';

part 'database.g.dart';

@DriftDatabase(tables: [
  Users,
  Expenses,
  ExpenseParticipants,
  TransactionSenders,
  Categories,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
        // Add default categories
        await batch((batch) {
          for (final category in ['Food', 'Transport', 'Entertainment', 'Bills']) {
            batch.insert(
              categories,
              CategoriesCompanion.insert(
                name: category,
                createdAt: DateTime.now(),
                usageCount: const Value(0),
              ),
            );
          }
        });
      },
    );
  }

  // User operations
  Future<int> createUser(model.User user) {
    return into(users).insert(
      UsersCompanion.insert(
        id: user.id,
        name: user.name,
        email: user.email,
        createdAt: user.createdAt,
        preferences: Value(jsonEncode(user.preferences)),
      ),
    );
  }

  Future<model.User?> getUser(String id) async {
    final result = await (select(users)..where((u) => u.id.equals(id))).getSingleOrNull();
    if (result == null) return null;

    return model.User(
      id: result.id,
      name: result.name,
      email: result.email,
      createdAt: result.createdAt,
      preferences: result.preferences != null ? jsonDecode(result.preferences!) : null,
    );
  }

  // Expense operations
  Future<String> createExpense(model.Expense expense) async {
    await into(expenses).insert(
      ExpensesCompanion.insert(
        id: expense.id,
        title: expense.title,
        amount: expense.amount,
        date: expense.date,
        description: Value(expense.description),
        category: expense.category,
        paidById: expense.paidById,
        source: Value(expense.source),
        isSettled: Value(expense.isSettled),
      ),
    );

    // Insert participants
    for (final participant in expense.participants) {
      await into(expenseParticipants).insert(
        ExpenseParticipantsCompanion(
          expenseId: Value(expense.id),
          userId: Value(participant.userId),
          share: Value(participant.share),
          hasPaid: Value(participant.hasPaid),
        ),
      );
    }

    return expense.id;
  }

  Future<model.Expense?> getExpense(String id) async {
    final query = select(expenses).join([
      leftOuterJoin(
        expenseParticipants,
        expenseParticipants.expenseId.equalsExp(expenses.id),
      ),
    ])..where(expenses.id.equals(id));

    final results = await query.get();
    if (results.isEmpty) return null;

    final firstRow = results.first;
    final expense = firstRow.readTable(expenses);
    
    final participants = results.map((row) {
      final participant = row.readTable(expenseParticipants);
      return model.ExpenseParticipant(
        userId: participant.userId,
        share: participant.share,
        hasPaid: participant.hasPaid,
      );
    }).toList();

    return model.Expense(
      id: expense.id,
      title: expense.title,
      amount: expense.amount,
      date: expense.date,
      description: expense.description,
      category: expense.category,
      paidById: expense.paidById,
      participants: participants,
      source: expense.source,
      isSettled: expense.isSettled,
    );
  }

  // Category operations
  Future<List<String>> getCategories() {
    return select(categories)
        .map((c) => c.name)
        .get();
  }

  Future<void> addCategory(String name) {
    return into(categories).insert(
      CategoriesCompanion.insert(
        name: name,
        createdAt: DateTime.now(),
        usageCount: const Value(0),
      ),
    );
  }

  Future<void> incrementCategoryUsage(String name) async {
    final category = await (select(categories)..where((c) => c.name.equals(name)))
        .getSingle();
    
    await (update(categories)..where((c) => c.name.equals(name)))
        .write(CategoriesCompanion(
          usageCount: Value(category.usageCount + 1),
        ));
  }

  // Transaction sender patterns
  Future<List<String>> getTransactionSenders() {
    return select(transactionSenders)
        .map((s) => s.pattern)
        .get();
  }

  Future<void> addTransactionSender(String pattern) {
    return into(transactionSenders).insert(
      TransactionSendersCompanion.insert(
        pattern: pattern,
        addedAt: DateTime.now(),
      ),
    );
  }

  Future<void> removeTransactionSender(String pattern) {
    return (delete(transactionSenders)..where((s) => s.pattern.equals(pattern)))
        .go();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'chaching.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}