import 'package:expense_tracker/Database/Constants.dart';
import 'package:expense_tracker/Errors.dart';
import 'package:expense_tracker/Models/Wallet.dart';
import 'package:hive/hive.dart';

class WalletDb {
  WalletDb._();

  static Box<Wallet>? _db;

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

  static Future<void> closeDb() async {
    await _db!.close();
    _db = null;
  }

  Future<int> addNewWallet({required Wallet wallet}) async {
    int id = await _db!.add(wallet);
    return id;
  }

  Future<void> update({required Wallet wallet}) async {
    await wallet.save();
  }

  Future<Wallet> getWallet({required int id}) async {
    return await _db!.get(id)!;
  }

  List<Wallet> getWalletList() {
    return _db!.values.toList();
  }

  Future<void> deleteWallet({required Wallet wallet}) async {
    await wallet.delete();
  }
}
