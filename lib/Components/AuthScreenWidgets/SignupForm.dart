import 'package:expense_tracker/Components/AuthScreenWidgets/AuthButton.dart';
import 'package:expense_tracker/Components/AuthScreenWidgets/AuthCommons.dart';
import 'package:expense_tracker/Components/AuthScreenWidgets/EmailField.dart';
import 'package:expense_tracker/Components/AuthScreenWidgets/PasswdField.dart';
import 'package:expense_tracker/Models/User.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  User user = User(userEmail: "", userPassword: "");

  FocusNode emailNode = FocusNode();
  FocusNode passwdNode = FocusNode();
  FocusNode conformPasswdNode = FocusNode();

  GlobalKey<FormState> formKey = GlobalKey();

  Widget build(BuildContext context) {
    Color secondaryColor = Theme.of(context).colorScheme.secondary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AuthCommons.formTitle(txt: "Welcome on Board !\n"),
        SizedBox(height: 10),
        AuthCommons.formSubtitle(
          txt: "Sign up now to begin expense tracking.",
          txtColor: secondaryColor,
        ),
        SizedBox(height: 10),
        Provider(create: (_) => user, child: _buildForm()),
      ],
    );
  }

  Widget _buildForm() {
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
          Passwdfield(
            focusNode: passwdNode,
            forConformation: false,
            onSaved: (_) => conformPasswdNode.requestFocus(),
          ),
          Passwdfield(forConformation: true, focusNode: conformPasswdNode),
          SizedBox(height: 10),
          AuthButton(isForSignUp: true, isLoading: false),
        ],
      ),
    );
  }
}
