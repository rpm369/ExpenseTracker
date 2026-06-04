import 'package:expense_tracker/Components/FirstScreenWidgets/HomePage/BalanceCard.dart';
import 'package:expense_tracker/Components/FirstScreenWidgets/HomePage/ListSearchField.dart';
import 'package:expense_tracker/Components/FirstScreenWidgets/TransactionList.dart';
import 'package:expense_tracker/Database/DummyTransactions.dart';
import 'package:expense_tracker/Utils/UIUtils.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _pageHeader(context),
          SizedBox(height: 20),
          StackedBalanceCard(totalIncome: 1000, expense: 200, income: 800),
          SizedBox(height: 20),
          _listText(title: "Recent Transactions"),
          SizedBox(height: 5),
          Expanded(child: TransactionList(data: dummyTransactions)),
        ],
      ),
    );
  }

  Widget _listText({String title = "null"}) {
    return Text(
      title,
      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
    );
  }

  Widget _pageHeader(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: _buildHeadColumn(context)),
        _buildSearchIconButton(context),
      ],
    );
  }

  Widget _buildSearchIconButton(BuildContext context) {
    Color onSurface = Theme.of(context).colorScheme.onSurface;
    Color secondary = Theme.of(context).colorScheme.secondary;
    return ElevatedButton(
      onPressed: () {
        UiUtils.displayBottomSheet(
          sheetContent: ListSearchField(),
          context: context,
        );
      },
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(8),
        shape: CircleBorder(),
        backgroundColor: secondary,
      ),
      child: Icon(Icons.search, color: onSurface, size: 24),
    );
  }

  Widget _buildHeadColumn(BuildContext context) {
    Color secondary = Theme.of(context).colorScheme.secondary;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Hello,", style: TextStyle(color: secondary, fontSize: 20)),
        Text(
          "Gautam Jangid",
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
