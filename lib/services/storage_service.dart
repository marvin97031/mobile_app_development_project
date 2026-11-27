import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api_service.dart';

/// Local persistence based on SharedPreferences.
/// Note: this is a demo. Production apps should authenticate on a server.
class StorageService {
  StorageService._();
  static final StorageService instance = StorageService._();

  static const _usersKey = 'users';
  static const _sessionKey = 'session';

  late SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Map<String, dynamic> get _users =>
      jsonDecode(_prefs.getString(_usersKey) ?? '{}') as Map<String, dynamic>;

  String _hash(String email, String password) =>
      sha256.convert(utf8.encode('$email:$password')).toString();

  /// Returns an error message, or null on success.
  Future<String?> signUp(String username, String email, String password) async {
    final key = email.trim().toLowerCase();
    final users = _users;
    if (users.containsKey(key)) {
      return 'An account with this email already exists.';
    }
    users[key] = {'username': username.trim(), 'hash': _hash(key, password)};
    await _prefs.setString(_usersKey, jsonEncode(users));
    await _prefs.setString(_sessionKey, key);
    return null;
  }

  /// Returns an error message, or null on success.
  Future<String?> login(String email, String password) async {
    final key = email.trim().toLowerCase();
    final user = _users[key] as Map<String, dynamic>?;
    if (user == null || user['hash'] != _hash(key, password)) {
      return 'Invalid email or password.';
    }
    await _prefs.setString(_sessionKey, key);
    return null;
  }

  Future<void> logout() => _prefs.remove(_sessionKey);

  String? get currentUser => _prefs.getString(_sessionKey);

  String get username =>
      (_users[currentUser] as Map<String, dynamic>?)?['username'] as String? ??
      'Guest';

  String get _favoritesKey => 'favorites_$currentUser';

  List<Meal> get favorites => (_prefs.getStringList(_favoritesKey) ?? [])
      .map((s) => Meal.fromJson(jsonDecode(s) as Map<String, dynamic>))
      .toList();

  bool isFavorite(String id) => favorites.any((m) => m.id == id);

  Future<void> toggleFavorite(Meal meal) async {
    final list = favorites;
    if (isFavorite(meal.id)) {
      list.removeWhere((m) => m.id == meal.id);
    } else {
      list.add(meal);
    }
    await _prefs.setStringList(
      _favoritesKey,
      list.map((m) => jsonEncode(m.toJson())).toList(),
    );
  }

  bool get darkMode => _prefs.getBool('dark_mode') ?? false;
  Future<void> setDarkMode(bool value) => _prefs.setBool('dark_mode', value);

  bool get notificationsEnabled => _prefs.getBool('notifications') ?? false;
  Future<void> setNotificationsEnabled(bool value) =>
      _prefs.setBool('notifications', value);
}
