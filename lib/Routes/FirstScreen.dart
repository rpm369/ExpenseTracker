import 'package:expense_tracker/Components/FirstScreenWidgets/BalancePage/BalancePage.dart';
import 'package:expense_tracker/Components/FirstScreenWidgets/HomePage/NewTransactionForm.dart';
import 'package:expense_tracker/Components/FirstScreenWidgets/HomePage/HomePage.dart';
import 'package:expense_tracker/Components/FirstScreenWidgets/StatsPage/StatsPage.dart';
import 'package:expense_tracker/Utils/UIUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  List<Widget> pages = [HomePage(), StatsPage(), BalancePage()];
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    Color bgColor = Theme.of(context).colorScheme.primary;
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(child: pages[pageIndex]),
      bottomNavigationBar: _buildBottomNavigationBar(),
      floatingActionButton: (pageIndex == 0)
          ? _buildFloatingActionButton()
          : null,
    );
  }

  Widget? _buildFloatingActionButton() {
    Color surface = Theme.of(context).colorScheme.surface;
    Color primary = Theme.of(context).colorScheme.primary;
    return FloatingActionButton(
      onPressed: () {
        UiUtils.displayBottomSheet(
          sheetContent: NewTransactionForm(),
          context: context,
        );
      },
      shape: CircleBorder(eccentricity: 0.5),
      child: Icon(Icons.add, size: 35, color: surface),
      backgroundColor: Colors.deepOrange,
    );
  }

  Widget? _buildBottomNavigationBar() {
    Color surface = Theme.of(context).colorScheme.surface;
    Color onSurface = Theme.of(context).colorScheme.onSurface;
    Color primary = Theme.of(context).colorScheme.secondary;

    return SnakeNavigationBar.color(
      snakeShape: SnakeShape.indicator,
      backgroundColor: surface,
      snakeViewColor: onSurface,
      selectedItemColor: Colors.deepOrange,
      unselectedItemColor: primary,
      currentIndex: pageIndex,
      onTap: (newIndex) {
        setState(() {
          pageIndex = newIndex;
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home, size: 35),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bar_chart_rounded, size: 35),
          label: "Stats",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_balance_wallet_outlined, size: 35),
          label: "Balance",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline_sharp, size: 35),
          label: "Profile",
        ),
      ],
    );
  }
}
