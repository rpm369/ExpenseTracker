import 'package:expense_tracker/Components/FirstScreenWidgets/TransactionTile.dart';
import 'package:expense_tracker/Database/DummyData.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  bool isScrollable;
  TransactionList({this.isScrollable = true});

  @override
  Widget build(BuildContext context) {
    return (isScrollable) ? _scrollableList() : _staticList();
  }

  Widget _staticList() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: dummyData
          .map((model) => TransactionTile(transaction: model))
          .toList(),
    );
  }

  Widget _scrollableList() {
    return ListView.builder(
      itemCount: dummyData.length,
      itemBuilder: (context, index) {
        return TransactionTile(transaction: dummyData[index]);
      },
    );
  }
}
