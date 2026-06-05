import 'package:expense_tracker/Database/SystemDb.dart';
import 'package:expense_tracker/Routes/FirstScreen.dart';
import 'package:expense_tracker/Routes/AuthScreen.dart';
import 'package:expense_tracker/Routes/Screen404.dart';
import 'package:expense_tracker/Themes/ThemeProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemDb systemDb = await SystemDb.getDatabase();

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => systemDb)],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemDb systemDb = context.watch<SystemDb>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Themeprovider.getTheme(isDark: systemDb.isDarkModeEnabled()),
      onGenerateRoute: onGenerateRoute,
      initialRoute: (systemDb.isUserActive()) ? '/firstScreen' : '/',
    );
  }

  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    String? routeName = settings.name;

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
