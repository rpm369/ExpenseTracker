import 'package:expense_tracker/Components/FirstScreenWidgets/ProfilePage/ProfileInfo.dart';
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
          SizedBox(height: 10),
          Expanded(child: _profileOptions(context: context)),
        ],
      ),
    );
  }

  Widget _profileOptions({required BuildContext context}) {
    return ListView(
      children: [
        _optionTile(
          context: context,
          bgColor: Colors.deepPurpleAccent,
          icon: Icons.person,
          title: "Edit Profile",
        ),
        _optionTile(
          context: context,
          bgColor: Colors.green,
          icon: Icons.settings,
          title: "Settings",
        ),

        _optionTile(
          context: context,
          bgColor: Colors.grey,
          icon: Icons.lock,
          title: "Privacy Policy",
        ),
        _optionTile(
          context: context,
          bgColor: Colors.red,
          icon: Icons.logout_outlined,
          title: "Logout",
        ),
      ],
    );
  }

  Widget _optionTile({
    required BuildContext context,
    required Color bgColor,
    required IconData icon,
    required String title,
  }) {
    Color onSurface = Theme.of(context).colorScheme.onSurface;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _leadingInfo(bgColor: bgColor, icon: icon, title: title),
          Icon(Icons.arrow_forward_ios_outlined, color: onSurface, size: 18),
        ],
      ),
    );
  }

  Widget _leadingInfo({
    required Color bgColor,
    required IconData icon,
    required String title,
  }) {
    return Row(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: bgColor,
          ),
          child: Icon(icon, size: 30, color: Colors.white),
        ),
        Text(title, style: TextStyle(fontSize: 20)),
      ],
    );
  }
}
