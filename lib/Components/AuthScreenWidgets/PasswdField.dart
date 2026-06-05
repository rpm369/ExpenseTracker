import 'package:expense_tracker/Components/AuthScreenWidgets/AuthCommons.dart';
import 'package:expense_tracker/Models/User.dart';
import 'package:expense_tracker/Utils/AuthValidators.dart';
import 'package:flutter/material.dart';

class Passwdfield extends StatefulWidget {
  void Function(String?)? onSaved;
  bool forConformation;
  FocusNode focusNode;
  User user;
  Passwdfield({
    this.onSaved,
    required this.user,
    required this.focusNode,
    this.forConformation = false,
  });

  State<Passwdfield> createState() => _PasswdfieldState();
}

class _PasswdfieldState extends State<Passwdfield> {
  bool isHidden = true;
  late VoidCallback listener;
  GlobalKey<FormFieldState> passwdKey = GlobalKey();
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    listener = () {
      if (!widget.focusNode.hasFocus) {
        if (controller.text.isNotEmpty) {
          bool isValid = passwdKey.currentState!.validate();
          if (isValid && !widget.forConformation)
            widget.user.userPassword = controller.text;
        }
      } else {
        passwdKey?.currentState!.clearError();
      }
      setState(() {});
    };

    widget.focusNode.addListener(listener);
  }

  @override
  void dispose() {
    widget.focusNode.removeListener(listener);
    super.dispose();
  }

  void changeVisibility() {
    setState(() {
      isHidden = !isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    Color onSurface = Theme.of(context).colorScheme.onSurface;

    return TextFormField(
      key: passwdKey,
      onFieldSubmitted: widget.onSaved,
      validator: (!widget.forConformation)
          ? AuthValidators.validPassword
          : (value) => AuthValidators.validConformPassword(
              value,
              widget.user.userPasswd,
            ),
      controller: controller,
      cursorColor: onSurface,
      focusNode: widget.focusNode,
      style: TextStyle(fontSize: 16),
      obscureText: isHidden,
      decoration: AuthCommons.inputFieldDecoration(
        hintText: (widget.forConformation) ? "Conform Password" : "Password",
        prefixIcon: Icons.password,
        onSurface: onSurface,
        isTextHidden: (widget.focusNode.hasFocus == true) ? isHidden : null,
        changeVisibility: changeVisibility,
      ),
    );
  }
}
