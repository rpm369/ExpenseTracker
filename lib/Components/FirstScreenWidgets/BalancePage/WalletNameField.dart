import 'package:expense_tracker/Utils/UIUtils.dart';
import 'package:flutter/material.dart';

class WalletNameField extends StatelessWidget {
  void Function(String) callBack;
  FocusNode node = FocusNode();
  TextEditingController controller = new TextEditingController();

  WalletNameField({required this.callBack}) {
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
