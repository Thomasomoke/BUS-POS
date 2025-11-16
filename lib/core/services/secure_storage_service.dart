import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SecureStorageService {
  static SecureStorageService? _instance;
  late SharedPreferences _prefs;

  SecureStorageService._internal();

  static Future<SecureStorageService> getInstance() async {
    if (_instance == null) {
      final service = SecureStorageService._internal();
      service._prefs = await SharedPreferences.getInstance();
      _instance = service;
    }
    return _instance!;
  }

  /// Save a string value
  Future<bool> setString(String key, String value) async {
    return _prefs.setString(key, value);
  }

  /// Save a boolean value
  Future<bool> setBool(String key, bool value) async {
    return _prefs.setBool(key, value);
  }

  /// Save an int value
  Future<bool> setInt(String key, int value) async {
    return _prefs.setInt(key, value);
  }

  /// Save a double value
  Future<bool> setDouble(String key, double value) async {
    return _prefs.setDouble(key, value);
  }

  /// Save a JSON object (encode to string)
  Future<bool> setJson(String key, Map<String, dynamic> json) async {
    return _prefs.setString(key, jsonEncode(json));
  }

  /// Save a list of strings
  Future<bool> setStringList(String key, List<String> values) async {
    return _prefs.setStringList(key, values);
  }

  /// Save a list of json

  Future<void> setJsonList(String key, List<Map<String, dynamic>> list) async {
    await _prefs.setString(key, jsonEncode(list));
  }

  /// Get a list of json

  List<Map<String, dynamic>>? getJsonList(String key) {
    final jsonString = _prefs.getString(key);
    if (jsonString == null) return null;
    final List<dynamic> decoded = jsonDecode(jsonString);
    return decoded.map((e) => e as Map<String, dynamic>).toList();
  }

  /// Get a string value
  String? getString(String key) => _prefs.getString(key);

  /// Get a bool value
  bool? getBool(String key) => _prefs.getBool(key);

  /// Get an int value
  int? getInt(String key) => _prefs.getInt(key);

  /// Get a double value
  double? getDouble(String key) => _prefs.getDouble(key);

  /// Get a JSON object (decode from string)
  Map<String, dynamic>? getJson(String key) {
    final raw = _prefs.getString(key);
    if (raw == null) return null;
    return jsonDecode(raw) as Map<String, dynamic>;
  }

  /// Get a list of strings
  List<String>? getStringList(String key) => _prefs.getStringList(key);

  /// Remove a key, delete a value
  Future<bool> remove(String key) async {
    return _prefs.remove(key);
  }

  /// Clear all keys, deletes all data in local storage
  Future<bool> clear() async {
    return _prefs.clear();
  }

  /// Check if a key exists
  bool containsKey(String key) => _prefs.containsKey(key);
}

late SecureStorageService storage;
