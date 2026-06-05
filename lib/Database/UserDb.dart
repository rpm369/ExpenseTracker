import 'package:expense_tracker/Database/Constants.dart';
import 'package:expense_tracker/Errors.dart';
import 'package:expense_tracker/Models/User.dart';
import 'package:hive_flutter/hive_flutter.dart';

class UserDb {
  UserDb._();

  static Box? _db;

  static UserDb getDb() {
    if (_db == null)
      throw InitializationException(
        message: "UserDb is not loaded yet.",
        completionStatus: false,
      );
    return UserDb._();
  }

  static Future<void> loadDb() async {
    _db = await Hive.openBox(UserDbConst.DB_NAME.id);
  }

  Future<int> signUpUser({required User user}) async {
    User? userInDb = _db!.keys.singleWhere(
      (userElement) => user.userEmail == userElement.userEmail,
      orElse: null,
    );

    if (userInDb != null)
      throw DuplicateEntityException(
        message: "User Already exist",
        completionStatus: false,
      );

    return await _db!.add(user);
  }
}
