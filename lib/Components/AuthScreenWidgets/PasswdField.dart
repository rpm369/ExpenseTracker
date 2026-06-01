import 'package:expense_tracker/Components/AuthScreenWidgets/AuthCommons.dart';
import 'package:flutter/material.dart';

class Passwdfield extends StatefulWidget {
  FocusNode? focusNode;
  Passwdfield({this.focusNode});

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
      style: TextStyle(fontSize: 20),
      obscureText: isHidden,
      decoration: AuthCommons.inputFieldDecoration(
        hintText: "Password",
        prefixIcon: Icons.password,
        onSurface: onSurface,
        isTextHidden: (widget.focusNode!.hasFocus == true) ? isHidden : null,
        changeVisibility: changeVisibility,
      ),
    );
  }
}
