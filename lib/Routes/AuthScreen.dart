import 'package:expense_tracker/Components/AuthScreenWidgets/LoginForm.dart';
import 'package:expense_tracker/Components/AuthScreenWidgets/SignupForm.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  List<Widget> authForms = [LoginForm(), SignupForm()];
  int formIndex = 0;

  void switchAuthType() {
    setState(() {
      formIndex = 1 - formIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    Color bgColor = Theme.of(context).colorScheme.primary;
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 15,
                children: [
                  AnimatedSwitcher(
                    duration: Duration(milliseconds: 400),
                    transitionBuilder: (child, animation) {
                      final offsetAnimation = Tween(
                        begin: Offset(0.1, 0),
                        end: Offset.zero,
                      ).animate(animation);
      
                      return FadeTransition(
                        opacity: animation,
                        child: SlideTransition(
                          position: offsetAnimation,
                          child: child,
                        ),
                      );
                    },
                    child: authForms[formIndex],
                  ),
                  _buildFooterText(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFooterText() {
    String firstVersion = (formIndex == 0)
        ? "Don't have an account?"
        : "Already a user ?";
    String secondVersion = (formIndex == 0) ? "Sign Up" : "Log In";

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 0,
      children: [
        _unitText(
          text: firstVersion,
          color: Theme.of(context).colorScheme.secondary,
        ),
        TextButton(
          style: ButtonStyle(
            padding: WidgetStatePropertyAll(EdgeInsetsGeometry.all(0)),
          ),
          onPressed: switchAuthType,
          child: _unitText(
            text: secondVersion,
            color: Colors.deepOrange,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _unitText({
    required String text,
    required Color color,
    FontWeight? fontWeight,
  }) {
    return Text(
      text,
      style: TextStyle(color: color, fontSize: 15, fontWeight: fontWeight),
    );
  }
}
