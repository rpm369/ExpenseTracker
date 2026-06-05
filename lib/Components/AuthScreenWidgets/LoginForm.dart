import 'package:expense_tracker/Components/AuthScreenWidgets/AuthButton.dart';
import 'package:expense_tracker/Components/AuthScreenWidgets/AuthCommons.dart';
import 'package:expense_tracker/Components/AuthScreenWidgets/EmailField.dart';
import 'package:expense_tracker/Components/AuthScreenWidgets/PasswdField.dart';
import 'package:expense_tracker/Models/User.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatefulWidget {
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  User user = User(userEmail: "", userName: "", userPassword: "");

  FocusNode emailNode = FocusNode();
  FocusNode passwdNode = FocusNode();

  GlobalKey<FormState> formKey = GlobalKey();

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
        Provider(create: (_) => user, child: _buildForm()),
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
            node: emailNode,
            onSaved: (_) => passwdNode.requestFocus(),
          ),
          Passwdfield(focusNode: passwdNode),
          SizedBox(height: 10),
          AuthButton(
            isForSignUp: false,
            canProceedcallBack: () {
              _unfocusNodes();
              return formKey.currentState!.validate();
            },
          ),
        ],
      ),
    );
  }

  void _unfocusNodes() {
    if (emailNode.hasFocus) emailNode.unfocus();
    if (passwdNode.hasFocus) passwdNode.unfocus();
  }
}
