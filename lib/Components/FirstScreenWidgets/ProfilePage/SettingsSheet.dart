import 'package:expense_tracker/Components/FirstScreenWidgets/FormHeader.dart';
import 'package:expense_tracker/Database/SystemDb.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsSheet extends StatefulWidget {
  @override
  State<SettingsSheet> createState() => _SettingsSheetState();
}

class _SettingsSheetState extends State<SettingsSheet> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          FormHeader(title: "Settings"),
          SizedBox(height: 30),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(15),
              children: [_themeToggleButton(context: context)],
            ),
          ),
        ],
      ),
    );
  }

  Widget _themeToggleButton({required BuildContext context}) {
    SystemDb sysDb = context.watch<SystemDb>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _commonText(title: "Dark Theme", fontSize: 18),
        Switch(
          value: sysDb.isDarkModeEnabled(),
          onChanged: (_) async {
            await sysDb.switchThemeMode();
          },
          activeTrackColor: Colors.lightGreenAccent,
          activeColor: Colors.green,
          inactiveTrackColor: Colors.redAccent,
        ),
      ],
    );
  }

  Widget _commonText({
    required String title,
    required double fontSize,
    Color? textColor,
  }) {
    return Text(
      title,
      style: TextStyle(color: textColor, fontSize: fontSize),
    );
  }
}
