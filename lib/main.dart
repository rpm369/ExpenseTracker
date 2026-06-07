import 'package:expense_tracker/Database/SystemDb.dart';
import 'package:expense_tracker/Database/UserDb.dart';
import 'package:expense_tracker/Models/ExpenseCategory.dart';
import 'package:expense_tracker/Models/ExpenseType.dart';
import 'package:expense_tracker/Models/Transaction.dart';
import 'package:expense_tracker/Models/User.dart';
import 'package:expense_tracker/Models/Wallet.dart';
import 'package:expense_tracker/Routes/FirstScreen.dart';
import 'package:expense_tracker/Routes/AuthScreen.dart';
import 'package:expense_tracker/Routes/Screen404.dart';
import 'package:expense_tracker/Services/TransactionServices.dart';
import 'package:expense_tracker/Services/UserService.dart';
import 'package:expense_tracker/Services/WalletServices.dart';
import 'package:expense_tracker/Themes/ThemeProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(TransactionAdapter());
  Hive.registerAdapter(WalletAdapter());
  Hive.registerAdapter(ExpenseCategoryAdapter());
  Hive.registerAdapter(ExpenseTypeAdapter());

  SystemDb systemDb = await SystemDb.getDatabase();
  await UserDb.loadDb();

  bool isUserActive = await systemDb.isUserActive();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => systemDb),
        ChangeNotifierProvider(create: (_) => UserService()),
        ChangeNotifierProvider(create: (_) => WalletServices()),
        ChangeNotifierProvider(create: (_) => TransactionServices()),
      ],
      child: MyApp(isUserActive), //bad practice
    ),
  );
}

class MyApp extends StatelessWidget {
  bool isUserActive;
  MyApp(this.isUserActive);
  @override
  Widget build(BuildContext context) {
    SystemDb systemDb = context.watch<SystemDb>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Themeprovider.getTheme(isDark: systemDb.isDarkModeEnabled()),
      onGenerateRoute: onGenerateRoute,
      initialRoute: (isUserActive) ? '/firstScreen' : '/',
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
