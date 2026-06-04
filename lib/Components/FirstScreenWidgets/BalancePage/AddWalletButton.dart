import 'package:expense_tracker/Utils/UIUtils.dart';
import 'package:flutter/material.dart';

class AddWalletButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color primary = Theme.of(context).colorScheme.primary;
    return GestureDetector(
      child: UiUtils.formButton(primary: primary, title: "Add Wallet"),
    );
  }
}
