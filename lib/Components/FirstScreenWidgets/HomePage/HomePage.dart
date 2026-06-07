import 'package:expense_tracker/Components/FirstScreenWidgets/HomePage/BalanceCard.dart';
import 'package:expense_tracker/Components/FirstScreenWidgets/HomePage/ListSearchField.dart';
import 'package:expense_tracker/Components/FirstScreenWidgets/TransactionList.dart';
import 'package:expense_tracker/Models/Transaction.dart';
import 'package:expense_tracker/Services/UserService.dart';
import 'package:expense_tracker/Utils/UIUtils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  ValueNotifier<List<Transaction>?> transactionList = ValueNotifier(null);

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
          StackedBalanceCard(),
          SizedBox(height: 20),
          _listText(title: "Recent Transactions"),
          SizedBox(height: 5),
          Expanded(child: TransactionList()),
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
    String? userName = context.read<UserService>().getActiveUser().userName;

    Color secondary = Theme.of(context).colorScheme.secondary;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Hello,", style: TextStyle(color: secondary, fontSize: 20)),
        Text(
          userName ?? "Unknown",
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
