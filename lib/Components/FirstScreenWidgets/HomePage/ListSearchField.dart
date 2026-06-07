import 'package:expense_tracker/Components/FirstScreenWidgets/FormHeader.dart';
import 'package:expense_tracker/Components/FirstScreenWidgets/SearchableList.dart';

import 'package:expense_tracker/Models/Transaction.dart';
import 'package:expense_tracker/Services/TransactionServices.dart';
import 'package:expense_tracker/Utils/DateTimeUtils.dart';
import 'package:expense_tracker/Utils/UIUtils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListSearchField extends StatefulWidget {
  @override
  State<ListSearchField> createState() => _ListSearchFieldState();
}

class _ListSearchFieldState extends State<ListSearchField> {
  List<Transaction>? originalList;
  List<Transaction>? buffer;

  bool isLoading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    isLoading = true;
    context.watch<TransactionServices>().fetchAllTransactions().then((list) {
      setState(() {
        buffer = list;
        originalList = list;
        isLoading = false;
      });
    });
  }

  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: (isLoading)
          ? Center(child: CircularProgressIndicator(color: Colors.blue))
          : _buildSearchableList(),
    );
  }

  Widget _buildSearchableList() {
    return Column(
      children: [
        FormHeader(title: "Search"),
        SizedBox(height: 15),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 15),
            children: [
              _searchField(context: context),
              SearchableList(data: buffer!),
            ],
          ),
        ),
      ],
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
      setState(() {
        buffer = originalList;
      });
      return;
    }

    List<Transaction> filteredList = originalList!.where((transaction) {
      String category = transaction.category.id.toLowerCase();
      String title = transaction.title.toLowerCase();
      String amount = transaction.amount.toString().toLowerCase();
      String date = DateTimeUtils.listTimeFormat(
        dateTime: transaction.dateTime,
      ).toLowerCase();

      return (category.contains(query) ||
          title.contains(query) ||
          amount.contains(query) ||
          date.contains(query));
    }).toList();

    setState(() {
      buffer = filteredList;
    });
  }
}
