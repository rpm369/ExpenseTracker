import 'package:flutter/material.dart';

class UiUtils {
  static void displayBottomSheet({
    required Widget sheetContent,
    required BuildContext context,
  }) {
    Color primary = Theme.of(context).colorScheme.primary;
    showModalBottomSheet(
      context: context,
      backgroundColor: primary,
      isScrollControlled:
          true, // Crucial for forms so it can resize with the keyboard
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.87,
          child: sheetContent,
        );
      },
    );
  }
}
