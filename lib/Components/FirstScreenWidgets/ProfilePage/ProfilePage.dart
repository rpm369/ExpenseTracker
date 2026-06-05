import 'package:expense_tracker/Components/FirstScreenWidgets/ProfilePage/LogOutDialog.dart';
import 'package:expense_tracker/Components/FirstScreenWidgets/ProfilePage/OptionTile.dart';
import 'package:expense_tracker/Components/FirstScreenWidgets/ProfilePage/PrivacyPolicySheet.dart';
import 'package:expense_tracker/Components/FirstScreenWidgets/ProfilePage/ProfileInfo.dart';
import 'package:expense_tracker/Components/FirstScreenWidgets/ProfilePage/SettingsSheet.dart';
import 'package:expense_tracker/Components/FirstScreenWidgets/ProfilePage/UpdateProfileForm.dart';
import 'package:expense_tracker/Utils/UIUtils.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SafeArea(
            child: Text(
              "Profile",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 20),
          ProfileInfo(),
          SizedBox(height: 25),
          Expanded(child: _profileOptions(context: context)),
        ],
      ),
    );
  }

  Widget _profileOptions({required BuildContext context}) {
    return ListView(
      children: [
        OptionTile(
          onClick: () => UiUtils.displayBottomSheet(
            sheetContent: UpdateProfileForm(),
            context: context,
          ),
          bgColor: Colors.deepPurpleAccent,
          icon: Icons.person,
          title: "Edit Profile",
        ),
        OptionTile(
          onClick: () => UiUtils.displayBottomSheet(
            sheetContent: SettingsSheet(),
            context: context,
          ),
          bgColor: Colors.green,
          icon: Icons.settings,
          title: "Settings",
        ),
        OptionTile(
          onClick: () => UiUtils.displayBottomSheet(
            sheetContent: PrivacyPolicySheet(),
            context: context,
          ),
          bgColor: Colors.grey,
          icon: Icons.lock,
          title: "Privacy Policy",
        ),
        OptionTile(
          onClick: () async {
            await showDialog(
              context: context,
              builder: (context) => LogOutDialog(),
            );
          },
          bgColor: Colors.red,
          icon: Icons.logout_outlined,
          title: "Logout",
        ),
      ],
    );
  }
}
