import 'package:expense_tracker/Models/User.dart';
import 'package:expense_tracker/Utils/UIUtils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditNameField extends StatefulWidget {
  final FocusNode node;

  const EditNameField({super.key, required this.node});

  @override
  State<EditNameField> createState() => _EditNameFieldState();
}

class _EditNameFieldState extends State<EditNameField> {
  final GlobalKey<FormFieldState> formTextkey = GlobalKey();
  late final TextEditingController controller;
  late final User user;

  @override
  void initState() {
    super.initState();
    user = context.read<User>();
    controller = TextEditingController(text: user.userName);
    widget.node.addListener(_focusListener);
  }

  void _focusListener() {
    if (!widget.node.hasFocus) {
      if (controller.text.isEmpty) {
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
      onChange: (value) => user.userName = value,
      validator: (value) {
        if (value == null || value.isEmpty) return "Required Field";
        return null;
      },
    );
  }
}
