import 'package:expense_tracker/Components/AuthScreenWidgets/AuthCommons.dart';
import 'package:expense_tracker/Models/User.dart';
import 'package:expense_tracker/Utils/AuthValidators.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmailField extends StatefulWidget {
  FocusNode node;
  void Function(String?)? onSaved;

  EmailField({required this.node, this.onSaved});

  @override
  State<EmailField> createState() => _EmailFieldState();
}

class _EmailFieldState extends State<EmailField> {
  User? user;
  late VoidCallback listener;
  TextEditingController controller = TextEditingController();
  GlobalKey<FormFieldState> emailkey = GlobalKey();

  void initState() {
    super.initState();
    listener = () {
      if (!widget.node.hasFocus) {
        if (controller.text.isNotEmpty) {
          bool isValid = emailkey.currentState!.validate();
          if (isValid) user?.userEmail = controller.text;
        }
      } else {
        emailkey.currentState!.clearError();
      }
    };
    widget.node.addListener(listener);
  }

  Widget build(BuildContext context) {
    user = context.read<User>();
    Color onSurface = Theme.of(context).colorScheme.onSurface;
    return TextFormField(
      key: emailkey,
      controller: controller,
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
