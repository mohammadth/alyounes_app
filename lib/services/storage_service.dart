import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageService {
  static final StorageService _instance = StorageService._internal();
  factory StorageService() => _instance;
  StorageService._internal();

  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  SharedPreferences? _prefs;

  Future<SharedPreferences> get prefs async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!;
  }

  Future<void> saveString(String key, String value) async {
    final p = await prefs;
    await p.setString(key, value);
  }

  Future<String?> getString(String key) async {
    final p = await prefs;
    return p.getString(key);
  }

  Future<void> remove(String key) async {
    final p = await prefs;
    await p.remove(key);
  }

  Future<void> saveSecureString(String key, String value) async {
    await _secureStorage.write(key: key, value: value);
  }

  Future<String?> getSecureString(String key) async {
    return await _secureStorage.read(key: key);
  }

  Future<void> saveUsername(String prefKey, String username) async {
    await saveString(prefKey, username);
  }

  Future<String?> getUsername(String prefKey) async {
    return await getString(prefKey);
  }

  Future<void> removeUsername(String prefKey) async {
    await remove(prefKey);
  }
}
