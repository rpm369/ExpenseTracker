import 'package:expense_tracker/Database/Constants.dart';
import 'package:expense_tracker/Errors.dart';
import 'package:hive/hive.dart';

class TransactionDb {
  TransactionDb._();
  static Box? _db;

  static TransactionDb getDb() {
    if (_db == null)
      throw InitializationException(
        message: "Transaction Db has not been initialized yet",
        completionStatus: false,
      );
    return TransactionDb._();
  }

  static Future<void> loadDb({required DbId}) async {
    if (_db != null) return;
    String boxName = TransactionDbConsts.DB_NAME.id + DbId.toString();
    _db = await Hive.openBox(boxName);
  }
}
