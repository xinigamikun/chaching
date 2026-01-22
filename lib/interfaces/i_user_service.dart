import '../models/user.dart';

/// Interface for user management operations
abstract class IUserService {
  /// Create a new user
  /// Returns the created user
  Future<User> createUser({
    required String name,
    required String email,
    Map<String, dynamic>? preferences,
  });

  /// Get user by ID
  /// Returns null if user not found
  Future<User?> getUserById(String id);

  /// Get user by email
  /// Returns null if user not found
  Future<User?> getUserByEmail(String email);

  /// Update user information
  /// Returns the updated user
  Future<User> updateUser({
    required String id,
    String? name,
    String? email,
    Map<String, dynamic>? preferences,
  });

  /// Delete user by ID
  /// Returns true if deletion was successful
  Future<bool> deleteUser(String id);

  /// Update user preferences
  /// Returns the updated user
  Future<User> updateUserPreferences({
    required String id,
    required Map<String, dynamic> preferences,
  });

  /// Check if user exists by email
  Future<bool> userExists(String email);

  /// Get current active user
  /// Returns null if no user is active
  Future<User?> getCurrentUser();

  /// Set current active user
  Future<void> setCurrentUser(String id);

  /// Clear current active user
  Future<void> clearCurrentUser();
}