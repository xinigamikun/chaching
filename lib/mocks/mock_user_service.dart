import '../interfaces/i_user_service.dart';
import '../models/user.dart';

class MockUserService implements IUserService {
  final Map<String, User> _users = {};
  String? _currentUserId;
  int _userIdCounter = 1;

  String _generateUserId() => 'user_${_userIdCounter++}';

  @override
  Future<void> clearCurrentUser() async {
    _currentUserId = null;
  }

  @override
  Future<User> createUser({
    required String name,
    required String email,
    Map<String, dynamic>? preferences,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 100));

    final user = User(
      id: _generateUserId(),
      name: name,
      email: email,
      createdAt: DateTime.now(),
      preferences: preferences,
    );

    _users[user.id] = user;
    return user;
  }

  @override
  Future<bool> deleteUser(String id) async {
    await Future.delayed(const Duration(milliseconds: 50));
    if (_users.containsKey(id)) {
      _users.remove(id);
      if (_currentUserId == id) {
        _currentUserId = null;
      }
      return true;
    }
    return false;
  }

  @override
  Future<User?> getCurrentUser() async {
    if (_currentUserId == null) return null;
    return _users[_currentUserId];
  }

  @override
  Future<User?> getUserByEmail(String email) async {
    await Future.delayed(const Duration(milliseconds: 50));
    return _users.values.firstWhere(
      (user) => user.email == email,
      orElse: () => null as User,
    );
  }

  @override
  Future<User?> getUserById(String id) async {
    await Future.delayed(const Duration(milliseconds: 50));
    return _users[id];
  }

  @override
  Future<void> setCurrentUser(String id) async {
    if (_users.containsKey(id)) {
      _currentUserId = id;
    } else {
      throw Exception('User not found');
    }
  }

  @override
  Future<User> updateUser({
    required String id,
    String? name,
    String? email,
    Map<String, dynamic>? preferences,
  }) async {
    await Future.delayed(const Duration(milliseconds: 100));
    
    final existingUser = _users[id];
    if (existingUser == null) {
      throw Exception('User not found');
    }

    final updatedUser = User(
      id: id,
      name: name ?? existingUser.name,
      email: email ?? existingUser.email,
      createdAt: existingUser.createdAt,
      preferences: preferences ?? existingUser.preferences,
    );

    _users[id] = updatedUser;
    return updatedUser;
  }

  @override
  Future<User> updateUserPreferences({
    required String id,
    required Map<String, dynamic> preferences,
  }) async {
    await Future.delayed(const Duration(milliseconds: 75));
    
    final existingUser = _users[id];
    if (existingUser == null) {
      throw Exception('User not found');
    }

    final updatedUser = User(
      id: id,
      name: existingUser.name,
      email: existingUser.email,
      createdAt: existingUser.createdAt,
      preferences: preferences,
    );

    _users[id] = updatedUser;
    return updatedUser;
  }

  @override
  Future<bool> userExists(String email) async {
    await Future.delayed(const Duration(milliseconds: 50));
    return _users.values.any((user) => user.email == email);
  }
}