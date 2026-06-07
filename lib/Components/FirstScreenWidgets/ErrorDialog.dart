import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  String message;

  ErrorDialog({required this.message});

  @override
  Widget build(BuildContext context) {
    Color primary = Theme.of(context).colorScheme.primary;
    Color onSurface = Theme.of(context).colorScheme.onSurface;

    return AlertDialog(
      backgroundColor: primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(10),
        side: BorderSide(width: 1, color: onSurface),
      ),
      title: Text(message, style: TextStyle(fontSize: 20)),
      titlePadding: EdgeInsets.all(15),
    );
  }
}
