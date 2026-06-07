import 'package:expense_tracker/Database/Constants.dart';
import 'package:expense_tracker/Errors.dart';
import 'package:expense_tracker/Models/Transaction.dart';
import 'package:hive/hive.dart';

class TransactionDb {
  TransactionDb._();
  static Box<Transaction>? _db;

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

  static Future<void> closeDb() async {
    await _db!.close();
    _db = null;
  }

  Future<int> addNewTransaction({required Transaction newTransaction}) async {
    return await _db!.add(newTransaction);
  }

  Future<void> updateTransaction({required Transaction transaction}) async {
    await transaction.save();
  }

  List<Transaction> getAllTransactions() {
    return _db!.values.toList();
  }
}
