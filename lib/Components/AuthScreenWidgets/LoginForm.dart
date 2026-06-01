import 'package:expense_tracker/Components/AuthScreenWidgets/AuthButton.dart';
import 'package:expense_tracker/Components/AuthScreenWidgets/AuthCommons.dart';
import 'package:expense_tracker/Components/AuthScreenWidgets/EmailField.dart';
import 'package:expense_tracker/Components/AuthScreenWidgets/PasswdField.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwdController = TextEditingController();

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
        SizedBox(height: 20),
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

    return Form(
      key: formKey,
      child: Column(
        spacing: 15,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          EmailField(
            emailkey: emailKey,
            node: emailNode,
            controller: emailController,
            onSaved: (_) => passwdNode.requestFocus(),
          ),
          Passwdfield(
            focusNode: passwdNode,
            controller: passwdController,
            passwdKey: passwdKey,
          ),
          SizedBox(height: 10),
          AuthButton(isForSignUp: false, isLoading: false, onTap: () {}),
        ],
      ),
    );
  }
}
