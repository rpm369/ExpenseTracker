import 'package:expense_tracker/Components/AuthScreenWidgets/AuthCommons.dart';
import 'package:expense_tracker/Components/AuthScreenWidgets/PasswdField.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  FocusNode emailNode = FocusNode();
  FocusNode passwdNode = FocusNode();

  GlobalKey<FormState> formKey = GlobalKey();
  GlobalKey<FormFieldState> emailKey = GlobalKey();
  GlobalKey<FormFieldState> passwdKey = GlobalKey();

  Widget build(BuildContext context) {
    Color secondaryColor = Theme.of(context).colorScheme.secondary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AuthCommons.formTitle(txt: "Hey,\nWelcome Back"),
        SizedBox(height: 10),
        AuthCommons.formSubtitle(
          txt: "Login now to track all your expenses",
          txtColor: secondaryColor,
        ),
        SizedBox(height: 10),
        _buildForm(),
      ],
    );
  }

  Widget _buildForm() {
    Color onSurface = Theme.of(context).colorScheme.onSurface;
    Color primary = Theme.of(context).colorScheme.primary;

    return Form(
      key: formKey,
      child: Column(
        spacing: 15,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          AuthCommons.emailField(
            onSurface: onSurface,
            key: emailKey,
            node: emailNode,
          ),
          Passwdfield(focusNode: passwdNode),
          _forgetPasswdTxt(onSurface: onSurface),
          AuthCommons.authButton(primary: primary, isSignUp: false),
        ],
      ),
    );
  }

  Widget _forgetPasswdTxt({required Color onSurface}) {
    return Text("Forgot Password ?", style: TextStyle(color: onSurface));
  }
}
