import 'package:expense_tracker/Components/FirstScreenWidgets/HomePage/FormHeader.dart';
import 'package:expense_tracker/Components/FirstScreenWidgets/TransactionList.dart';
import 'package:expense_tracker/Database/DummyData.dart';
import 'package:expense_tracker/Models/Transaction.dart';
import 'package:expense_tracker/Utils/DateTimeUtils.dart';
import 'package:expense_tracker/Utils/UIUtils.dart';
import 'package:flutter/material.dart';

class ListSearchField extends StatelessWidget {
  ValueNotifier<List<Transaction>> buffer = ValueNotifier(dummyData);

  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: Column(
        children: [
          FormHeader(title: "Search"),
          SizedBox(height: 15),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 15),
              children: [
                _searchField(context: context),
                ValueListenableBuilder(
                  valueListenable: buffer,
                  builder: (_, data, _) {
                    return TransactionList(data: data, isScrollable: false);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _searchField({required BuildContext context}) {
    Color onSurface = Theme.of(context).colorScheme.primary;
    return UiUtils.FormTextField(
      context: context,
      hintText: "Keyword",
      onChange: searchQuery,
    );
  }

  void searchQuery(String query) {
    query = query.toLowerCase();

    if (query.isEmpty) {
      buffer.value = dummyData;
      return;
    }

    buffer.value = dummyData.where((transaction) {
      String category = transaction.category.id.toLowerCase();
      String title = transaction.title.toLowerCase();
      String amount = transaction.amount.toString().toLowerCase();
      String date = DateTimeUtils.listTimeFormat(
        dateTime: transaction.dateTime,
      ).toLowerCase();

      print(date);

      return (category.contains(query) ||
          title.contains(query) ||
          amount.contains(query) ||
          date.contains(query));
    }).toList();
  }
}
