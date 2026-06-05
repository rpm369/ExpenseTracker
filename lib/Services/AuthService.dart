import 'package:expense_tracker/Database/TransactionDb.dart';
import 'package:expense_tracker/Database/UserDb.dart';
import 'package:expense_tracker/Database/WalletDb.dart';
import 'package:expense_tracker/Models/User.dart';

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

    return true;
  }
}
