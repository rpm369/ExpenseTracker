import 'package:expense_tracker/Utils/UIUtils.dart';
import 'package:expense_tracker/Utils/Validators.dart';
import 'package:flutter/material.dart';

class TitleField extends StatefulWidget {
  final FocusNode node;
  final void Function(String) callBack;
  final void Function(String?)? onSave;

  const TitleField({
    super.key,
    required this.node,
    this.onSave,
    required this.callBack,
  });

  @override
  State<TitleField> createState() => _TitleFieldState();
}

class _TitleFieldState extends State<TitleField> {
  final GlobalKey<FormFieldState> fieldKey = GlobalKey();
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    widget.node.addListener(_focusListener);
  }

  void _focusListener() {
    if (!widget.node.hasFocus) {
      if (controller.text.isNotEmpty) {
        fieldKey.currentState?.validate();
      }
    } else {
      fieldKey.currentState?.clearError();
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
      key: fieldKey,
      onSaved: widget.onSave,
      onChange: (value) => widget.callBack(value.trim()),
      validator: Validators.requiredField,
      context: context,
      hintText: "e.g Electricity Bill",
      node: widget.node,
      controller: controller,
    );
  }
}
