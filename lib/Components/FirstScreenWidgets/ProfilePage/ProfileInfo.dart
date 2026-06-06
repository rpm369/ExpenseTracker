import 'package:expense_tracker/Services/UserService.dart';
import 'package:expense_tracker/Utils/UIUtils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileInfo extends StatelessWidget {
  UserService? userService;

  Widget build(BuildContext context) {
    userService = context.watch<UserService>();
    return Column(
      spacing: 15,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        UiUtils.avatar(
          fileImageURL: userService?.getActiveUser().imageURL,
          radius: 90,
        ),
        _userNameEmail(),
      ],
    );
  }

  Widget _userNameEmail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          userService?.getActiveUser().userName ?? "Nill",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        Text(
          userService?.getActiveUser().userEmail ?? "xyz@gmail.com",
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      ],
    );
  }
}
