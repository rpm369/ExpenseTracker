import 'package:expense_tracker/Utils/UIUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AmountField extends StatefulWidget {
  final void Function(double) callBack;
  final FocusNode node;

  const AmountField({
    super.key,
    required this.callBack,
    required this.node,
  });

  @override
  State<AmountField> createState() => _AmountFieldState();
}

class _AmountFieldState extends State<AmountField> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return UiUtils.FormTextField(
      context: context,
      hintText: "Default 0",
      node: widget.node,
      controller: controller,
      onChange: (value) {
        String userAmount = (value.isEmpty) ? "0" : value;
        double newAmount = double.parse(userAmount);
        widget.callBack(newAmount);
      },
      keyboardType: TextInputType.number,
    );
  }
}
