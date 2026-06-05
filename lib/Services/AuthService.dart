import 'package:expense_tracker/Database/UserDb.dart';
import 'package:expense_tracker/Models/User.dart';

class AuthService {
  static Future<void> signUp({required User user}) async {
    UserDb userDb = UserDb.getDb();

    if (user.userName == null)
      user.userName = user.userEmail.substring(0, user.userEmail.indexOf("@"));

    //throws DuplicateEntityException handle it in the calling widget.
    int userId = await userDb.signUpUser(user: user);

    _createUserTransactionDb(id: userId);
  }

  static Future<void> _createUserTransactionDb({required int id}) async {}
}
