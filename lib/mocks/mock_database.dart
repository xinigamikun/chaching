import '../interfaces/i_database.dart';

class MockDatabase implements IDatabase {
  bool _isInitialized = false;
  final int _currentVersion = 1;
  final String _dbPath = 'mock_db';
  final String _dbName = 'mock_chaching.db';

  @override
  Future<void> clearAllData() async {
    // Simulate clearing data
    await Future.delayed(const Duration(milliseconds: 100));
  }

  @override
  Future<void> close() async {
    // Simulate closing connection
    await Future.delayed(const Duration(milliseconds: 50));
    _isInitialized = false;
  }

  @override
  String get databaseName => _dbName;

  @override
  String get databasePath => _dbPath;

  @override
  Future<int> getCurrentVersion() async {
    return _currentVersion;
  }

  @override
  Future<bool> initialize() async {
    // Simulate initialization delay
    await Future.delayed(const Duration(milliseconds: 200));
    _isInitialized = true;
    return true;
  }

  @override
  Future<bool> isInitialized() async {
    return _isInitialized;
  }

  @override
  Future<bool> migrate() async {
    // Simulate migration
    await Future.delayed(const Duration(milliseconds: 150));
    return true;
  }

  @override
  Future<bool> needsMigration() async {
    // Always return false for mock
    return false;
  }
}