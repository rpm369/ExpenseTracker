import 'package:expense_tracker/Components/AuthScreenWidgets/AuthCommons.dart';
import 'package:expense_tracker/Components/AuthScreenWidgets/PasswdField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  FocusNode emailNode = FocusNode();
  FocusNode passwdNode = FocusNode();
  FocusNode conformPasswdNode = FocusNode();

  GlobalKey<FormState> formKey = GlobalKey();
  GlobalKey<FormFieldState> emailKey = GlobalKey();
  GlobalKey<FormFieldState> passwdKey = GlobalKey();
  GlobalKey<FormFieldState> conformPasswdKey = GlobalKey();

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
          Passwdfield(
            focusNode: conformPasswdNode,
            hintText: "Conform Password",
          ),
          SizedBox(height: 10),
          AuthCommons.authButton(primary: primary, isSignUp: true),
        ],
      ),
    );
  }
}
