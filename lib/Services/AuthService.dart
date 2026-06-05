import 'package:expense_tracker/Database/SystemDb.dart';
import 'package:expense_tracker/Database/TransactionDb.dart';
import 'package:expense_tracker/Database/UserDb.dart';
import 'package:expense_tracker/Database/WalletDb.dart';
import 'package:expense_tracker/Models/User.dart';
import 'package:flutter/semantics.dart';

class AuthService {
  static Future<void> signUp({required User user}) async {
    await Future.delayed(Duration(seconds: 3));
    UserDb userDb = UserDb.getDb();

    if (user.userName == null)
      user.userName = user.userEmail.substring(0, user.userEmail.indexOf("@"));

    //throws DuplicateEntityException handle it in the calling widget.
    int userId = await userDb.signUpUser(user: user);

    //create and made TransactionBox available.
    await loadUserTransactionDb(id: userId);
    await loadWalletDb(id: userId);
    await setSystemWideId(newId: userId);
  }

  static Future<void> loadUserTransactionDb({required int id}) async {
    await TransactionDb.loadDb(DbId: id);
  }

  static Future<void> loadWalletDb({required int id}) async {
    await WalletDb.loadDb(dbId: id);
  }

  static Future<bool> logIn({required User user}) async {
    await Future.delayed((Duration(seconds: 3)));

    UserDb userDb = UserDb.getDb();
    int? id = await userDb.logInUser(user: user);

    if (id == null) return false;

    await loadUserTransactionDb(id: id);
    await loadWalletDb(id: id);
    await setSystemWideId(newId: id);

    return true;
  }

  static Future<bool> logOut() async {
    await Future.delayed(Duration(seconds: 3));

    await setSystemWideId(newId: -1);
    await TransactionDb.closeDb();
    await WalletDb.closeDb();
    setActiveUser(id: -1);

    return true;
  }

  static Future<void> setSystemWideId({required newId}) async {
    final systemDb = await SystemDb.getDatabase();
    await systemDb.setActiveUserId(newId: newId);
  }

  static void setActiveUser({required int id}) {
    UserDb.changeActiveUser(userId: id);
  }
}
