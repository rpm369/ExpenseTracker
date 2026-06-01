import 'package:expense_tracker/Components/AuthScreenWidgets/AuthCommons.dart';
import 'package:expense_tracker/Utils/AuthValidators.dart';

import 'package:flutter/material.dart';

class EmailField extends StatefulWidget {
  TextEditingController controller;
  GlobalKey<FormFieldState> emailkey;
  FocusNode node;
  void Function(String?)? onSaved;

  EmailField({
    required this.emailkey,
    required this.controller,
    required this.node,
    this.onSaved,
  });

  @override
  State<EmailField> createState() => _EmailFieldState();
}

class _EmailFieldState extends State<EmailField> {
  late VoidCallback listener;

  void initState() {
    super.initState();
    listener = () {
      if (!widget.node.hasFocus) {
        if (widget.controller.text.isNotEmpty)
          widget.emailkey.currentState!.validate();
      } else {
        widget.emailkey.currentState!.clearError();
      }
    };
    widget.node.addListener(listener);
  }

  Widget build(BuildContext context) {
    Color onSurface = Theme.of(context).colorScheme.onSurface;
    return TextFormField(
      key: widget.emailkey,
      controller: widget.controller,
      validator: AuthValidators.validateMail,
      onFieldSubmitted: widget.onSaved,
      cursorColor: onSurface,
      focusNode: widget.node,
      style: TextStyle(fontSize: 16),
      decoration: AuthCommons.inputFieldDecoration(
        prefixIcon: Icons.mail,
        hintText: "Email",
        onSurface: onSurface,
      ),
    );
  }

  @override
  void dispose() {
    widget.node.removeListener(listener);
    super.dispose();
  }
}
