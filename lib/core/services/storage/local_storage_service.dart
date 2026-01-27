import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

/// Local Storage Service Interface
abstract class LocalStorageService {
  // String
  Future<void> setString(String key, String value);
  String? getString(String key);

  // Int
  Future<void> setInt(String key, int value);
  int? getInt(String key);

  // Double
  Future<void> setDouble(String key, double value);
  double? getDouble(String key);

  // Bool
  Future<void> setBool(String key, bool value);
  bool? getBool(String key);

  // StringList
  Future<void> setStringList(String key, List<String> value);
  List<String>? getStringList(String key);

  // JSON Object
  Future<void> setObject(String key, Map<String, dynamic> value);
  Map<String, dynamic>? getObject(String key);

  // JSON List
  Future<void> setObjectList(String key, List<Map<String, dynamic>> value);
  List<Map<String, dynamic>>? getObjectList(String key);

  // Remove
  Future<void> remove(String key);

  // Clear all
  Future<void> clear();

  // Check if key exists
  bool containsKey(String key);

  // Get all keys
  Set<String> getKeys();
}

/// Local Storage Service Implementation
class LocalStorageServiceImpl implements LocalStorageService {
  final SharedPreferences sharedPreferences;

  LocalStorageServiceImpl({required this.sharedPreferences});

  //═══════════════════════════════════════════════════════════════
  // STRING
  //═══════════════════════════════════════════════════════════════

  @override
  Future<void> setString(String key, String value) async {
    await sharedPreferences.setString(key, value);
  }

  @override
  String? getString(String key) {
    return sharedPreferences.getString(key);
  }

  //═══════════════════════════════════════════════════════════════
  // INT
  //═══════════════════════════════════════════════════════════════

  @override
  Future<void> setInt(String key, int value) async {
    await sharedPreferences.setInt(key, value);
  }

  @override
  int? getInt(String key) {
    return sharedPreferences.getInt(key);
  }

  //═══════════════════════════════════════════════════════════════
  // DOUBLE
  //═══════════════════════════════════════════════════════════════

  @override
  Future<void> setDouble(String key, double value) async {
    await sharedPreferences.setDouble(key, value);
  }

  @override
  double? getDouble(String key) {
    return sharedPreferences.getDouble(key);
  }

  //═══════════════════════════════════════════════════════════════
  // BOOL
  //═══════════════════════════════════════════════════════════════

  @override
  Future<void> setBool(String key, bool value) async {
    await sharedPreferences.setBool(key, value);
  }

  @override
  bool? getBool(String key) {
    return sharedPreferences.getBool(key);
  }

  //═══════════════════════════════════════════════════════════════
  // STRING LIST
  //═══════════════════════════════════════════════════════════════

  @override
  Future<void> setStringList(String key, List<String> value) async {
    await sharedPreferences.setStringList(key, value);
  }

  @override
  List<String>? getStringList(String key) {
    return sharedPreferences.getStringList(key);
  }

  //═══════════════════════════════════════════════════════════════
  // JSON OBJECT
  //═══════════════════════════════════════════════════════════════

  @override
  Future<void> setObject(String key, Map<String, dynamic> value) async {
    final jsonString = jsonEncode(value);
    await sharedPreferences.setString(key, jsonString);
  }

  @override
  Map<String, dynamic>? getObject(String key) {
    final jsonString = sharedPreferences.getString(key);
    if (jsonString == null) return null;
    try {
      return jsonDecode(jsonString) as Map<String, dynamic>;
    } catch (e) {
      return null;
    }
  }

  //═══════════════════════════════════════════════════════════════
  // JSON LIST
  //═══════════════════════════════════════════════════════════════

  @override
  Future<void> setObjectList(
      String key, List<Map<String, dynamic>> value) async {
    final jsonString = jsonEncode(value);
    await sharedPreferences.setString(key, jsonString);
  }

  @override
  List<Map<String, dynamic>>? getObjectList(String key) {
    final jsonString = sharedPreferences.getString(key);
    if (jsonString == null) return null;
    try {
      final list = jsonDecode(jsonString) as List;
      return list.map((item) => item as Map<String, dynamic>).toList();
    } catch (e) {
      return null;
    }
  }

  //═══════════════════════════════════════════════════════════════
  // REMOVE & CLEAR
  //═══════════════════════════════════════════════════════════════

  @override
  Future<void> remove(String key) async {
    await sharedPreferences.remove(key);
  }

  @override
  Future<void> clear() async {
    await sharedPreferences.clear();
  }

  //═══════════════════════════════════════════════════════════════
  // UTILITY
  //═══════════════════════════════════════════════════════════════

  @override
  bool containsKey(String key) {
    return sharedPreferences.containsKey(key);
  }

  @override
  Set<String> getKeys() {
    return sharedPreferences.getKeys();
  }
}
