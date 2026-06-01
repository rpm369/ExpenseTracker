import 'package:expense_tracker/Components/AuthScreenWidgets/AuthCommons.dart';
import 'package:flutter/material.dart';

class Passwdfield extends StatefulWidget {
  FocusNode? focusNode;
  String? hintText;
  Passwdfield({required this.focusNode, this.hintText = 'Password'});

  State<Passwdfield> createState() => _PasswdfieldState();
}

class _PasswdfieldState extends State<Passwdfield> {
  bool isHidden = true;

  @override
  void initState() {
    widget.focusNode!.addListener(() {
      setState(() {});
    });
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
      cursorColor: onSurface,
      focusNode: widget.focusNode,
      style: TextStyle(fontSize: 16),
      obscureText: isHidden,
      decoration: AuthCommons.inputFieldDecoration(
        hintText: widget.hintText!,
        prefixIcon: Icons.password,
        onSurface: onSurface,
        isTextHidden: (widget.focusNode!.hasFocus == true) ? isHidden : null,
        changeVisibility: changeVisibility,
      ),
    );
  }
}
