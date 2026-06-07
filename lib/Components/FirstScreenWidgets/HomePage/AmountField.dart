import 'package:expense_tracker/Utils/UIUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AmountField extends StatelessWidget {
  void Function(double) callBack;
  FocusNode node;

  AmountField({required this.callBack, required this.node}) {
    node.addListener(() {
      if (!node.hasFocus) {
        String userAmount = (controller.text.isEmpty) ? "0" : controller.text;
        double newAmount = double.parse(userAmount);
        callBack(newAmount);
      }
    });
  }
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Color onSurface = Theme.of(context).colorScheme.onSurface;
    return UiUtils.FormTextField(
      context: context,
      hintText: "Default 0",
      node: node,
      controller: controller,
      keyboardType: TextInputType.number,
    );
  }
}
