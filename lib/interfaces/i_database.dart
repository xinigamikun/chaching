import '../services/encryption_service.dart';

/// Interface for database operations and initialization
abstract class IDatabase {
  /// Initialize the database and create necessary tables
  /// Returns true if initialization is successful
  Future<bool> initialize();

  /// Check if database needs migration based on version
  /// Returns true if migration is needed
  Future<bool> needsMigration();

  /// Perform database migration to latest version
  /// Returns true if migration is successful
  Future<bool> migrate();

  /// Get current database version
  Future<int> getCurrentVersion();

  /// Close database connection and cleanup resources
  Future<void> close();

  /// Clear all data from database (useful for testing or reset)
  Future<void> clearAllData();

  /// Check if database is initialized
  Future<bool> isInitialized();

  /// Get database path
  String get databasePath;

  /// Get database name
  String get databaseName;

  /// Initialize encryption for the database
  Future<void> initializeEncryption(EncryptionService encryptionService);
}