import 'package:expense_tracker/Components/FirstScreenWidgets/TransactionTile.dart';
import 'package:expense_tracker/Models/Transaction.dart';

import 'package:flutter/material.dart';

class SearchableList extends StatelessWidget {
  List<Transaction> data;
  SearchableList({required this.data});

  @override
  Widget build(BuildContext context) {
    return _staticList();
  }

  Widget _staticList() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: data
          .map((model) => TransactionTile(transaction: model))
          .toList(),
    );
  }
}
