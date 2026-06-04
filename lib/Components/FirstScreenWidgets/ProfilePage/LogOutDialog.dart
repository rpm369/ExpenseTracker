import 'package:flutter/material.dart';

class LogOutDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color surface = Theme.of(context).colorScheme.surface;

    return AlertDialog(
      backgroundColor: surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(15),
      ),
      titlePadding: EdgeInsets.all(10),
      title: _buildText(
        title: "Confirm",
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
      contentPadding: EdgeInsets.all(10),
      content: _buildText(
        title: "Are you sure you want to Logout ?",
        fontSize: 15,
      ),
      actionsAlignment: MainAxisAlignment.center,
      actionsOverflowButtonSpacing: 10,
      actionsPadding: EdgeInsets.only(bottom: 15),
      actions: [
        _buildActionButton(
          title: "No",
          color: Colors.red,
          onTap: () => Navigator.pop(context, false),
        ),
        _buildActionButton(
          title: "Yes",
          color: Colors.lightGreenAccent,
          onTap: () => Navigator.pop(context, true),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return TextButton(
      onPressed: onTap,
      child: Text(title, style: TextStyle(fontSize: 20, color: color)),
    );
  }

  Widget _buildText({
    required String title,
    required double fontSize,
    FontWeight? fontWeight,
  }) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
    );
  }
}
