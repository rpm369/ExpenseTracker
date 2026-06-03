import 'package:expense_tracker/Components/FirstScreenWidgets/TransactionList.dart';
import 'package:flutter/material.dart';

class Screen404 extends StatefulWidget {
  const Screen404({super.key});

  @override
  State<Screen404> createState() => _Screen404State();
}

class _Screen404State extends State<Screen404> {
  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Theme.of(context).colorScheme.surface;

    return Scaffold(
      backgroundColor: backgroundColor,
      // body: Center(child: Image.asset('assets/Logos/404.png')),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          child: TransactionList(),
        ),
      ),
    );
  }
}
