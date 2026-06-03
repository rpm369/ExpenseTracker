import 'package:expense_tracker/Components/FirstScreenWidgets/TransactionTile.dart';
import 'package:expense_tracker/Models/Transaction.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  bool isScrollable;
  List<Transaction> data;
  TransactionList({this.isScrollable = true, required this.data});

  @override
  Widget build(BuildContext context) {
    return (isScrollable) ? _scrollableList() : _staticList();
  }

  Widget _staticList() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: data
          .map((model) => TransactionTile(transaction: model))
          .toList(),
    );
  }

  Widget _scrollableList() {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return TransactionTile(transaction: data[index]);
      },
    );
  }
}
