import 'package:flutter/material.dart';

class AuthButton extends StatefulWidget {
  bool isForSignUp;
  bool isLoading;
  VoidCallback onTap;

  AuthButton({
    required this.isForSignUp,
    required this.onTap,
    required this.isLoading,
  });
  @override
  State<AuthButton> createState() => _AuthButtonState();
}

class _AuthButtonState extends State<AuthButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 7),
        decoration: BoxDecoration(
          color: Colors.deepOrange,
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.center,
        child: (widget.isLoading) ? CircularProgressIndicator() : _buildText(),
      ),
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
