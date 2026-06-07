import 'package:expense_tracker/Components/AuthScreenWidgets/AuthCommons.dart';
import 'package:expense_tracker/Models/User.dart';
import 'package:expense_tracker/Utils/Validators.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Passwdfield extends StatefulWidget {
  void Function(String?)? onSaved;
  bool forConformation;
  FocusNode focusNode;
  Passwdfield({
    this.onSaved,
    required this.focusNode,
    this.forConformation = false,
  });

  State<Passwdfield> createState() => _PasswdfieldState();
}

class _PasswdfieldState extends State<Passwdfield> {
  User? user;
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
          passwdKey.currentState!.validate();
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
    user = context.read<User>();
    Color onSurface = Theme.of(context).colorScheme.onSurface;

    return TextFormField(
      key: passwdKey,
      onFieldSubmitted: widget.onSaved,
      onChanged: (newValue) => user?.userPassword = newValue,
      validator: (!widget.forConformation)
          ? (value) => Validators.validPassword(value!.trim())
          : (value) => Validators.validConformPassword(
              value!.trim(),
              user!.userPassword.trim(),
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
