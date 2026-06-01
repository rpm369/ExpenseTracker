import 'package:expense_tracker/Components/AuthScreenWidgets/AuthButton.dart';
import 'package:expense_tracker/Components/AuthScreenWidgets/AuthCommons.dart';
import 'package:expense_tracker/Components/AuthScreenWidgets/EmailField.dart';
import 'package:expense_tracker/Components/AuthScreenWidgets/PasswdField.dart';
import 'package:flutter/material.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController conformPasswdController = TextEditingController();

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
            controller: passwordController,
            passwdKey: passwdKey,
            onSaved: (_) => conformPasswdNode.requestFocus(),
          ),
          Passwdfield(
            passFieldController: passwordController,
            passwdKey: conformPasswdKey,
            focusNode: conformPasswdNode,
            controller: conformPasswdController,
          ),
          SizedBox(height: 10),
          AuthButton(isForSignUp: true, isLoading: false, onTap: () {}),
        ],
      ),
    );
  }
}
