import 'package:expense_tracker/Components/FirstScreenWidgets/HomePage/HomeCommons.dart';
import 'package:expense_tracker/Utils/UIUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AmountField extends StatelessWidget {
  void Function(double) callBack;

  AmountField({required this.callBack}) {
    callBack(0);

    node.addListener(() {
      if (!node.hasFocus) {
        String userAmount = (controller.text.isEmpty) ? "0" : controller.text;
        double newAmount = double.parse(userAmount);
        callBack(newAmount);
      }
    });
  }

  FocusNode node = FocusNode();
  TextEditingController controller = TextEditingController(text: "0");

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
