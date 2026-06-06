import 'dart:io';

import 'package:expense_tracker/Database/UserDb.dart';
import 'package:expense_tracker/Models/User.dart';
import 'package:expense_tracker/Services/ImageProcessService.dart';
import 'package:flutter/widgets.dart';

class UserService extends ChangeNotifier {
  User getActiveUser() {
    return UserDb.activeUser!;
  }

  Future<bool> updateUser({required User user}) async {
    await Future.delayed(Duration(seconds: 3));
    User activeUser = getActiveUser();
    bool needToUpdate = false;

    if (activeUser.imageURL != user.imageURL) {
      String newImageUrl = await ImageProcessingService.saveUserImage(
        tempImageUrl: user.imageURL!,
        userKey: activeUser.key,
      );
      activeUser.imageURL = newImageUrl;
      needToUpdate = true;
    }

    if (activeUser.userName != user.userName) {
      activeUser.userName = user.userName;
      needToUpdate = true;
    }

    if (needToUpdate) {
      await activeUser.save();
    }
    if (activeUser.imageURL != null)
      await FileImage(File(activeUser.imageURL!)).evict();
    notifyListeners();

    return true;
  }
}
