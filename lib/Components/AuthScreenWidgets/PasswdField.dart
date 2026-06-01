import 'package:expense_tracker/Components/AuthScreenWidgets/AuthCommons.dart';
import 'package:expense_tracker/Utils/AuthValidators.dart';
import 'package:flutter/material.dart';

class Passwdfield extends StatefulWidget {
  GlobalKey<FormFieldState>? passwdKey;
  TextEditingController controller;
  void Function(String?)? onSaved;
  FocusNode focusNode;
  TextEditingController? passFieldController;
  Passwdfield({
    this.onSaved,
    this.passwdKey,
    this.passFieldController,
    required this.focusNode,
    required this.controller,
  });

  State<Passwdfield> createState() => _PasswdfieldState();
}

class _PasswdfieldState extends State<Passwdfield> {
  bool isHidden = true;
  late VoidCallback listener;

  @override
  void initState() {
    super.initState();
    listener = () {
      if (!widget.focusNode.hasFocus) {
        if (widget.controller.text.isNotEmpty)
          widget.passwdKey?.currentState!.validate();
      } else {
        widget.passwdKey?.currentState!.clearError();
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
      key: widget.passwdKey,
      onFieldSubmitted: widget.onSaved,
      validator: (widget.passFieldController == null)
          ? AuthValidators.validPassword
          : (value) => AuthValidators.validConformPassword(
              value,
              widget.passFieldController!.text,
            ),
      controller: widget.controller,
      cursorColor: onSurface,
      focusNode: widget.focusNode,
      style: TextStyle(fontSize: 16),
      obscureText: isHidden,
      decoration: AuthCommons.inputFieldDecoration(
        hintText: (widget.passFieldController != null)
            ? "Conform Password"
            : "Password",
        prefixIcon: Icons.password,
        onSurface: onSurface,
        isTextHidden: (widget.focusNode.hasFocus == true) ? isHidden : null,
        changeVisibility: changeVisibility,
      ),
    );
  }
}
