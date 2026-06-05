import 'package:expense_tracker/Database/Constants.dart';
import 'package:expense_tracker/Errors.dart';
import 'package:expense_tracker/Models/User.dart';
import 'package:hive_flutter/hive_flutter.dart';

class UserDb {
  UserDb._();

  static Box<User>? _db;
  static User? activeUser;

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
    User? userInDb = _db!.keys.singleWhere((key) {
      return (_db!.getAt(key))!.userEmail == user.userEmail;
    }, orElse: () => null);

    if (userInDb != null)
      throw DuplicateEntityException(
        message: "User Already exist",
        completionStatus: false,
      );

    activeUser = user;

    return await _db!.add(user);
  }

  Future<int?> logInUser({required User user}) async {
    User? tempUser;

    for (int key in _db!.keys) {
      if (_db!.get(key)!.userEmail == user.userEmail &&
          _db!.get(key)!.userPassword == user.userPassword) {
        tempUser = _db!.get(key);
        break;
      }
    }

    activeUser = tempUser;

    return (activeUser == null) ? null : activeUser!.key as int;
  }
}
