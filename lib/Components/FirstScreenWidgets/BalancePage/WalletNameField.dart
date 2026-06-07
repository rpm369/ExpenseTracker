import 'package:expense_tracker/Models/Wallet.dart';
import 'package:expense_tracker/Utils/UIUtils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WalletNameField extends StatefulWidget {
  final FocusNode node;

  const WalletNameField({super.key, required this.node});

  @override
  State<WalletNameField> createState() => _WalletNameFieldState();
}

class _WalletNameFieldState extends State<WalletNameField> {
  final GlobalKey<FormFieldState> formTextkey = GlobalKey();
  late final TextEditingController controller;
  late final Wallet wallet;

  @override
  void initState() {
    super.initState();
    wallet = context.read<Wallet>();
    controller = TextEditingController(text: wallet.title);
    widget.node.addListener(_focusListener);
  }

  void _focusListener() {
    if (!widget.node.hasFocus) {
      if (controller.text.isNotEmpty) {
        formTextkey.currentState?.validate();
      }
    } else {
      formTextkey.currentState?.clearError();
    }
  }

  @override
  void dispose() {
    widget.node.removeListener(_focusListener);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return UiUtils.FormTextField(
      key: formTextkey,
      context: context,
      hintText: "Salary",
      controller: controller,
      node: widget.node,
      onChange: (value) => wallet.title = value,
      validator: (value) {
        if (value == null || value.isEmpty) return "Required Field";
        return null;
      },
    );
  }
}
