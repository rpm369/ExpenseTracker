import 'package:expense_tracker/Database/Constants.dart';
import 'package:expense_tracker/Services/AuthService.dart';
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
    await _db!.setInt(SystemDbConst.LOGGED_USER_ID.id, -1);
  }

  bool isDarkModeEnabled() {
    return _db!.getBool(SystemDbConst.IS_DARK.id)!;
  }

  Future<bool> isUserActive() async {
    int userId = _db!.getInt(SystemDbConst.LOGGED_USER_ID.id)!;

    if (userId != -1) {
      await AuthService.loadUserTransactionDb(id: userId);
      await AuthService.loadWalletDb(id: userId);
    }

    return userId != -1;
  }

  Future<bool> switchThemeMode() async {
    return await _db!.setBool(
      SystemDbConst.IS_DARK.id,
      !(_db!.getBool(SystemDbConst.IS_DARK.id)!),
    );
  }

  Future<void> setActiveUserId({required int newId}) {
    return _db!.setInt(SystemDbConst.LOGGED_USER_ID.id, newId);
  }
}
