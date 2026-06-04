import 'package:expense_tracker/Utils/UIUtils.dart';
import 'package:flutter/material.dart';

class WalletNameField extends StatelessWidget {
  String? existingText;
  void Function(String) callBack;
  FocusNode node = FocusNode();
  late TextEditingController controller;

  WalletNameField({required this.callBack, this.existingText})
    : controller = TextEditingController(text: existingText) {
    node.addListener(() {
      if (!node.hasFocus) callBack(controller.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return UiUtils.FormTextField(
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
