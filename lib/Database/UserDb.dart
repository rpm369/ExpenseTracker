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

  static void changeActiveUser({required int userId}) {
    if (userId < 0) {
      activeUser = null;
      return;
    }
    activeUser = _db!.get(userId)!;
  }

  Future<int> signUpUser({required User user}) async {
    User? userInDb;

    for (User listUser in _db!.values) {
      if (listUser.userEmail == user.userEmail) {
        userInDb = listUser;
        break;
      }
    }

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

    for (User listUser in _db!.values) {
      if (listUser.userEmail == user.userEmail &&
          listUser.userPassword == user.userPassword) {
        tempUser = listUser;
        break;
      }
    }

    activeUser = tempUser;

    return (activeUser == null) ? null : activeUser!.key as int;
  }

  Future<void> updateUser() async {
    await activeUser!.save();
  }
}
