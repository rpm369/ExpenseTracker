import 'package:expense_tracker/Components/FirstScreenWidgets/FormHeader.dart';
import 'package:expense_tracker/Themes/ThemeProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SettingsSheet extends StatelessWidget {
  ValueNotifier<bool> isDark = ValueNotifier(true);

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
              children: [_themeToggleButton()],
            ),
          ),
        ],
      ),
    );
  }

  Widget _themeToggleButton() {
    return ValueListenableBuilder(
      valueListenable: isDark,
      builder: (context, value, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _commonText(title: "Dark Theme", fontSize: 18),
            Switch(
              value: isDark.value,
              onChanged: (value) => isDark.value = value,
              activeTrackColor: Colors.lightGreenAccent,
              activeColor: Colors.green,
              inactiveTrackColor: Colors.redAccent,
            ),
          ],
        );
      },
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
