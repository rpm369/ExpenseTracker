import 'package:expense_tracker/Utils/UIUtils.dart';
import 'package:expense_tracker/Utils/Validators.dart';
import 'package:flutter/material.dart';

class TitleField extends StatelessWidget {
  FocusNode node;
  void Function(String) callBack;
  void Function(String?)? onSave;
  GlobalKey<FormFieldState> fieldKey = GlobalKey();
  TextEditingController controller = TextEditingController();

  TitleField({required this.node, this.onSave, required this.callBack}) {
    node.addListener(() {
      if (!node.hasFocus) {
        if (controller.text.isNotEmpty) {
          bool status = fieldKey.currentState!.validate();
          if (status) callBack(controller.text.trim());
        }
      } else {
        fieldKey.currentState!.clearError();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Color onSurface = Theme.of(context).colorScheme.onSurface;
    return UiUtils.FormTextField(
      key: fieldKey,
      onSaved: onSave,
      validator: Validators.requiredField,
      context: context,
      hintText: "e.g Electricity Bill",
      node: node,
      controller: controller,
    );
  }
}
