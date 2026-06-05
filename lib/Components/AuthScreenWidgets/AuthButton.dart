import 'package:expense_tracker/Errors.dart';
import 'package:expense_tracker/Models/User.dart';
import 'package:expense_tracker/Services/AuthService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthButton extends StatefulWidget {
  bool isForSignUp;
  GlobalKey<FormState>? formKey;

  AuthButton({required this.isForSignUp, this.formKey});
  @override
  State<AuthButton> createState() => _AuthButtonState();
}

class _AuthButtonState extends State<AuthButton> {
  bool isLoading = false;

  Future<void> _handleLogIn() async {
    bool status = await AuthService.logIn(user: context.read<User>());
    if (status)
      Navigator.pushReplacementNamed(context, '/firstScreen');
    else
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(seconds: 3),
          content: Text(
            "Invalid Credentials",
            style: TextStyle(color: Colors.black),
          ),
        ),
      );
  }

  Future<void> _handleSignIn() async {
    try {
      await AuthService.signUp(user: context.read<User>());
      Navigator.pushReplacementNamed(context, '/firstScreen');
    } on DuplicateEntityException {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(seconds: 3),
          content: Text(
            "User already exist",
            style: TextStyle(color: Colors.black),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        bool didFormValidate = widget.formKey?.currentState!.validate() ?? true;
        if (isLoading || !didFormValidate) return;

        setState(() {
          isLoading = true;
        });

        if (widget.isForSignUp)
          await _handleSignIn();
        else
          await _handleLogIn();

        setState(() {
          isLoading = false;
        });
      },
      child: _buildButton(),
    );
  }

  Widget _buildButton() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 7),
      decoration: BoxDecoration(
        color: Colors.deepOrange,
        borderRadius: BorderRadius.circular(12),
      ),
      alignment: Alignment.center,
      child: (isLoading) ? CircularProgressIndicator() : _buildText(),
    );
  }

  Widget _buildText() {
    Color primary = Theme.of(context).colorScheme.primary;
    return Text(
      (widget.isForSignUp) ? "Signup" : "Login",
      style: TextStyle(
        color: primary,
        fontSize: 28,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
