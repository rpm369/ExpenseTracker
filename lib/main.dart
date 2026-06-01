import 'package:expense_tracker/Routes/FirstScreen.dart';
import 'package:expense_tracker/Routes/AuthScreen.dart';
import 'package:expense_tracker/Routes/Screen404.dart';
import 'package:expense_tracker/Themes/ThemeProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Themeprovider.getTheme(true),
      onGenerateRoute: onGenerateRoute,
      initialRoute: "/",
    );
  }

  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    String? routeName = settings.name;
    Object? argument = settings.arguments;

    switch (routeName) {
      case '/':
        return CupertinoPageRoute(builder: (context) => AuthScreen());
      case '/firstScreen':
        return CupertinoPageRoute(builder: (context) => FirstScreen());
      default:
        return MaterialPageRoute(builder: (context) => Screen404());
    }
  }
}
