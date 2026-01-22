import 'package:drift/drift.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import '../database/database.dart';
import '../database/encrypted_database.dart';
import '../interfaces/i_database.dart';
import '../services/encryption_service.dart';
import '../models/expense.dart' as model;
import '../models/user.dart' as model;

export '../models/expense.dart';
export '../models/user.dart';

class DatabaseService implements IDatabase {
  late final AppDatabase _db;
  late final EncryptedDatabase _encryptedDb;
  bool _isInitialized = false;
  String? _dbPath;

  DatabaseService() {
    _db = AppDatabase();
  }

  void setEncryptionService(EncryptionService encryptionService) {
    _encryptedDb = EncryptedDatabase(_db, encryptionService);
  }

  @override
  Future<bool> initialize() async {
    try {
      // Get and store the database path
      final dbFolder = await getApplicationDocumentsDirectory();
      _dbPath = p.join(dbFolder.path, databaseName);

      // Trigger database creation by accessing a table
      // Drift will handle the creation and migration automatically
      await _db.getCategories();

      _isInitialized = true;
      return true;
    } catch (e) {
      print('Database initialization failed: $e');
      return false;
    }
  }

  @override
  Future<void> initializeEncryption(EncryptionService encryptionService) async {
    if (!_isInitialized) {
      throw Exception('Database must be initialized before setting up encryption');
    }
    setEncryptionService(encryptionService);
  }

  @override
  Future<bool> needsMigration() async {
    // In this implementation, Drift handles migrations automatically
    return false;
  }

  @override
  Future<bool> migrate() async {
    // Drift handles migrations automatically
    return true;
  }

  @override
  Future<int> getCurrentVersion() async {
    return _db.schemaVersion;
  }

  @override
  Future<void> close() async {
    await _encryptedDb.close();
    _isInitialized = false;
  }

  // Delegate database operations to encrypted database
  Future<void> createUser(model.User user) => _encryptedDb.createUser(user);
  Future<model.User?> getUser(String id) => _encryptedDb.getUser(id);
  Future<List<model.User>> getAllUsers() => _encryptedDb.getAllUsers();
  Future<void> createExpense(model.Expense expense) => _encryptedDb.createExpense(expense);
  Future<model.Expense?> getExpense(String id) => _encryptedDb.getExpense(id);
  Future<List<model.Expense>> getAllExpenses() => _encryptedDb.getAllExpenses();

  @override
  Future<void> clearAllData() async {
    // Delete all data from all tables
    await _db.transaction(() async {
      await _db.delete(_db.users).go();
      await _db.delete(_db.expenses).go();
      await _db.delete(_db.expenseParticipants).go();
      await _db.delete(_db.transactionSenders).go();
      await _db.delete(_db.categories).go();
    });
  }

  @override
  Future<bool> isInitialized() async {
    return _isInitialized;
  }

  @override
  String get databasePath => _dbPath ?? '';

  @override
  String get databaseName => 'chaching.sqlite';

  // Helper method to get the database instance
  AppDatabase get database => _db;
}