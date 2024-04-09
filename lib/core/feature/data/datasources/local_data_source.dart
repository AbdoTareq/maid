import 'dart:convert';

import 'package:tasks/export.dart';

abstract class LocalDataSource {
  Map<String, dynamic>? read(String key);
  Future<bool?> write(String key, Map<String, dynamic> value);
  Future<bool?> remove(String key);
  bool containsKey(String key);
}

class LocalDataSourceImpl implements LocalDataSource {
  final SharedPreferences box;

  LocalDataSourceImpl({required this.box});

  @override
  Map<String, dynamic>? read(String key) {
    return containsKey(key) ? (jsonDecode(box.get(key) as String)) : null;
  }

  @override
  Future<bool?> write(String key, Map<String, dynamic> value) async {
    return await box.setString(key, json.encode(value));
  }

  @override
  Future<bool?> remove(String key) async {
    return await box.remove(key);
  }

  @override
  bool containsKey(String key) {
    return box.containsKey(key);
  }
}
