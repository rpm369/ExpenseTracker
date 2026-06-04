import 'package:expense_tracker/Utils/UIUtils.dart';
import 'package:flutter/material.dart';

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 15,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        UiUtils.avatar(assetImageURL: "assets/images/demo.png", radius: 90),
        _userNameEmail(),
      ],
    );
  }

  Widget _userNameEmail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Gautam Jangid",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        Text(
          "jangidgautam07@gmail.com",
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      ],
    );
  }
}
