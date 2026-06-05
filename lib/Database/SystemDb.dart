import 'package:expense_tracker/Database/Constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SystemDb extends ChangeNotifier {
  SystemDb._();

  static SharedPreferences? _db;

  static Future<SystemDb> getDatabase() async {
    if (_db == null) await _loadSystemDb();
    return SystemDb._();
  }

  static Future<void> _loadSystemDb() async {
    _db = await SharedPreferences.getInstance();
    bool isFirstTime = _db!.getKeys().isEmpty;

    if (isFirstTime) await _initialize();
  }

  static Future<void> _initialize() async {
    await _db!.setBool(SystemDbConst.IS_DARK.id, true);
    await _db!.setString(SystemDbConst.LOGGED_USER_ID.id, '');
  }

  bool isDarkModeEnabled() {
    return _db!.getBool(SystemDbConst.IS_DARK.id)!;
  }

  bool isUserActive() {
    return _db!.getString(SystemDbConst.LOGGED_USER_ID.id)! != '';
  }

  Future<bool> switchThemeMode() async {
    return await _db!.setBool(
      SystemDbConst.IS_DARK.id,
      !(_db!.getBool(SystemDbConst.IS_DARK.id)!),
    );
  }

  Future<void> setActiveUserId({required String newId}) {
    return _db!.setString(SystemDbConst.LOGGED_USER_ID.id, newId);
  }
}
