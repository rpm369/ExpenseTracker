import 'package:expense_tracker/Models/User.dart';
import 'package:expense_tracker/Utils/UIUtils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditNameField extends StatelessWidget {
  FocusNode node;
  TextEditingController? controller;
  GlobalKey<FormFieldState> formTextkey = GlobalKey();
  User? user;

  EditNameField({required this.node}) {
    node.addListener(() {
      if (!node.hasFocus) {
        if (controller!.text.isEmpty)
          formTextkey.currentState!.validate();
        else
          user?.userName = controller?.text;
      } else {
        formTextkey.currentState!.clearError();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    user = context.read<User>();
    controller = TextEditingController(text: user?.userName);

    return UiUtils.FormTextField(
      key: formTextkey,
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
