import 'package:expense_tracker/Database/Constants.dart';
import 'package:expense_tracker/Errors.dart';
import 'package:hive/hive.dart';

class WalletDb {
  WalletDb._();

  static Box? _db;

  static Future<WalletDb> getDb() async {
    if (_db == null)
      throw InitializationException(
        message: "Wallet Db has not been initialized yet",
        completionStatus: false,
      );
    return WalletDb._();
  }

  static Future<void> loadDb({required int dbId}) async {
    if (_db != null) return;
    String boxName = WalletDbConst.DB_NAME.id + dbId.toString();
    _db = await Hive.openBox(boxName);
  }
}
