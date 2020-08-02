import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

@lazySingleton
class StorageService with ReactiveServiceMixin {
  SharedPreferences prefs;

  Future<void> intialize() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<void> addNewKeyValue(String key, dynamic value) async {
    await prefs.setString(key, jsonEncode(value));
  }

  Future<void> removeKeyValue(String key) async {
    await prefs.remove(key);
  }

  Future<void> updateValue(String key, dynamic value) async {
    await removeKeyValue(key);
    await addNewKeyValue(key, jsonEncode(value));
  }

  Future<dynamic> getValueFromKey(String key) async {
    return await json.decode(await prefs.get(key));
  }

  Future<void> clearAll() async {
    await prefs.clear();
  }
}
