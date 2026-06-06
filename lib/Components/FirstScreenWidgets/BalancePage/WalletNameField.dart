import 'package:expense_tracker/Models/Wallet.dart';
import 'package:expense_tracker/Utils/UIUtils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WalletNameField extends StatelessWidget {
  FocusNode node;
  TextEditingController? controller;
  GlobalKey<FormFieldState> formTextkey = GlobalKey();
  Wallet? wallet;

  WalletNameField({required this.node}) {
    node.addListener(() {
      if (!node.hasFocus) {
        if (controller!.text.isNotEmpty) {
          bool status = formTextkey.currentState!.validate();
          if (status) wallet!.title = controller!.text;
        }
      } else {
        formTextkey.currentState!.clearError();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    wallet = context.read<Wallet>();
    controller = TextEditingController(text: wallet!.title);

    return UiUtils.FormTextField(
      key: formTextkey,
      context: context,
      hintText: "Salary",
      controller: controller,
      node: node,
      validator: (value) {
        if (value == null || value.isEmpty) return "Required Field";
      },
    );
  }
}
